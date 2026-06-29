import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GorvokalinShebaScreen extends StatefulWidget {
  const GorvokalinShebaScreen({super.key});

  @override
  State<GorvokalinShebaScreen> createState() => _GorvokalinShebaScreenState();
}

class _GorvokalinShebaScreenState extends State<GorvokalinShebaScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _dailyTasks = [
    {'task': 'আয়রন ট্যাবলেট খেয়েছেন', 'icon': '💊', 'done': false},
    {'task': 'ক্যালসিয়াম ট্যাবলেট খেয়েছেন', 'icon': '🧴', 'done': false},
    {'task': '৮ গ্লাস পানি পান করেছেন', 'icon': '💧', 'done': false},
    {'task': 'হালকা হাঁটাহাটি করেছেন', 'icon': '🚶', 'done': false},
    {'task': 'পুষ্টিকর নাস্তা খেয়েছেন', 'icon': '🥗', 'done': false},
    {'task': 'পর্যাপ্ত বিশ্রাম নিয়েছেন', 'icon': '😴', 'done': false},
    {'task': 'Kegel ব্যায়াম করেছেন', 'icon': '💪', 'done': false},
  ];

  final List<Map<String, dynamic>> _ancSchedule = [
    {'visit': '১ম পরিদর্শন', 'week': '৪-৮ সপ্তাহ', 'tasks': ['রক্ত পরীক্ষা', 'রক্তচাপ মাপ', 'ওজন পরিমাপ', 'প্রথম আল্ট্রাসোনোগ্রাম'], 'done': true},
    {'visit': '২য় পরিদর্শন', 'week': '১৬-২০ সপ্তাহ', 'tasks': ['শিশুর হৃৎস্পন্দন', 'আল্ট্রাসোনোগ্রাম', 'ডায়াবেটিস পরীক্ষা'], 'done': true},
    {'visit': '৩য় পরিদর্শন', 'week': '২৮-৩২ সপ্তাহ', 'tasks': ['শিশুর অবস্থান', 'রক্তের হিমোগ্লোবিন', 'টিটেনাস টিকা'], 'done': false},
    {'visit': '৪র্থ পরিদর্শন', 'week': '৩৬-৩৮ সপ্তাহ', 'tasks': ['প্রসবের প্রস্তুতি', 'শিশুর মাথার অবস্থান', 'NST টেস্ট'], 'done': false},
  ];

  final List<Map<String, dynamic>> _eatList = [
    {'category': 'প্রোটিন', 'emoji': '🥚', 'items': 'ডিম, মাছ, মাংস, ডাল, বাদাম', 'benefit': 'শিশুর পেশী ও কোষ গঠনে সাহায্য করে', 'color': const Color(0xFFE53935)},
    {'category': 'ক্যালসিয়াম', 'emoji': '🥛', 'items': 'দুধ, দই, পনির, সবুজ শাক', 'benefit': 'শিশুর হাড় ও দাঁত মজবুত করে', 'color': const Color(0xFF1E88E5)},
    {'category': 'আয়রন', 'emoji': '🥦', 'items': 'পালংশাক, লালশাক, কলিজা, ডালিম', 'benefit': 'রক্তশূন্যতা প্রতিরোধ করে', 'color': const Color(0xFF43A047)},
    {'category': 'ফলিক অ্যাসিড', 'emoji': '🥑', 'items': 'সবুজ সবজি, বাদাম, মটরশুটি', 'benefit': 'শিশুর মস্তিষ্ক ও মেরুদণ্ড গঠনে জরুরি', 'color': const Color(0xFF7C3AED)},
    {'category': 'ওমেগা-৩', 'emoji': '🐟', 'items': 'সামুদ্রিক মাছ, আখরোট, চিয়া সিড', 'benefit': 'শিশুর মস্তিষ্ক বিকাশে সহায়তা করে', 'color': const Color(0xFF00897B)},
  ];

  final List<Map<String, dynamic>> _avoidList = [
    {'item': 'কাঁচা বা অর্ধ-সিদ্ধ মাংস', 'reason': 'ব্যাকটেরিয়া সংক্রমণের ঝুঁকি'},
    {'item': 'অতিরিক্ত ক্যাফেইন (চা/কফি)', 'reason': 'শিশুর বৃদ্ধি বাধাগ্রস্ত হতে পারে'},
    {'item': 'কাঁচা পেঁপে ও আনারস', 'reason': 'গর্ভপাতের ঝুঁকি বাড়াতে পারে'},
    {'item': 'ধূমপান ও মদ', 'reason': 'শিশুর মারাত্মক ক্ষতি করে'},
    {'item': 'অতিরিক্ত লবণাক্ত খাবার', 'reason': 'উচ্চ রক্তচাপের ঝুঁকি বাড়ায়'},
  ];

  final List<Map<String, dynamic>> _exercises = [
    {
      'name': 'হালকা হাঁটা',
      'duration': '১৫-৩০ মিনিট/দিন',
      'benefit': 'রক্ত সঞ্চালন উন্নত করে, পা ফোলা কমায়',
      'emoji': '🚶‍♀️',
      'color': const Color(0xFF43A047),
    },
    {
      'name': 'Kegel ব্যায়াম',
      'duration': '১০-১৫ বার/দিন',
      'benefit': 'পেলভিক পেশী শক্তিশালী করে, প্রসব সহজ করে',
      'emoji': '💪',
      'color': const Color(0xFF7C3AED),
    },
    {
      'name': 'গভীর শ্বাস-প্রশ্বাস',
      'duration': '৫-১০ মিনিট/দিন',
      'benefit': 'মানসিক চাপ কমায়, অক্সিজেন সরবরাহ বাড়ায়',
      'emoji': '🧘‍♀️',
      'color': const Color(0xFF1E88E5)
    },
    {
      'name': 'প্রসবকালীন যোগব্যায়াম',
      'duration': '২০-৩০ মিনিট/দিন',
      'benefit': 'শরীর ও মন উভয়কে প্রসবের জন্য প্রস্তুত করে',
      'emoji': '🧘',
      'color': const Color(0xFFEC407A),
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

  int get _completedTasks => _dailyTasks.where((t) => t['done'] as bool).length;

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
              controller: _tabController,
              children: [
                _buildDailyTodoTab(),
                _buildANCScheduleTab(),
                _buildDietTab(),
                _buildExerciseTab(),
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
                  children: const [
                    Text('গর্ভকালীন সেবা ও করণীয়', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('নিয়মিত যত্ন ও স্বাস্থ্যকর অভ্যাস', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              const Text('🤱', style: TextStyle(fontSize: 28)),
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
        tabs: const [
          Tab(text: 'প্রতিদিনের কাজ'),
          Tab(text: 'ANC সময়সূচী'),
          Tab(text: 'খাদ্য গাইড'),
          Tab(text: 'ব্যায়াম ও সুস্থতা'),
        ],
      ),
    );
  }

  Widget _buildDailyTodoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _progressBanner(),
        const SizedBox(height: 14),
        ..._dailyTasks.asMap().entries.map((e) => _todoRow(e.value, e.key)).toList(),
      ],
    );
  }

  Widget _progressBanner() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF7C4FC4), Color(0xFF5B2D9A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('✅', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('আজকের স্বাস্থ্য লক্ষ্যমাত্রা', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('$_completedTasks/${_dailyTasks.length} টি সম্পন্ন', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              Text('${((_completedTasks / _dailyTasks.length) * 100).round()}%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: _completedTasks / _dailyTasks.length,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _todoRow(Map<String, dynamic> task, int idx) {
    final done = task['done'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: done ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: done ? const Color(0xFF43A047).withOpacity(0.3) : AppColors.border.withOpacity(0.4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Text(task['icon'] as String, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(task['task'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: done ? const Color(0xFF43A047) : AppColors.textPrimary, decoration: done ? TextDecoration.lineThrough : null)),
          ),
          GestureDetector(
            onTap: () => setState(() => _dailyTasks[idx]['done'] = !done),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28, height: 28,
              decoration: BoxDecoration(color: done ? const Color(0xFF43A047) : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: done ? const Color(0xFF43A047) : Colors.grey.shade400)),
              child: done ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildANCScheduleTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard('গর্ভাবস্থায় কমপক্ষে ৪ বার ANC চেকআপ করা অপরিহার্য।', const Color(0xFF00897B)),
        const SizedBox(height: 14),
        ..._ancSchedule.map((visit) => _ancCard(visit)).toList(),
      ],
    );
  }

  Widget _ancCard(Map<String, dynamic> visit) {
    final done = visit['done'] as bool;
    final color = done ? const Color(0xFF43A047) : AppColors.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: done ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(done ? Icons.check_circle_rounded : Icons.calendar_today_rounded, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(visit['visit'] as String, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(visit['week'] as String, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (visit['tasks'] as List<String>).map((task) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.25))),
                    child: Text(task, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('✅ খাওয়া উচিত', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF43A047))),
        const SizedBox(height: 10),
        ..._eatList.map((item) => _foodCard(item)).toList(),
        const SizedBox(height: 14),
        const Text('❌ এড়িয়ে চলুন', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFE53935))),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))]),
          child: Column(
            children: _avoidList.asMap().entries.map((e) {
              final isLast = e.key == _avoidList.length - 1;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(color: const Color(0xFFFFEBEE), shape: BoxShape.circle),
                          child: const Icon(Icons.close_rounded, color: Color(0xFFE53935), size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.value['item'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                              Text(e.value['reason'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) const Divider(height: 1, indent: 58),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _foodCard(Map<String, dynamic> item) {
    final color = item['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(item['emoji'] as String, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['category'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 2),
                Text(item['items'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(item['benefit'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard('যেকোনো ব্যায়াম শুরুর আগে ডাক্তারের পরামর্শ নিন।', const Color(0xFFFB8C00)),
        const SizedBox(height: 14),
        ..._exercises.map((ex) => _exerciseCard(ex)).toList(),
        const SizedBox(height: 14),
        _meditationCard(),
      ],
    );
  }

  Widget _exerciseCard(Map<String, dynamic> ex) {
    final color = ex['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
            child: Center(child: Text(ex['emoji'] as String, style: const TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ex['name'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: Text(ex['duration'] as String, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 4),
                Text(ex['benefit'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _meditationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF8E24AA), Color(0xFF5B2D9A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('🧘‍♀️ মেডিটেশন ও মানসিক শান্তি', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                Text('প্রতিদিন ১০ মিনিট গভীর শ্বাস-প্রশ্বাস বা মেডিটেশন করুন। মানসিক চাপ কমলে শিশু ও মা উভয়েরই উপকার হয়।', style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.25))),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4))),
        ],
      ),
    );
  }
}
