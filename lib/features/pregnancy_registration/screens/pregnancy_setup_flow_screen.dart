import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';

class PregnancySetupFlowScreen extends StatefulWidget {
  const PregnancySetupFlowScreen({super.key});

  @override
  State<PregnancySetupFlowScreen> createState() => _PregnancySetupFlowScreenState();
}

class _PregnancySetupFlowScreenState extends State<PregnancySetupFlowScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  DateTime? _selectedEDD;
  DateTime? _selectedLMP;
  
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  void _nextStep() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  
  void _savePregnancy(BuildContext context, DateTime edd) {
    final authBloc = context.read<AuthBloc>();
    if (authBloc.state is AuthAuthenticated) {
      final user = (authBloc.state as AuthAuthenticated).user;
      
      // Calculate weeks based on EDD
      final now = DateTime.now();
      final differenceDays = edd.difference(now).inDays;
      // Normal pregnancy is 280 days (40 weeks)
      // So days passed = 280 - differenceDays
      final daysPassed = 280 - differenceDays;
      int weeks = daysPassed ~/ 7;
      if (weeks < 1) weeks = 1;
      if (weeks > 42) weeks = 42;
      
      final updatedUser = user.copyWith(pregnancyWeeks: weeks);
      authBloc.add(AuthProfileUpdated(updatedUser: updatedUser));
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('গর্ভধারণ সফলভাবে যুক্ত হয়েছে!'),
          backgroundColor: AppColors.success,
        ),
      );
      
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context, {required bool isLMP}) async {
    final initialDate = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year - 1),
      lastDate: DateTime(initialDate.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isLMP) {
          _selectedLMP = picked;
          _selectedEDD = picked.add(const Duration(days: 280)); // Naive EDD calculation
        } else {
          _selectedEDD = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey.shade700),
          onPressed: () {
            if (_currentStep > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (idx) {
          setState(() {
            _currentStep = idx;
          });
        },
        children: [
          _buildStep1EDD(),
          _buildStep2LMP(),
        ],
      ),
    );
  }

  Widget _buildStep1EDD() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Placeholder for the illustration
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.pregnant_woman_rounded,
                      size: 100,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'স্বাগতম!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1030),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'যখন যে তথ্য জানা প্রয়োজন তা পেতে আপনার\nডেলিভারির সম্ভাব্য তারিখ দিন।',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ডেলিভারির সম্ভাব্য তারিখ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1030),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _selectDate(context, isLMP: false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F6F8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedEDD != null
                                      ? _dateFormat.format(_selectedEDD!)
                                      : 'সিলেক্ট করুন',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: _selectedEDD != null ? Colors.black : Colors.grey.shade600,
                                  ),
                                ),
                                Icon(Icons.calendar_today_outlined, size: 20, color: Colors.grey.shade600),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: _nextStep,
                    child: const Text(
                      'আমি ডেলিভারির সম্ভাব্য তারিখ জানি না',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4A7BD7),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedEDD != null ? () => _savePregnancy(context, _selectedEDD!) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8AB4F8), // Matching the image's light blue
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'পরবর্তী ধাপ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2LMP() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Placeholder for Calendar illustration
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.calendar_month,
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'আপনার সর্বশেষ মাসিক\nকবে শুরু হয়েছিলো?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1030),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => _selectDate(context, isLMP: true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedLMP != null
                                  ? _dateFormat.format(_selectedLMP!)
                                  : 'সিলেক্ট করুন',
                              style: TextStyle(
                                fontSize: 16,
                                color: _selectedLMP != null ? Colors.black : Colors.grey.shade600,
                              ),
                            ),
                            Icon(Icons.calendar_today_outlined, size: 20, color: Colors.grey.shade600),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  if (_selectedEDD != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'আপনার দেয়া তারিখ অনুযায়ী ডেলিভারির সম্ভাব্য সময়',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _dateFormat.format(_selectedEDD!),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1030),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {}, // Optional feature link
                      child: const Text(
                        'কিভাবে ডেলিভারির সম্ভাব্য তারিখ গণনা করা হয়?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4A7BD7),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedEDD != null ? () => _savePregnancy(context, _selectedEDD!) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E75D8), // Matching the image's dark blue
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'সেভ করুন',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
