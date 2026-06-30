import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/localization/app_translations.dart';

class DailyTipsScreen extends StatefulWidget {
  const DailyTipsScreen({super.key});

  @override
  State<DailyTipsScreen> createState() => _DailyTipsScreenState();
}

class _DailyTipsScreenState extends State<DailyTipsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedCategory = 0;
  late AnimationController _ctrl;
  late Animation<double> _fade;

  final List<Map<String, dynamic>> _categories = [
    {'label': 'সব', 'icon': Icons.apps_rounded},
    {'label': 'পুষ্টি', 'icon': Icons.restaurant_menu_rounded},
    {'label': 'ব্যায়াম', 'icon': Icons.fitness_center_rounded},
    {'label': 'ঘুম', 'icon': Icons.bedtime_rounded},
    {'label': 'মানসিক', 'icon': Icons.psychology_rounded},
  ];

  final List<Map<String, dynamic>> _allTips = [
    {
      'cat': 1,
      'emoji': '🥗',
      'title': 'প্রতিদিন সবুজ শাক খান',
      'body':
          'পালংশাক, লালশাক, ও পুইশাক আয়রন ও ফলিক অ্যাসিডের দুর্দান্ত উৎস। গর্ভাবস্থায় প্রতিদিন এক বাটি সবুজ শাক খেলে রক্তশূন্যতা দূর হয় এবং শিশুর মস্তিষ্কের বিকাশ সঠিক হয়।',
      'tag': 'পুষ্টি',
      'tagColor': const Color(0xFF43A047),
      'bg': const Color(0xFFE8F5E9),
    },
    {
      'cat': 1,
      'emoji': '🥛',
      'title': 'দুধ ও ক্যালসিয়াম',
      'body':
          'গর্ভাবস্থায় প্রতিদিন কমপক্ষে ২ গ্লাস দুধ বা দুগ্ধজাত খাবার (দই, পনির) খান। ক্যালসিয়াম শিশুর হাড়, দাঁত ও পেশী গঠনে অপরিহার্য।',
      'tag': 'পুষ্টি',
      'tagColor': const Color(0xFF43A047),
      'bg': const Color(0xFFF0FDF4),
    },
    {
      'cat': 2,
      'emoji': '🚶‍♀️',
      'title': 'সকালে হালকা হাঁটুন',
      'body':
          'প্রতিদিন সকালে ১৫–২০ মিনিট ধীর গতিতে হাঁটলে রক্ত সঞ্চালন ভালো থাকে, পা ফোলা কমে এবং প্রসব সহজ হয়। যেকোনো ব্যায়াম শুরুর আগে ডাক্তারের পরামর্শ নিন।',
      'tag': 'ব্যায়াম',
      'tagColor': const Color(0xFF7C3AED),
      'bg': const Color(0xFFEDE7F6),
    },
    {
      'cat': 3,
      'emoji': '😴',
      'title': 'পর্যাপ্ত ঘুম নিশ্চিত করুন',
      'body':
          'গর্ভবতী মায়েদের জন্য রাতে ৮–৯ ঘণ্টা ঘুম এবং দুপুরে ১ ঘণ্টা বিশ্রাম নেওয়া ভালো। বাঁ দিকে কাত হয়ে শোলে জরায়ুতে রক্ত চলাচল সহজ হয়।',
      'tag': 'ঘুম',
      'tagColor': const Color(0xFF1E88E5),
      'bg': const Color(0xFFE3F2FD),
    },
    {
      'cat': 4,
      'emoji': '🧘‍♀️',
      'title': 'মানসিক চাপ কমান',
      'body':
          'গভীর শ্বাস-প্রশ্বাসের ব্যায়াম, মেডিটেশন বা প্রিয় গান শোনা মানসিক চাপ কমাতে সাহায্য করে। গর্ভাবস্থায় মানসিক স্বাস্থ্য শারীরিক স্বাস্থ্যের মতোই গুরুত্বপূর্ণ।',
      'tag': 'মানসিক',
      'tagColor': const Color(0xFFEC407A),
      'bg': const Color(0xFFFCE4EC),
    },
    {
      'cat': 1,
      'emoji': '💧',
      'title': 'পর্যাপ্ত পানি পান করুন',
      'body':
          'প্রতিদিন ৮–১০ গ্লাস (২ লিটার) পানি পান করুন। পর্যাপ্ত পানি পান ইউরিনারি ইনফেকশন প্রতিরোধ করে এবং গর্ভের অ্যামনিয়াটিক তরল সঠিক রাখে।',
      'tag': 'পুষ্টি',
      'tagColor': const Color(0xFF43A047),
      'bg': const Color(0xFFF0F9FF),
    },
    {
      'cat': 2,
      'emoji': '💪',
      'title': 'Kegel ব্যায়াম করুন',
      'body':
          'Kegel ব্যায়াম শ্রোণিদেশের পেশী মজবুত করে এবং প্রসবের সময় সহায়ক। প্রতিদিন ১০–১৫ বার এই ব্যায়াম করা উচিত। শুয়ে বা বসে যেকোনো অবস্থায় করা যায়।',
      'tag': 'ব্যায়াম',
      'tagColor': const Color(0xFF7C3AED),
      'bg': const Color(0xFFEDE7F6),
    },
    {
      'cat': 4,
      'emoji': '❤️',
      'title': 'পরিবারের সাথে সময় কাটান',
      'body':
          'প্রিয়জনের সঙ্গে কথা বলুন, আনন্দময় কাজ করুন। একাকীত্ব গর্ভকালীন বিষণ্নতার কারণ হতে পারে। পরিবার ও বন্ধুদের সাপোর্ট মা ও শিশু দুজনের জন্যই উপকারী।',
      'tag': 'মানসিক',
      'tagColor': const Color(0xFFEC407A),
      'bg': const Color(0xFFFCE4EC),
    },
  ];

  List<Map<String, dynamic>> get _filteredTips => _selectedCategory == 0
      ? _allTips
      : _allTips.where((t) => t['cat'] == _selectedCategory).toList();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
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
          _buildCategoryFilter(context),
          Expanded(
            child: FadeTransition(
              opacity: _fade,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                itemCount: _filteredTips.length,
                itemBuilder: (_, i) => _buildTipCard(context, _filteredTips[i]),
              ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('প্রতিদিনের স্বাস্থ্য টিপস'.tr(context), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCategoryFilter(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _categories.length,
        itemBuilder: (_, i) {
          final selected = i == _selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedCategory = i);
              _ctrl.reset();
              _ctrl.forward();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF7C3AED) : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    _categories[i]['icon'] as IconData,
                    size: 14,
                    color: selected ? Colors.white : Colors.grey.shade600,
                  ),
                  SizedBox(width: 5),
                  Text(
                    (_categories[i]['label'] as String).tr(context),
                    style: TextStyle(
                      
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, Map<String, dynamic> tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: tip['bg'] as Color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (tip['tagColor'] as Color).withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: (tip['tagColor'] as Color).withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(tip['emoji'] as String, style: TextStyle(fontSize: 32)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (tip['tagColor'] as Color).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          (tip['tag'] as String).tr(context),
                          style: TextStyle(
                            
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: tip['tagColor'] as Color,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        (tip['title'] as String).tr(context), style: TextStyle(
                          
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              (tip['body'] as String).tr(context), style: TextStyle(
                
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
