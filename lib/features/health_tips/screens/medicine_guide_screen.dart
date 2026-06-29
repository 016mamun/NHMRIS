import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MedicineguideScreen extends StatefulWidget {
  const MedicineguideScreen({super.key});

  @override
  State<MedicineguideScreen> createState() => _MedicineguideScreenState();
}

class _MedicineguideScreenState extends State<MedicineguideScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _buildMedicineTab(),
                _buildLabTestTab(),
                _buildDosageTab(),
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
                    Text('ওষুধ, চিকিৎসা ও পরীক্ষা', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
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


  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabCtrl,
        labelColor: const Color(0xFF0277BD),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF0277BD),
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontSize: 13),
        tabs: const [
          Tab(text: 'ওষুধ'),
          Tab(text: 'ল্যাব পরীক্ষা'),
          Tab(text: 'ডোজ নির্দেশিকা'),
        ],
      ),
    );
  }

  Widget _buildMedicineTab() {
    final items = [
      {
        'name': 'ফলিক অ্যাসিড',
        'dose': '৪০০–৮০০ মাইক্রোগ্রাম/দিন',
        'use': 'শিশুর মস্তিষ্ক ও মেরুদণ্ডের ত্রুটি প্রতিরোধে',
        'time': 'গর্ভধারণের আগে ও প্রথম ১২ সপ্তাহ',
        'icon': '💊',
        'color': const Color(0xFF7C3AED),
        'bg': const Color(0xFFEDE7F6),
        'safe': true,
      },
      {
        'name': 'আয়রন ট্যাবলেট',
        'dose': '৬০ মিগ্রা/দিন',
        'use': 'রক্তশূন্যতা প্রতিরোধ ও রক্ত উৎপাদন',
        'time': 'খালি পেটে বা ভিটামিন সি-যুক্ত খাবারের সাথে',
        'icon': '🩸',
        'color': const Color(0xFFE53935),
        'bg': const Color(0xFFFFEBEE),
        'safe': true,
      },
      {
        'name': 'ক্যালসিয়াম সাপ্লিমেন্ট',
        'dose': '১০০০–১৩০০ মিগ্রা/দিন',
        'use': 'শিশুর হাড় ও দাঁতের গঠন',
        'time': 'খাবারের সাথে ২ ভাগে',
        'icon': '🦴',
        'color': const Color(0xFF1E88E5),
        'bg': const Color(0xFFE3F2FD),
        'safe': true,
      },
      {
        'name': 'প্যারাসিটামল',
        'dose': 'সর্বোচ্চ ৫০০ মিগ্রা',
        'use': 'জ্বর ও হালকা ব্যথায়',
        'time': 'ডাক্তারের পরামর্শে',
        'icon': '🌡️',
        'color': const Color(0xFF43A047),
        'bg': const Color(0xFFE8F5E9),
        'safe': true,
      },
      {
        'name': '⚠️ এড়িয়ে চলুন',
        'dose': 'Ibuprofen, Aspirin, Tetracycline',
        'use': 'এই ওষুধগুলো গর্ভাবস্থায় শিশুর ক্ষতি করতে পারে',
        'time': 'সম্পূর্ণ নিষিদ্ধ',
        'icon': '🚫',
        'color': const Color(0xFFE53935),
        'bg': const Color(0xFFFFEBEE),
        'safe': false,
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: items.map((item) => _buildMedCard(item)).toList(),
    );
  }

  Widget _buildMedCard(Map<String, dynamic> item) {
    final color = item['color'] as Color;
    final safe = item['safe'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item['bg'] as Color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item['icon'] as String, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['name'] as String,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: safe ? Colors.green.withValues(alpha: 0.12) : Colors.red.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        safe ? 'নিরাপদ' : 'নিষিদ্ধ',
                        style: TextStyle(
                          
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: safe ? Colors.green.shade700 : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('📌 ডোজ: ${item['dose']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 2),
                Text('🔹 ব্যবহার: ${item['use']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
                const SizedBox(height: 2),
                Text('⏰ সময়: ${item['time']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabTestTab() {
    final tests = [
      {'name': 'রক্তের গ্রুপ', 'time': 'প্রথম ভিজিটে', 'why': 'Rh factor জানা জরুরি', 'icon': '🩸'},
      {'name': 'CBC (সম্পূর্ণ রক্তের হিসাব)', 'time': 'প্রতিটি ANC ভিজিটে', 'why': 'রক্তশূন্যতা ও সংক্রমণ শনাক্ত', 'icon': '💉'},
      {'name': 'রক্তের সুগার (গ্লুকোজ)', 'time': '২৪–২৮ সপ্তাহে', 'why': 'গর্ভকালীন ডায়াবেটিস শনাক্ত', 'icon': '🍬'},
      {'name': 'প্রস্রাব পরীক্ষা', 'time': 'প্রতি মাসে', 'why': 'কিডনি সংক্রমণ ও প্রোটিন পরীক্ষা', 'icon': '🧪'},
      {'name': 'আল্ট্রাসোনোগ্রাফি', 'time': '১১–১৩, ১৮–২০, ৩২–৩৪ সপ্তাহে', 'why': 'শিশুর বিকাশ ও অবস্থান দেখতে', 'icon': '🔬'},
      {'name': 'থাইরয়েড পরীক্ষা (TSH)', 'time': 'প্রথম ভিজিটে', 'why': 'থাইরয়েড সমস্যা শনাক্ত', 'icon': '🏥'},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: tests.map((test) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E7FF)),
          boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Text(test['icon']!, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(test['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0277BD))),
                  const SizedBox(height: 3),
                  Text('⏰ ${test['time']!}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  Text('✅ ${test['why']!}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildDosageTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFCC02).withValues(alpha: 0.4)),
          ),
          child: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Color(0xFFFF8F00), size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'যেকোনো ওষুধ গ্রহণের আগে অবশ্যই আপনার ডাক্তার বা স্বাস্থ্যকর্মীর পরামর্শ নিন।',
                  style: TextStyle(fontSize: 13, height: 1.4, color: Color(0xFF7B4F00), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...[
          {'title': 'প্রথম ত্রৈমাসিক (১–১২ সপ্তাহ)', 'items': ['ফলিক অ্যাসিড: ৪০০ মাইক্রোগ্রাম/দিন', 'আয়রন ট্যাবলেট: শুরু করুন', 'বমির ওষুধ: প্রয়োজনে ডাক্তারের পরামর্শে'], 'color': const Color(0xFF7C3AED), 'bg': const Color(0xFFEDE7F6)},
          {'title': 'দ্বিতীয় ত্রৈমাসিক (১৩–২৮ সপ্তাহ)', 'items': ['আয়রন + ফলিক: চালু রাখুন', 'ক্যালসিয়াম: ১০০০ মিগ্রা/দিন', 'ভিটামিন ডি: প্রয়োজনে'], 'color': const Color(0xFF43A047), 'bg': const Color(0xFFE8F5E9)},
          {'title': 'তৃতীয় ত্রৈমাসিক (২৯–৪০ সপ্তাহ)', 'items': ['আয়রন + ক্যালসিয়াম: চালু', 'ওমেগা-৩: শিশুর মস্তিষ্কের জন্য', 'ডাক্তারের পরামর্শ অনুযায়ী অন্যান্য'], 'color': const Color(0xFF1E88E5), 'bg': const Color(0xFFE3F2FD)},
        ].map((section) => Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: section['bg'] as Color,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: (section['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(section['title'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: section['color'] as Color)),
              const SizedBox(height: 8),
              ...(section['items'] as List<String>).map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: section['color'] as Color, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
                  ],
                ),
              )),
            ],
          ),
        )),
      ],
    );
  }
}
