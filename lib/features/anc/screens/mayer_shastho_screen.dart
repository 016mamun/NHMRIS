import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';

class MayerShasthoScreen extends StatefulWidget {
  const MayerShasthoScreen({super.key});

  @override
  State<MayerShasthoScreen> createState() => _MayerShasthoScreenState();
}

class _MayerShasthoScreenState extends State<MayerShasthoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedMood = -1;
  final List<Map<String, dynamic>> _vitals = [];
  final List<Map<String, dynamic>> _medications = [
    {'name': 'আয়রন ট্যাবলেট', 'dose': '১টি', 'time': 'রাতে', 'done': false},
    {'name': 'ক্যালসিয়াম ট্যাবলেট', 'dose': '১টি', 'time': 'দুপুরে', 'done': false},
    {'name': 'ফলিক অ্যাসিড', 'dose': '১টি', 'time': 'সকালে', 'done': false},
  ];

  final List<Map<String, dynamic>> _weeklyProgress = [
    {'week': '১ম মাস', 'weight': '৫৫ কেজি', 'change': '+০', 'note': 'স্বাভাবিক'},
    {'week': '২য় মাস', 'weight': '৫৬.৫ কেজি', 'change': '+১.৫', 'note': 'স্বাভাবিক'},
    {'week': '৩য় মাস', 'weight': '৫৮ কেজি', 'change': '+১.৫', 'note': 'স্বাভাবিক'},
    {'week': '৪র্থ মাস', 'weight': '৬০ কেজি', 'change': '+২', 'note': 'স্বাভাবিক'},
    {'week': '৫ম মাস', 'weight': '৬২.৫ কেজি', 'change': '+২.৫', 'note': 'স্বাভাবিক'},
  ];

  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😊', 'label': 'ভালো', 'color': const Color(0xFF43A047)},
    {'emoji': '😐', 'label': 'মোটামুটি', 'color': const Color(0xFFFB8C00)},
    {'emoji': '😔', 'label': 'খারাপ', 'color': const Color(0xFF1E88E5)},
    {'emoji': '😢', 'label': 'কান্না', 'color': const Color(0xFF8E24AA)},
    {'emoji': '😡', 'label': 'রাগী', 'color': const Color(0xFFE53935)},
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
                _buildBodyTracker(context),
                _buildMoodTracker(context),
                _buildVitalsTracker(context),
                _buildMedicationTracker(context),
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
                    Text('মায়ের স্বাস্থ্য'.tr(context), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('মায়ের বিস্তারিত অবস্থা ও সমস্যা'.tr(context), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              const Text('👩', style: TextStyle(fontSize: 28)),
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
          Tab(text: 'বডি ট্র্যাকার'.tr(context)),
          Tab(text: 'মুড ট্র্যাকার'.tr(context)),
          Tab(text: 'ভাইটালস'.tr(context)),
          Tab(text: 'ওষুধ'.tr(context)),
        ],
      ),
    );
  }

  // ── Tab 1: Body Tracker ──
  Widget _buildBodyTracker(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionCard(
          title: 'মাসিক ওজন ট্র্যাকার'.tr(context),
          icon: Icons.monitor_weight_rounded,
          color: const Color(0xFF7C3AED),
          child: Column(
            children: [
              const SizedBox(height: 12),
              ..._weeklyProgress.asMap().entries.map((e) {
                final idx = e.key;
                final item = e.value;
                return _progressRow(context, item, idx);
              }),
              const SizedBox(height: 8),
              _addWeightButton(context),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _sectionCard(
          title: 'শরীরের পরিবর্তনসমূহ'.tr(context),
          icon: Icons.pregnant_woman_rounded,
          color: const Color(0xFFEC407A),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _changeItem(context, '১ম ত্রৈমাসিক', 'বমি বমি ভাব, ক্লান্তি, স্তন কোমলতা', const Color(0xFFEC407A)),
              _changeItem(context, '২য় ত্রৈমাসিক', 'পেট বড় হওয়া, শিশুর নড়াচড়া অনুভব', const Color(0xFF7C3AED)),
              _changeItem(context, '৩য় ত্রৈমাসিক', 'পিঠে ব্যথা, ঘন ঘন প্রস্রাব, পা ফোলা', const Color(0xFF00897B)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _progressRow(BuildContext context, Map<String, dynamic> item, int idx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: idx % 2 == 0 ? const Color(0xFFF3EEFF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: Center(child: Text('${idx + 1}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((item['week'] as String).tr(context), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                Text((item['weight'] as String).tr(context), style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
            child: Text((item['change'] as String).tr(context) + ' কেজি'.tr(context), style: const TextStyle(fontSize: 11, color: Color(0xFF43A047), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _addWeightButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddWeightDialog(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withOpacity(0.3), style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
            Text('আজকের ওজন যোগ করুন'.tr(context), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _changeItem(BuildContext context, String period, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8, height: 8,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(period.tr(context), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 3),
                Text(description.tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Tab 2: Mood Tracker ──
  Widget _buildMoodTracker(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionCard(
          title: 'আজকের মানসিক অবস্থা'.tr(context),
          icon: Icons.psychology_rounded,
          color: const Color(0xFF8E24AA),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _moods.asMap().entries.map((e) {
                  final idx = e.key;
                  final m = e.value;
                  final selected = _selectedMood == idx;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMood = idx),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selected ? (m['color'] as Color).withOpacity(0.15) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: selected ? m['color'] as Color : Colors.transparent, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text(m['emoji'] as String, style: const TextStyle(fontSize: 28)),
                          const SizedBox(height: 4),
                          Text((m['label'] as String).tr(context), style: TextStyle(fontSize: 11, color: selected ? m['color'] as Color : Colors.grey.shade600, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              if (_selectedMood >= 0)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: (_moods[_selectedMood]['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Text('আপনার অনুভূতি রেকর্ড হয়েছে। মনে রাখবেন, আপনি একা নন।'.tr(context), style: TextStyle(fontSize: 13, color: _moods[_selectedMood]['color'] as Color, height: 1.5)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _sectionCard(
          title: 'মন ভালো করার টিপস'.tr(context),
          icon: Icons.lightbulb_rounded,
          color: const Color(0xFF43A047),
          child: Column(
            children: [
              const SizedBox(height: 12),
              _tipRow(context, '🧘', 'গভীর শ্বাস-প্রশ্বাসের ব্যায়াম করুন — ৫ মিনিটেই মন শান্ত হবে'),
              _tipRow(context, '🎵', 'প্রিয় গান শুনুন বা হালকা মেডিটেশন সঙ্গীত ব্যবহার করুন'),
              _tipRow(context, '🌿', 'বাইরে হালকা হাঁটুন এবং তাজা বাতাস নিন'),
              _tipRow(context, '❤️', 'পরিবার বা বন্ধুর সাথে মন খুলে কথা বলুন'),
              _tipRow(context, '📔', 'ডায়েরিতে আপনার অনুভূতি লিখে রাখুন'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _warningCard(context,
          'পোস্টপার্টাম ডিপ্রেশন সম্পর্কে জানুন',
          'সন্তান জন্মের পর বিষণ্নতা খুবই স্বাভাবিক। ২ সপ্তাহের বেশি কষ্ট থাকলে দ্রুত ডাক্তারের পরামর্শ নিন।',
          Icons.info_outline_rounded,
          const Color(0xFF1E88E5),
        ),
      ],
    );
  }

  Widget _tipRow(BuildContext context, String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(child: Text(text.tr(context), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4))),
        ],
      ),
    );
  }

  // ── Tab 3: Vitals Tracker ──
  Widget _buildVitalsTracker(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(child: _vitalCard(context, 'রক্তচাপ', '120/80', 'mmHg', Icons.favorite_rounded, const Color(0xFFE53935), 'স্বাভাবিক')),
            const SizedBox(width: 12),
            Expanded(child: _vitalCard(context, 'ব্লাড সুগার', '৫.৫', 'mmol/L', Icons.water_drop_rounded, const Color(0xFF00897B), 'স্বাভাবিক')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _vitalCard(context, 'পালস রেট', '৭৮', 'bpm', Icons.monitor_heart_rounded, const Color(0xFF7C3AED), 'স্বাভাবিক')),
            const SizedBox(width: 12),
            Expanded(child: _vitalCard(context, 'তাপমাত্রা', '৯৮.৬', '°F', Icons.device_thermostat_rounded, const Color(0xFFFB8C00), 'স্বাভাবিক')),
          ],
        ),
        const SizedBox(height: 14),
        _sectionCard(
          title: 'ভাইটালস লগ ইতিহাস'.tr(context),
          icon: Icons.history_rounded,
          color: AppColors.primary,
          child: Column(
            children: [
              const SizedBox(height: 12),
              _vitalsLogRow(context, 'আজ সকাল', '120/80', '৫.৫', '৭৮'),
              _vitalsLogRow(context, 'গতকাল', '118/78', '৫.৩', '৮০'),
              _vitalsLogRow(context, '২ দিন আগে', '122/82', '৫.৬', '৭৬'),
              const SizedBox(height: 8),
              _addVitalButton(context),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _warningCard(context,
          'সতর্কতা',
          'রক্তচাপ ১৪০/৯০ এর বেশি হলে অবিলম্বে ডাক্তারের সাথে যোগাযোগ করুন।',
          Icons.warning_amber_rounded,
          const Color(0xFFE53935),
        ),
      ],
    );
  }

  Widget _vitalCard(BuildContext context, String title, String value, String unit, IconData icon, Color color, String status) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(6)),
                child: Text(status.tr(context), style: const TextStyle(fontSize: 10, color: Color(0xFF43A047))),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title.tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: value.tr(context), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
                TextSpan(text: ' ${unit.tr(context)}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vitalsLogRow(BuildContext context, String date, String bp, String sugar, String pulse) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF7F4FB), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(child: Text(date.tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))),
          _logChip(context, bp, const Color(0xFFE53935)),
          const SizedBox(width: 6),
          _logChip(context, sugar, const Color(0xFF00897B)),
          const SizedBox(width: 6),
          _logChip(context, pulse, const Color(0xFF7C3AED)),
        ],
      ),
    );
  }

  Widget _logChip(BuildContext context, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(value.tr(context), style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
    );
  }

  Widget _addVitalButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
            Text('নতুন রিডিং যোগ করুন'.tr(context), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // ── Tab 4: Medication Tracker ──
  Widget _buildMedicationTracker(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionCard(
          title: 'আজকের ওষুধের তালিকা'.tr(context),
          icon: Icons.medication_rounded,
          color: const Color(0xFF00897B),
          child: Column(
            children: [
              const SizedBox(height: 12),
              ..._medications.asMap().entries.map((e) {
                final idx = e.key;
                final med = e.value;
                return _medicationRow(context, med, idx);
              }),
              const SizedBox(height: 8),
              _addMedicationButton(context),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _sectionCard(
          title: 'রিমাইন্ডার সেটিংস'.tr(context),
          icon: Icons.alarm_rounded,
          color: const Color(0xFFFB8C00),
          child: Column(
            children: [
              const SizedBox(height: 12),
              _reminderRow(context, 'সকাল ৮:০০', 'ফলিক অ্যাসিড', true),
              _reminderRow(context, 'দুপুর ২:০০', 'ক্যালসিয়াম ট্যাবলেট', true),
              _reminderRow(context, 'রাত ১০:০০', 'আয়রন ট্যাবলেট', false),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _warningCard(context,
          'মনে রাখবেন',
          'ডাক্তারের পরামর্শ ছাড়া কোনো ওষুধ বন্ধ করবেন ঘন বা নতুন ওষুধ শুরু করবেন না।',
          Icons.medical_information_rounded,
          const Color(0xFF7C3AED),
        ),
      ],
    );
  }

  Widget _medicationRow(BuildContext context, Map<String, dynamic> med, int idx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (med['done'] as bool) ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: (med['done'] as bool) ? const Color(0xFF43A047).withOpacity(0.3) : AppColors.border.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _medications[idx]['done'] = !(med['done'] as bool)),
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: (med['done'] as bool) ? const Color(0xFF43A047) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: (med['done'] as bool) ? const Color(0xFF43A047) : Colors.grey.shade400),
              ),
              child: (med['done'] as bool)
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((med['name'] as String).tr(context), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary, decoration: (med['done'] as bool) ? TextDecoration.lineThrough : null)),
                Text('${(med['dose'] as String).tr(context)} • ${(med['time'] as String).tr(context)}', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: (med['done'] as bool) ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(8)),
            child: Text((med['done'] as bool) ? 'সম্পন্ন'.tr(context) : 'বাকি'.tr(context), style: TextStyle(fontSize: 11, color: (med['done'] as bool) ? const Color(0xFF43A047) : const Color(0xFFFB8C00), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _reminderRow(BuildContext context, String time, String med, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFF3E0) : const Color(0xFFF7F4FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? const Color(0xFFFB8C00).withOpacity(0.3) : AppColors.border.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.alarm_rounded, color: isActive ? const Color(0xFFFB8C00) : Colors.grey, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time.tr(context), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isActive ? const Color(0xFFFB8C00) : Colors.grey)),
                Text(med.tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (v) {},
            activeColor: const Color(0xFFFB8C00),
          ),
        ],
      ),
    );
  }

  Widget _addMedicationButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF00897B).withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: Color(0xFF00897B), size: 18),
            const SizedBox(width: 8),
            Text('নতুন ওষুধ যোগ করুন'.tr(context), style: const TextStyle(fontSize: 13, color: Color(0xFF00897B), fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required IconData icon, required Color color, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }

  Widget _warningCard(BuildContext context, String title, String body, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.tr(context), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 4),
                Text(body.tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddWeightDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('ওজন যোগ করুন'.tr(context), style: const TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'কেজি'.tr(context), hintStyle: const TextStyle(fontFamily: 'Hind_Siliguri')),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('বাতিল'.tr(context), style: const TextStyle(fontFamily: 'Hind_Siliguri'))),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text('সংরক্ষণ'.tr(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
