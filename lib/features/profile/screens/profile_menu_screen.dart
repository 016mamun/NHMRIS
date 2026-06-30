import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/models/baby_model.dart';
import '../../auth/models/user_model.dart';

// Profile Menu Steps Enum
enum ProfileMenuStep {
  guardians,      // Step 1: Add guardians (gorvodharon jog)
  babyOptions,   // Step 2: After guardians - options for another baby, birth info
  addBaby,       // Step 3: Add baby profile
  guardianOptions, // Step 4: After baby - options to add more guardians or babies
}

// Guardian Type Enum
enum GuardianType {
  mother,
  father,
  other,
}

class ProfileMenuScreen extends StatefulWidget {
  const ProfileMenuScreen({super.key});

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  ProfileMenuStep _currentStep = ProfileMenuStep.guardians;
  GuardianType _selectedGuardianType = GuardianType.mother;
  
  // Guardian Info Controllers
  final TextEditingController _motherNameCtrl = TextEditingController();
  final TextEditingController _fatherNameCtrl = TextEditingController();
  String _motherDob = '';
  String _fatherDob = '';
  String _motherBloodGroup = '';
  String _fatherBloodGroup = '';
  
  // Baby Info Controllers
  final TextEditingController _babyNameCtrl = TextEditingController();
  String _babyGender = '';
  String _babyDob = '';
  bool _babyIsBorn = true;
  
