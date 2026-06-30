import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'report_birth_celebration_screen.dart';
import 'baby_profile_edit_screen.dart';

class BabyProfileScreen extends StatelessWidget {
  const BabyProfileScreen({super.key});

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

                  const Text('শিশুর নাম', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 4),
                  const Text('অনাগত সন্তান', style: TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 16),

                  const Text('লিঙ্গ', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 4),
                  const Text('নির্ধারণ করা হয়নি', style: TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 16),

                  const Text('প্রসবের সম্ভাব্য তারিখ', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 4),
                  const Text('18 Mar 2027', style: TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 24),

                  // Report a birth row
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
                  onPressed: () {},
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
