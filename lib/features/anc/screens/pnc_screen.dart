import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PncScreen extends StatelessWidget {
  const PncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _buildBanner(),
                const SizedBox(height: 20),
                _buildSectionTitle('প্রসব পরবর্তী চেকআপ সূচি'),
                const SizedBox(height: 10),
                ..._checkups.map((c) => _buildCheckupCard(c)),
                const SizedBox(height: 20),
                _buildSectionTitle('মায়ের যত্ন'),
                const SizedBox(height: 10),
                ..._motherCare.map((c) => _buildInfoCard(c)),
                const SizedBox(height: 20),
                _buildSectionTitle('বুকের দুধ খাওয়ানো'),
                const SizedBox(height: 10),
                ..._breastfeeding.map((c) => _buildInfoCard(c)),
                const SizedBox(height: 20),
                _buildWarnCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _checkups = [
    {'day': 'প্রসবের ২৪ ঘণ্টার মধ্যে', 'desc': 'মায়ের রক্তক্ষরণ ও শিশুর শ্বাস-প্রশ্বাস পরীক্ষা', 'urgent': true},
    {'day': 'প্রসবের ৩ দিনের মধ্যে', 'desc': 'সংক্রমণ, স্তনের দুধ ও নবজাতকের ওজন পরীক্ষা', 'urgent': true},
    {'day': '৭ম দিনে', 'desc': 'শিশুর নাভি, ওজন বৃদ্ধি ও মায়ের মানসিক স্বাস্থ্য', 'urgent': false},
    {'day': '৪২ তম দিনে (৬ সপ্তাহ)', 'desc': 'সম্পূর্ণ PNC মূল্যায়ন, পরিবার পরিকল্পনা পরামর্শ', 'urgent': false},
  ];

  static const List<Map<String, dynamic>> _motherCare = [
    {'emoji': '🍲', 'title': 'পুষ্টিকর খাবার', 'desc': 'প্রতিদিন আয়রন-সমৃদ্ধ খাবার, সবজি, ফল এবং বেশি পরিমাণ পানি পান করুন।'},
    {'emoji': '😴', 'title': 'বিশ্রাম নিন', 'desc': 'শিশু ঘুমালে আপনিও ঘুমান। পর্যাপ্ত বিশ্রাম মায়ের শারীরিক ও মানসিক পুনরুদ্ধারে সহায়ক।'},
    {'emoji': '🧘', 'title': 'মানসিক স্বাস্থ্য', 'desc': 'প্রসব-পরবর্তী বিষণ্নতা সাধারণ। যদি দীর্ঘস্থায়ী কান্না বা উদ্বেগ হয়, ডাক্তারকে জানান।'},
    {'emoji': '🩺', 'title': 'ক্ষতস্থান পরিষ্কার', 'desc': 'সিজার বা নরমাল ডেলিভারির ক্ষতস্থান প্রতিদিন পরিষ্কার করুন এবং সংক্রমণের লক্ষণ দেখলে ডাক্তার দেখান।'},
  ];

  static const List<Map<String, dynamic>> _breastfeeding = [
    {'emoji': '🤱', 'title': 'জন্মের ১ ঘণ্টার মধ্যে', 'desc': 'শালদুধ (Colostrum) শিশুর রোগ প্রতিরোধ ক্ষমতার জন্য অত্যন্ত জরুরি। জন্মের পরপরই বুকের দুধ দিন।'},
    {'emoji': '🍼', 'title': 'প্রথম ৬ মাস শুধু বুকের দুধ', 'desc': 'পানি, মধু বা অন্য কিছু দেবেন না। বুকের দুধই শিশুর সব পুষ্টির চাহিদা পূরণ করে।'},
    {'emoji': '⏰', 'title': 'প্রতি ২–৩ ঘণ্টায়', 'desc': 'দিনে ৮–১২ বার দুধ খাওয়ান। চাহিদামতো দুধ দিন — নির্দিষ্ট সময়সূচি মেনে চলার দরকার নেই।'},
    {'emoji': '💊', 'title': 'মায়ের পুষ্টি', 'desc': 'বুকের দুধ দেওয়ার সময় আয়রন, ক্যালসিয়াম এবং ভিটামিন সাপ্লিমেন্ট চালু রাখুন।'},
  ];

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF6B3FA0),
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
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('প্রসব পরবর্তী (PNC) সেবা', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildBanner() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFCE4EC), Color(0xFFFFF3F8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEC407A).withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Text('👩‍👶', style: TextStyle(fontSize: 40)),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'প্রসবের পরের যত্ন',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFAD1457)),
                ),
                SizedBox(height: 4),
                Text(
                  'প্রসবের পর প্রথম ৬ সপ্তাহ মা ও শিশু উভয়ের জন্যই অত্যন্ত গুরুত্বপূর্ণ সময়।',
                  style: TextStyle(fontSize: 13, color: Color(0xFFAD1457), height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(width: 4, height: 18, decoration: BoxDecoration(color: const Color(0xFFEC407A), borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildCheckupCard(Map<String, dynamic> c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (c['urgent'] as bool) ? const Color(0xFFFFF8E1) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: (c['urgent'] as bool) ? const Color(0xFFFFB300).withValues(alpha: 0.5) : AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            (c['urgent'] as bool) ? Icons.priority_high_rounded : Icons.check_circle_outline,
            color: (c['urgent'] as bool) ? const Color(0xFFFF8F00) : Colors.green,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['day'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(c['desc'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Map<String, dynamic> c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(c['emoji'] as String, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD1457))),
                const SizedBox(height: 4),
                Text(c['desc'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarnCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE53935).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Color(0xFFE53935), size: 20),
              SizedBox(width: 8),
              Text('এই লক্ষণগুলো দেখলে দ্রুত ডাক্তার দেখান', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFE53935))),
            ],
          ),
          const SizedBox(height: 10),
          ...['অতিরিক্ত রক্তপাত', 'উচ্চ জ্বর (৩৮°C+)', 'প্রস্রাবে জ্বালা বা রক্ত', 'ক্ষতস্থান ফুলে যাওয়া বা পুঁজ', 'মারাত্মক মাথাব্যথা'].map((s) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, color: Color(0xFFE53935), size: 6),
                  const SizedBox(width: 8),
                  Text(s, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
