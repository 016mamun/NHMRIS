import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/models/baby_model.dart';
import 'report_birth_celebration_screen.dart';
import 'baby_profile_edit_screen.dart';

class BabyProfileScreen extends StatelessWidget {
  final BabyModel baby;
  const BabyProfileScreen({super.key, required this.baby});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'বেবি প্রোফাইল',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const BabyProfileEditScreen()));
            },
            child: const Text(
              'এডিট',
              style: TextStyle(color: Color(0xFF1E88E5), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
                      ),
                      child: const Center(
                        child: Icon(Icons.child_care, size: 50, color: Color(0xFFE86A45)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Baby Name
                  const Text('শিশুর নাম', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(baby.name, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 16),

                  // Gender
                  const Text('লিঙ্গ', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(baby.gender ?? 'নির্ধারণ করা হয়নি', style: const TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 16),

                  // Date
                  Text(baby.isBorn ? 'জন্ম তারিখ' : 'প্রসবের সম্ভাব্য তারিখ', style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(baby.birthDate ?? 'নির্ধারিত নয়', style: const TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 24),

                  // Report a birth row (only if unborn)
                  if (!baby.isBorn)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportBirthCelebrationScreen()));
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            const Icon(Icons.person_add_alt_1, color: Colors.black87),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                'রিপোর্ট এ বার্থ',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black87),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('রিপোর্ট এ লস'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Show confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('প্রোফাইল মুছে ফেলুন'),
                        content: const Text('আপনি কি নিশ্চিত যে আপনি এই বেবি প্রোফাইলটি মুছে ফেলতে চান?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('বাতিল'),
                          ),
                          TextButton(
                            onPressed: () {
                              final authBloc = context.read<AuthBloc>();
                              if (authBloc.state is AuthAuthenticated) {
                                final user = (authBloc.state as AuthAuthenticated).user;
                                final updatedBabies = user.babies.where((b) => b.id != baby.id).toList();
                                final updatedUser = user.copyWith(babies: updatedBabies);
                                authBloc.add(AuthProfileUpdated(updatedUser: updatedUser));
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('মুছুন', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('প্রোফাইল মুছুন'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
