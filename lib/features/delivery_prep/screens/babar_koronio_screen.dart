import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';

class BabarKoronioScreen extends StatefulWidget {
  const BabarKoronioScreen({super.key});

  @override
  State<BabarKoronioScreen> createState() => _BabarKoronioScreenState();
}

class _BabarKoronioScreenState extends State<BabarKoronioScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _checklist = [
    {'task': 'হাসপাতালের ব্যাগ গোছানো', 'desc': 'মায়ের ও শিশুর কাপড়, কাগজপত্র', 'done': false, 'icon': Icons.luggage_rounded},
    {'task': 'রক্তদাতার ব্যবস্থা', 'desc': 'A+, B+, O+ — ২ জন ডোনার ঠিক করুন', 'done': false, 'icon': Icons.bloodtype_rounded},
    {'task': 'গাড়ির ব্যবস্থা', 'desc': 'দিনে বা রাতে যোগাযোগ করা যাবে', 'done': false, 'icon': Icons.local_taxi_rounded},
    {'task': 'অর্থের প্রস্তুতি', 'desc': 'ডেলিভারি খরচ সঞ্চয় করুন', 'done': false, 'icon': Icons.account_balance_wallet_rounded},
    {'task': 'হাসপাতাল চিহ্নিত করুন', 'desc': 'নিকটস্থ প্রসব কেন্দ্র জানুন', 'done': false, 'icon': Icons.local_hospital_rounded},
    {'task': 'ডাক্তারের ফোন নম্বর সংরক্ষণ', 'desc': 'জরুরি মুহূর্তে দ্রুত যোগাযোগ', 'done': false, 'icon': Icons.phone_rounded},
  ];

  final List<Map<String, dynamic>> _supportTips = [
    {
      'title': 'বমি বা অস্বস্তিতে পাশে থাকুন',
      'desc': 'মায়ের পাশে বসুন, পিঠ আলতো মালিশ করুন। বলুন "আমি আছি তোমার সাথে"।',
      'emoji': '🤝',
      'color': const Color(0xFF7C3AED),
    },
    {
      'title': 'ঘরের কাজে সাহায্য করুন',
      'desc': 'রান্না, কেনাকাটা ও ঘর পরিষ্কারে সহায়তা করুন। ছোট কাজেই মায়ের অনেক চাপ কমে।',
      'emoji': '🏠',
      'color': const Color(0xFF00897B),
    },
    {
      'title': 'পুষ্টিকর খাবার নিশ্চিত করুন',
      'desc': 'দুধ, ডিম, শাকসবজি ও ফলমূল এনে দিন। মায়ের পুষ্টিই শিশুর পুষ্টি।',
      'emoji': '🥗',
      'color': const Color(0xFF43A047),
    },
    {
      'title': 'চেকআপে সাথে যান',
      'desc': 'ডাক্তারের কাছে সাথে যাওয়া মায়ের মনোবল বাড়ায় এবং আপনাকেও আপডেট রাখে।',
      'emoji': '🏥',
      'color': const Color(0xFF1E88E5),
    },
  ];

  final List<Map<String, dynamic>> _empathyTips = [
    {
      'situation': 'মুড সুইং হলে',
      'advice': 'রাগ করবেন না। হরমোনের পরিবর্তনে এটি স্বাভাবিক। শান্তভাবে কথা বলুন।',
      'emoji': '💙',
    },
    {
      'situation': 'অতিরিক্ত ক্লান্তিতে',
      'advice': 'বিশ্রামের সুযোগ দিন। ঘরের কাজে বাড়তি চাপ দেবেন না।',
      'emoji': '😴',
    },
    {
      'situation': 'কান্নাকাটি করলে',
      'advice': 'পাশে বসুন, কারণ জিজ্ঞেস করুন। শুধু শুনুন — উপদেশ দিতে হবে না।',
      'emoji': '🤗',
    },
    {
      'situation': 'খাবার অরুচি হলে',
      'advice': 'পছন্দের খাবার রান্না করুন বা এনে দিন। জোর করবেন না।',
      'emoji': '🍜',
    },
  ];

  final List<Map<String, dynamic>> _parentingGuide = [
    {
      'title': 'ডায়াপার পরিবর্তন',
      'desc': 'প্রতি ২-৩ ঘণ্টায় বা ভেজা হলে বদলে দিন। পরিষ্কার করার সময় সামনে থেকে পেছনে মুছুন।',
      'icon': Icons.child_care_rounded,
      'color': const Color(0xFFFB8C00),
    },
    {
      'title': 'শিশুকে কোলে নেওয়া',
      'desc': 'মাথা সবসময় সাপোর্ট দিন। শিশু কাঁদলে আলতো দুলিয়ে শান্ত করুন।',
      'icon': Icons.baby_changing_station_rounded,
      'color': const Color(0xFFEC407A),
    },
    {
      'title': 'মাকে বিশ্রাম দেওয়া',
      'desc': 'রাতের ফিডিং বা ঘুম পাড়ানোর দায়িত্ব মাঝে মাঝে নিজে নিন।',
      'icon': Icons.bedtime_rounded,
      'color': const Color(0xFF7C3AED),
    },
    {
      'title': 'শিশুর সাথে কথা বলুন',
      'desc': 'শিশুরা বাবার কণ্ঠস্বর গর্ভ থেকেই চেনে। জন্মের পর আরো বেশি কথা বলুন।',
      'icon': Icons.record_voice_over_rounded,
      'color': const Color(0xFF00897B),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int get _completedCount => _checklist.where((c) => c['done'] as bool).length;

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSupportTab(context),
                _buildChecklistTab(context),
                _buildEmpathyTab(context),
                _buildParentingTab(context),
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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
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
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('বাবার করণীয়'.tr(context), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('বাবার দায়িত্ব ও কর্তব্য'.tr(context), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              const Text('👨', style: TextStyle(fontSize: 28)),
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
        controller: _tabController,
        isScrollable: true,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.grey.shade500,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        tabs: [
          Tab(text: 'মায়ের সাপোর্ট'.tr(context)),
          Tab(text: 'জরুরি চেকলিস্ট'.tr(context)),
          Tab(text: 'সহানুভূতি'.tr(context)),
          Tab(text: 'প্যারেন্টিং'.tr(context)),
        ],
      ),
    );
  }

  Widget _buildSupportTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard(context, 'গর্ভাবস্থায় একজন বাবার সক্রিয় সহযোগিতা মায়ের মানসিক সুস্থতায় সবচেয়ে বড় ভূমিকা রাখে।', const Color(0xFF7C3AED)),
        const SizedBox(height: 14),
        ..._supportTips.map((tip) => _supportCard(context, tip)).toList(),
      ],
    );
  }

  Widget _buildChecklistTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _progressSummaryCard(context),
        const SizedBox(height: 14),
        ..._checklist.asMap().entries.map((e) => _checklistRow(context, e.value, e.key)).toList(),
      ],
    );
  }

  Widget _buildEmpathyTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard(context, 'গর্ভাবস্থায় হরমোন পরিবর্তনে মায়ের আচরণ বদলে যেতে পারে। এটি তার দোষ নয় — বোঝার চেষ্টা করুন।', const Color(0xFFEC407A)),
        const SizedBox(height: 14),
        ..._empathyTips.map((tip) => _empathyCard(context, tip)).toList(),
      ],
    );
  }

  Widget _buildParentingTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard(context, 'সন্তানের জীবনের প্রথম দিনগুলোতে বাবার উপস্থিতি শিশুর মানসিক বিকাশে অত্যন্ত গুরুত্বপূর্ণ।', const Color(0xFF43A047)),
        const SizedBox(height: 14),
        ...List.generate(2, (row) {
          return Row(
            children: [
              Expanded(child: _parentingCard(context, _parentingGuide[row * 2])),
              const SizedBox(width: 12),
              Expanded(child: _parentingCard(context, _parentingGuide[row * 2 + 1])),
            ],
          );
        }),
      ],
    );
  }

  Widget _progressSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF7C4FC4), Color(0xFF5B2D9A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('জরুরি প্রস্তুতি'.tr(context), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text('$_completedCount/${_checklist.length} টি সম্পন্ন হয়েছে'.tr(context), style: const TextStyle(fontSize: 13, color: Colors.white70)),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: _completedCount / _checklist.length,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
            child: Center(
              child: Text('$_completedCount/${_checklist.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checklistRow(BuildContext context, Map<String, dynamic> item, int idx) {
    final done = item['done'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: done ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: done ? const Color(0xFF43A047).withOpacity(0.3) : AppColors.border.withOpacity(0.4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: done ? const Color(0xFF43A047).withOpacity(0.1) : AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
            child: Icon(item['icon'] as IconData, color: done ? const Color(0xFF43A047) : AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((item['task'] as String).tr(context), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: done ? const Color(0xFF43A047) : AppColors.textPrimary, decoration: done ? TextDecoration.lineThrough : null)),
                Text((item['desc'] as String).tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _checklist[idx]['done'] = !done),
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(color: done ? const Color(0xFF43A047) : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: done ? const Color(0xFF43A047) : Colors.grey.shade400)),
              child: done ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _supportCard(BuildContext context, Map<String, dynamic> tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: (tip['color'] as Color).withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tip['emoji'] as String, style: const TextStyle(fontSize: 30)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((tip['title'] as String).tr(context), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: tip['color'] as Color)),
                const SizedBox(height: 4),
                Text((tip['desc'] as String).tr(context), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _empathyCard(BuildContext context, Map<String, dynamic> tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tip['emoji'] as String, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((tip['situation'] as String).tr(context), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text((tip['advice'] as String).tr(context), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _parentingCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: (item['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 26),
          ),
          const SizedBox(height: 10),
          Text((item['title'] as String).tr(context), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text((item['desc'] as String).tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
        ],
      ),
    );
  }

  Widget _infoCard(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.25))),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text.tr(context), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5))),
        ],
      ),
    );
  }
}