  // Date format
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  
  // List to track added babies in this session
  final List<BabyModel> _sessionBabies = [];
  
  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }
  
  void _loadExistingData() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final user = authState.user;
      _motherNameCtrl.text = user.name;
      _fatherNameCtrl.text = user.husbandName ?? '';
      _motherDob = user.dob ?? '';
      _motherBloodGroup = user.bloodGroup ?? '';
    }
  }
  
  @override
  void dispose() {
    _motherNameCtrl.dispose();
    _fatherNameCtrl.dispose();
    _babyNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _getStepTitle(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_currentStep != ProfileMenuStep.guardians)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'স্কিপ',
                style: TextStyle(color: AppColors.primary, fontSize: 14),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Step Indicator
          _buildStepIndicator(),
          
          // Content
          Expanded(
            child: _buildCurrentStepContent(),
          ),
        ],
      ),
    );
  }
  
  String _getStepTitle() {
    switch (_currentStep) {
      case ProfileMenuStep.guardians:
        return 'গার্ভডিয়ান যোগ করুন';
      case ProfileMenuStep.babyOptions:
        return 'শিশুর তথ্য দিন';
      case ProfileMenuStep.addBaby:
        return 'নতুন শিশু যোগ করুন';
      case ProfileMenuStep.guardianOptions:
        return 'আরও যোগ করুন';
    }
  }
  
  Widget _buildStepIndicator() {
    int currentIndex = 0;
    switch (_currentStep) {
      case ProfileMenuStep.guardians:
        currentIndex = 0;
        break;
      case ProfileMenuStep.babyOptions:
        currentIndex = 1;
        break;
      case ProfileMenuStep.addBaby:
        currentIndex = 2;
        break;
      case ProfileMenuStep.guardianOptions:
        currentIndex = 3;
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          _buildStepDot(0, currentIndex >= 0),
          _buildStepLine(currentIndex >= 1),
          _buildStepDot(1, currentIndex >= 1),
          _buildStepLine(currentIndex >= 2),
          _buildStepDot(2, currentIndex >= 2),
          _buildStepLine(currentIndex >= 3),
          _buildStepDot(3, currentIndex >= 3),
        ],
      ),
    );
  }
  
  Widget _buildStepDot(int step, bool isActive) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.border,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isActive
            ? Icon(Icons.check, color: Colors.white, size: 16)
            : Text(
                '${step + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
  
  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
  
  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case ProfileMenuStep.guardians:
        return _buildGuardiansStep();
      case ProfileMenuStep.babyOptions:
        return _buildBabyOptionsStep();
      case ProfileMenuStep.addBaby:
        return _buildAddBabyStep();
      case ProfileMenuStep.guardianOptions:
        return _buildGuardianOptionsStep();
    }
  }
  
  // ── Step 1: Add Guardians ───────────────────────────────────────────────────
  Widget _buildGuardiansStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Illustration
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.family_restroom_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'গার্ভডিয়ানদের তথ্য দিন',
            style: AppTextStyles.headingMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'আপনার পরিবারের সদস্যদের তথ্য যোগ করুন',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          
          // Guardian Type Selector
          _buildGuardianTypeSelector(),
          const SizedBox(height: 24),
          
          // Guardian Info Form
          _buildGuardianForm(),
          const SizedBox(height: 32),
          
          // Add Another Guardian Button
          OutlinedButton.icon(
            onPressed: _addAnotherGuardian,
            icon: Icon(Icons.add, color: AppColors.primary),
            label: Text(
              'আরেকজন গার্ভডিয়ান যোগ করুন',
              style: TextStyle(color: AppColors.primary),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Next Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveGuardiansAndContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'পরবর্তী ধাপ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGuardianTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildGuardianTypeCard(
            GuardianType.mother,
            'মা',
            Icons.pregnant_woman_rounded,
            Color(0xFFEC407A),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildGuardianTypeCard(
            GuardianType.father,
            'বাবা',
            Icons.man_rounded,
            Color(0xFF42A5F5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildGuardianTypeCard(
            GuardianType.other,
            'অন্যান্য',
            Icons.person_rounded,
            Color(0xFF66BB6A),
          ),
        ),
      ],
    );
  }
  
  Widget _buildGuardianTypeCard(GuardianType type, String label, IconData icon, Color color) {
    final isSelected = _selectedGuardianType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGuardianType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGuardianForm() {
    final isMother = _selectedGuardianType == GuardianType.mother;
    final nameCtrl = isMother ? _motherNameCtrl : _fatherNameCtrl;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${isMother ? 'মা' : _selectedGuardianType == GuardianType.father ? 'বাবা' : 'গার্ভডিয়ান'}-এর তথ্য',
            style: AppTextStyles.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Name Field
          _buildTextField(
            label: 'নাম',
            controller: nameCtrl,
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          
          // Blood Group Selector
          _buildPickerField(
            label: 'রক্তের গ্রুপ',
            value: isMother ? _motherBloodGroup : _fatherBloodGroup,
            icon: Icons.bloodtype_outlined,
            onTap: () => _showBloodGroupPicker(isMother),
          ),
          const SizedBox(height: 16),
          
          // Date of Birth
          _buildPickerField(
            label: 'জন্ম তারিখ',
            value: isMother ? _motherDob : _fatherDob,
            icon: Icons.calendar_today_outlined,
            onTap: () => _showDatePicker(isMother),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPickerField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value.isNotEmpty ? value : 'নির্বাচন করুন',
                    style: TextStyle(
                      color: value.isNotEmpty ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  void _showBloodGroupPicker(bool isMother) {
    final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'রক্তের গ্রুপ নির্বাচন করুন',
                style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
              ),
            ),
            ...bloodGroups.map((group) => ListTile(
              title: Text(group),
              trailing: (isMother ? _motherBloodGroup : _fatherBloodGroup) == group
                  ? Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                setState(() {
                  if (isMother) {
                    _motherBloodGroup = group;
                  } else {
                    _fatherBloodGroup = group;
                  }
                });
                Navigator.pop(ctx);
              },
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  
  void _showDatePicker(bool isMother) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1996, 3, 15),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        final formatted = _dateFormat.format(picked);
        if (isMother) {
          _motherDob = formatted;
        } else {
          _fatherDob = formatted;
        }
      });
    }
  }
  
  void _addAnotherGuardian() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('আরেকজন গার্ভডিয়ান যোগ করার জন্য ফর্ম পূরণ করুন'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
  
  void _saveGuardiansAndContinue() {
    if (_motherNameCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('মায়ের নাম দিন'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    // Save guardians to user profile
    final authBloc = context.read<AuthBloc>();
    if (authBloc.state is AuthAuthenticated) {
      final user = authBloc.state as AuthAuthenticated;
      final updatedUser = user.user.copyWith(
        name: _motherNameCtrl.text,
        husbandName: _fatherNameCtrl.text.isNotEmpty ? _fatherNameCtrl.text : null,
        dob: _motherDob,
        bloodGroup: _motherBloodGroup.isNotEmpty ? _motherBloodGroup : null,
      );
      authBloc.add(AuthProfileUpdated(updatedUser: updatedUser));
    }
    
    // Move to next step
    setState(() {
      _currentStep = ProfileMenuStep.babyOptions;
    });
  }
  
  // ── Step 2: Baby Options ────────────────────────────────────────────────────
  Widget _buildBabyOptionsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Illustration
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFFFFE0B2).withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.child_care_rounded,
                size: 60,
                color: Color(0xFFE86A45),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'শিশুর তথ্য দিন',
            style: AppTextStyles.headingMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'আপনার শিশুর তথ্য দিন অথবা নতুন শিশু যোগ করুন',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          
          // Options Cards
          _buildOptionCard(
            icon: Icons.add_circle_outline,
            title: 'নতুন শিশু যোগ করুন',
            subtitle: 'একটি নতুন শিশুর প্রোফাইল তৈরি করুন',
            color: AppColors.primary,
            onTap: () {
              setState(() {
                _currentStep = ProfileMenuStep.addBaby;
              });
            },
          ),
          const SizedBox(height: 16),
          
          _buildOptionCard(
            icon: Icons.calendar_month_outlined,
            title: 'জন্ম তথ্য দিন',
            subtitle: 'শিশুর জন্ম তারিখ ও অন্যান্য তথ্য',
            color: Color(0xFF43A047),
            onTap: () {
              setState(() {
                _currentStep = ProfileMenuStep.addBaby;
                _babyIsBorn = true;
              });
            },
          ),
          const SizedBox(height: 16),
          
          _buildOptionCard(
            icon: Icons.pregnant_woman_rounded,
            title: 'সম্ভাব্য প্রসবের তারিখ',
            subtitle: 'ডেলিভারির আনুমানিক তারিখ দিন',
            color: Color(0xFFFF8F00),
            onTap: () {
              setState(() {
                _currentStep = ProfileMenuStep.addBaby;
                _babyIsBorn = false;
              });
            },
          ),
          
          // Show existing babies
          if (_sessionBabies.isNotEmpty) ...[
            const SizedBox(height: 32),
            Text(
              'যোগ করা শিশুর তালিকা',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ..._sessionBabies.map((baby) => _buildBabyCard(baby)),
          ],
        ],
      ),
    );
  }
  
  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBabyCard(BabyModel baby) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: baby.isBorn ? Color(0xFF4C8DF5) : Color(0xFFE86A45),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.child_care, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baby.name,
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  baby.isBorn ? 'জন্ম নেওয়া শিশু' : 'আসন্ন শিশু',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
            onPressed: () {
              setState(() {
                _sessionBabies.removeWhere((b) => b.id == baby.id);
              });
            },
          ),
        ],
      ),
    );
  }
  
  // ── Step 3: Add Baby ────────────────────────────────────────────────────────
  Widget _buildAddBabyStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baby Type Toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _babyIsBorn = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _babyIsBorn ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'জন্ম নেওয়া শিশু',
                          style: TextStyle(
                            color: _babyIsBorn ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _babyIsBorn = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_babyIsBorn ? Color(0xFFFF8F00) : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'আসন্ন শিশু',
                          style: TextStyle(
                            color: !_babyIsBorn ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Baby Info Form
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baby Name
                _buildTextField(
                  label: 'শিশুর নাম',
                  controller: _babyNameCtrl,
                  icon: Icons.child_care,
                ),
                const SizedBox(height: 16),
                
                // Gender
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'লিঙ্গ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: _buildGenderButton('ছেলে', _babyGender == 'ছেলে'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildGenderButton('মেয়ে', _babyGender == 'মেয়ে'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Date
                _buildPickerField(
                  label: _babyIsBorn ? 'জন্ম তারিখ' : 'সম্ভাব্য প্রসবের তারিখ',
                  value: _babyDob,
                  icon: Icons.calendar_today_outlined,
                  onTap: _selectBabyDate,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Action Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveBabyAndContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: _babyIsBorn ? AppColors.primary : Color(0xFFFF8F00),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'শিশু যোগ করুন',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Skip to guardian options
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _currentStep = ProfileMenuStep.guardianOptions;
                });
              },
              child: Text(
                'গার্ভডিয়ান যোগ করতে স্কিপ করুন',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGenderButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _babyGender = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
  
  void _selectBabyDate() async {
    final DateTime initialDate;
    if (_babyIsBorn) {
      initialDate = DateTime.now().subtract(Duration(days: 30));
    } else {
      initialDate = DateTime.now().add(Duration(days: 120));
    }
    
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _babyIsBorn 
          ? DateTime.now().subtract(Duration(days: 365))
          : DateTime.now(),
      lastDate: _babyIsBorn 
          ? DateTime.now() 
          : DateTime.now().add(Duration(days: 280)),
    );
    
    if (picked != null) {
      setState(() {
        _babyDob = _dateFormat.format(picked);
      });
    }
  }
  
  void _saveBabyAndContinue() {
    if (_babyNameCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('শিশুর নাম দিন'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    // Create baby model
    final newBaby = BabyModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _babyNameCtrl.text,
      gender: _babyGender.isNotEmpty ? _babyGender : null,
      birthDate: _babyDob.isNotEmpty ? _babyDob : null,
      isBorn: _babyIsBorn,
    );
    
    // Add to session list
    _sessionBabies.add(newBaby);
    
    // Save to user profile
    final authBloc = context.read<AuthBloc>();
    if (authBloc.state is AuthAuthenticated) {
      final user = authBloc.state as AuthAuthenticated;
      final updatedUser = user.user.copyWith(
        babies: [...user.user.babies, newBaby],
      );
      authBloc.add(AuthProfileUpdated(updatedUser: updatedUser));
    }
    
    // Clear form
    _babyNameCtrl.clear();
    setState(() {
      _babyGender = '';
      _babyDob = '';
    });
    
    // Move to guardian options
    setState(() {
      _currentStep = ProfileMenuStep.guardianOptions;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('শিশু সফলভাবে যোগ হয়েছে!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
  
  // ── Step 4: Guardian Options (Add more babies or guardians) ─────────────────
  Widget _buildGuardianOptionsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success Illustration
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                size: 60,
                color: AppColors.success,
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Center(
            child: Text(
              'সফলভাবে সম্পন্ন হয়েছে!',
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.success,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'আপনার প্রোফাইল সেটআপ সম্পন্ন হয়েছে',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          
          Text(
            'আরও করতে চান?',
            style: AppTextStyles.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Options
          _buildOptionCard(
            icon: Icons.add_circle_outline,
            title: 'নতুন শিশু যোগ করুন',
            subtitle: 'আরেকটি শিশুর প্রোফাইল তৈরি করুন',
            color: AppColors.primary,
            onTap: () {
              setState(() {
                _currentStep = ProfileMenuStep.addBaby;
              });
            },
          ),
          const SizedBox(height: 16),
          
          _buildOptionCard(
            icon: Icons.family_restroom_rounded,
            title: 'গার্ভডিয়ান যোগ করুন',
            subtitle: 'পরিবারে নতুন সদস্য যোগ করুন',
            color: Color(0xFFEC407A),
            onTap: () {
              setState(() {
                _currentStep = ProfileMenuStep.guardians;
              });
            },
          ),
          const SizedBox(height: 16),
          
          _buildOptionCard(
            icon: Icons.edit_outlined,
            title: 'প্রোফাইল সম্পাদনা করুন',
            subtitle: 'আপনার প্রোফাইল তথ্য পরিবর্তন করুন',
            color: Color(0xFF42A5F5),
            onTap: () {
              // Navigate to profile edit
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileEditScreenPlaceholder()),
              );
            },
          ),
          
          // Show all added babies
          if (_sessionBabies.isNotEmpty) ...[
            const SizedBox(height: 32),
            Text(
              'যোগ করা শিশুর তালিকা (${_sessionBabies.length} জন)',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ..._sessionBabies.map((baby) => _buildBabyCard(baby)),
          ],
          
          const SizedBox(height: 32),
          
          // Finish Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('প্রোফাইল সেটআপ সম্পন্ন হয়েছে!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'সম্পন্ন করুন',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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

// Placeholder for Profile Edit Screen
class ProfileEditScreenPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('প্রোফাইল সম্পাদনা'),
      ),
      body: Center(
        child: Text('প্রোফাইল সম্পাদনা স্ক্রিন'),
      ),
    );
  }
}
