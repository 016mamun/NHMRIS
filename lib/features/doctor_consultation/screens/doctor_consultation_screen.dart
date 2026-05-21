import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class DoctorConsultationScreen extends StatelessWidget {
  const DoctorConsultationScreen({super.key});

  static const List<Map<String, dynamic>> _doctors = [
    {
      'name': 'ডা. ফারহানা ইসলাম',
      'specialty': 'গাইনোকোলজিস্ট ও প্রসূতিবিদ',
      'hospital': 'ঢাকা মেডিকেল কলেজ হাসপাতাল',
      'rating': '৪.৯',
      'fee': '৮০০',
      'available': true,
      'emoji': '👩‍⚕️',
    },
    {
      'name': 'ডা. নাজমা আক্তার',
      'specialty': 'মাতৃস্বাস্থ্য বিশেষজ্ঞ',
      'hospital': 'স্কয়ার হাসপাতাল, ঢাকা',
      'rating': '৪.৮',
      'fee': '১২০০',
      'available': true,
      'emoji': '👩‍⚕️',
    },
    {
      'name': 'ডা. রিনা বেগম',
      'specialty': 'প্রসূতি ও নবজাতক বিশেষজ্ঞ',
      'hospital': 'বঙ্গবন্ধু মেডিকেল বিশ্ববিদ্যালয়',
      'rating': '৪.৭',
      'fee': '৬০০',
      'available': false,
      'emoji': '👩‍⚕️',
    },
    {
      'name': 'ডা. সাবরিনা হোসেন',
      'specialty': 'গাইনোকোলজিস্ট',
      'hospital': 'এভারকেয়ার হাসপাতাল, ঢাকা',
      'rating': '৫.০',
      'fee': '১৫০০',
      'available': true,
      'emoji': '👩‍⚕️',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 8),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8)],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ডাক্তার বা বিশেষজ্ঞ খুঁজুন...',
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('উপলব্ধ ডাক্তারগণ', style: AppTextStyles.headingMedium),
                const SizedBox(height: 12),
                ..._doctors.map((doc) => _DoctorCard(doctor: doc)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ডাক্তার পরামর্শ', style: AppTextStyles.onPrimaryHeading),
                  Text('বিশেষজ্ঞ ডাক্তারের সাথে যোগাযোগ করুন', style: AppTextStyles.onPrimaryBody),
                ],
              ),
              const Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  const _DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    final bool available = doctor['available'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: AppColors.doctorBg,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(doctor['emoji'], style: const TextStyle(fontSize: 28))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor['name'], style: AppTextStyles.headingSmall),
                    const SizedBox(height: 2),
                    Text(doctor['specialty'], style: AppTextStyles.bodySmall.copyWith(color: AppColors.doctorIcon)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textHint),
                        const SizedBox(width: 2),
                        Expanded(child: Text(doctor['hospital'], style: AppTextStyles.bodySmall, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              // Rating
              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
              const SizedBox(width: 4),
              Text(doctor['rating'], style: AppTextStyles.labelMedium),
              const SizedBox(width: 16),
              // Fee
              const Icon(Icons.payments_outlined, color: AppColors.success, size: 16),
              const SizedBox(width: 4),
              Text('৳${doctor['fee']}', style: AppTextStyles.labelMedium),
              const Spacer(),
              // Status + Button
              if (!available)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('অনুপলব্ধ', style: AppTextStyles.labelSmall.copyWith(color: AppColors.error)),
                )
              else
                ElevatedButton(
                  onPressed: () => _showAppointment(context, doctor['name']),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('অ্যাপয়েন্টমেন্ট'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAppointment(BuildContext context, String name) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Text('অ্যাপয়েন্টমেন্ট', style: AppTextStyles.headingMedium),
            const SizedBox(height: 8),
            Text('$name এর সাথে অ্যাপয়েন্টমেন্ট নিতে চান?', style: AppTextStyles.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('অ্যাপয়েন্টমেন্টের অনুরোধ পাঠানো হয়েছে'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ));
              },
              child: const Text('নিশ্চিত করুন'),
            )),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
