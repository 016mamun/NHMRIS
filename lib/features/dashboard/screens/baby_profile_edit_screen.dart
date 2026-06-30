import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/models/baby_model.dart';

class BabyProfileEditScreen extends StatefulWidget {
  final BabyModel? babyToUpdate;
  const BabyProfileEditScreen({super.key, this.babyToUpdate});

  @override
  State<BabyProfileEditScreen> createState() => _BabyProfileEditScreenState();
}

class _BabyProfileEditScreenState extends State<BabyProfileEditScreen> {
  late TextEditingController _nameController;
  late String _gender;
  late String _dob;
  late String _deliveryType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.babyToUpdate?.name ?? 'নতুন বাবু');
    _gender = widget.babyToUpdate?.gender ?? 'ছেলে';
    _dob = widget.babyToUpdate?.birthDate ?? '30 Jun 2026';
    _deliveryType = 'নরমাল ডেলিভারি';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildFieldTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return const InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black38),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FA), // Light background color from image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'বেবি প্রোফাইল',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(24),
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
              // Avatar
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade50,
                      ),
                      child: const Center(
                        child: Icon(Icons.child_care, size: 60, color: Color(0xFFE86A45)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E88E5), // Blue color from image
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Baby Name
              _buildFieldTitle('শিশুর নাম'),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                decoration: _buildInputDecoration(),
              ),
              const SizedBox(height: 24),

              // Gender
              _buildFieldTitle('লিঙ্গ'),
              DropdownButtonFormField<String>(
                value: _gender,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                decoration: _buildInputDecoration(),
                items: ['নির্ধারণ করা হয়নি', 'ছেলে', 'মেয়ে']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _gender = val);
                },
              ),
              const SizedBox(height: 24),

              // Date of Birth
              _buildFieldTitle('জন্ম তারিখ'),
              DropdownButtonFormField<String>(
                value: _dob,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                decoration: _buildInputDecoration(),
                items: ['30 Jun 2026', '01 Jul 2026']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _dob = val);
                },
              ),
              const SizedBox(height: 24),

              // Type of Delivery
              _buildFieldTitle('প্রসবের ধরন'),
              DropdownButtonFormField<String>(
                value: _deliveryType,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                decoration: _buildInputDecoration(),
                items: ['নরমাল ডেলিভারি', 'সিজারিয়ান']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _deliveryType = val);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () async {
              final authBloc = context.read<AuthBloc>();
              if (authBloc.state is AuthAuthenticated) {
                final user = (authBloc.state as AuthAuthenticated).user;
                
                if (widget.babyToUpdate != null) {
                  // Update existing baby (Step 3: transition unborn -> born)
                  List<BabyModel> updatedBabies = [];
                  for (var b in user.babies) {
                    if (b.id == widget.babyToUpdate!.id) {
                      updatedBabies.add(b.copyWith(
                        name: _nameController.text,
                        gender: _gender,
                        birthDate: _dob,
                        isBorn: true,
                      ));
                    } else {
                      updatedBabies.add(b);
                    }
                  }

                  final updatedUser = user.copyWith(babies: updatedBabies);
                  authBloc.add(AuthProfileUpdated(updatedUser: updatedUser));
                } else {
                  // Create completely new baby
                  final newBaby = BabyModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _nameController.text,
                    gender: _gender,
                    birthDate: _dob,
                    isBorn: true,
                  );
                  final updatedUser = user.copyWith(
                    babies: [...user.babies, newBaby],
                  );
                  authBloc.add(AuthProfileUpdated(updatedUser: updatedUser));
                }
                
                await authBloc.stream.firstWhere(
                  (s) => s is AuthAuthenticated,
                );
              }
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('সংরক্ষণ করা হয়েছে!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5), // Blue color from image
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'সাবমিট',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
