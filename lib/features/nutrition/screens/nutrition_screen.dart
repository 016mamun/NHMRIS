import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int _waterGlasses = 6; // Set initially to 6 as seen in the user's screenshot!

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          _buildHeader(context),

          // ── Scrollable Body Content ─────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top Nutrition Advice Banner ───────────────────────────────────
                  _buildNutritionAdviceBanner(),

                  SizedBox(height: 20),

                  // ── Category Circles Row ──────────────────────────────────────────
                  _buildCategoriesRow(context),

                  SizedBox(height: 24),

                  // ── Section Title: আজকের খাবারের পরিকল্পনা ────────────────────────
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'আজকের খাবারের পরিকল্পনা'.tr(context),
                        style: TextStyle(
                          
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green.shade900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // ── Meal Plan List ────────────────────────────────────────────────
                  _buildMealPlanList(context),

                  SizedBox(height: 24),

                  // ── Bottom Card: Interactive Water Reminder ───────────────────────
                  _buildWaterReminderCard(context),
                ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('পুষ্টি ও যত্ন গাইড', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                      Text('সুস্থ মা ও শিশুর পুষ্টিকর খাদ্যাভ্যাস', style: TextStyle(fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildNutritionAdviceBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFDCFCE7), // Soft green
            const Color(0xFFF0FDF4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.green.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade900.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'আজকের'.tr(context),
                      style: TextStyle(
                        
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.green.shade900,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.spa_rounded,
                      color: Colors.green,
                      size: 20,
                    ),
                  ],
                ),
                Text(
                  'পুষ্টি পরামর্শ'.tr(context),
                  style: TextStyle(
                    
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.green.shade900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'প্রতিদিনের খাদ্যতালিকায় সবুজ শাকসবজি, ফল ও ডাল রাখুন।'.tr(context),
                  style: TextStyle(
                    
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          // Large Salad Bowl graphic representation
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade900.withValues(alpha: 0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '🥗',
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesRow(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'গর্ভবতীর\nডায়েট',
        'icon': Icons.favorite_rounded,
        'color': const Color(0xFFEC4899),
        'bg': const Color(0xFFFCE7F3),
        'sheet': 'diet',
      },
      {
        'title': 'পানি\nরিমাইন্ডার',
        'icon': Icons.water_drop_rounded,
        'color': const Color(0xFF0EA5E9),
        'bg': const Color(0xFFE0F2FE),
        'sheet': 'water',
      },
      {
        'title': 'ব্যায়াম',
        'icon': Icons.directions_run_rounded,
        'color': const Color(0xFF22C55E),
        'bg': const Color(0xFFDCFCE7),
        'sheet': 'exercise',
      },
      {
        'title': 'ভিটামিন ও\nসাপ্লিমেন্ট',
        'icon': Icons.vaccines_rounded,
        'color': const Color(0xFF6366F1),
        'bg': const Color(0xFFEEF2FF),
        'sheet': 'vitamins',
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return Expanded(
          child: GestureDetector(
            onTap: () => _showCategoryDetails(cat['sheet'] as String),
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: cat['bg'] as Color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: (cat['color'] as Color).withValues(alpha: 0.15),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (cat['color'] as Color).withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      cat['icon'] as IconData,
                      color: cat['color'] as Color,
                      size: 26,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  (cat['title'] as String).tr(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMealPlanList(BuildContext context) {
    final List<Map<String, dynamic>> meals = [
      {
        'title': 'সকালের নাস্তা',
        'desc': 'ওটস + ফল + দুধ',
        'icon': '🥣',
        'color': const Color(0xFFEC4899),
        'time': 'সকাল ৮:০০',
      },
      {
        'title': 'দুপুরের খাবার',
        'desc': 'ভাত + ডাল + সবজি + সালাদ',
        'icon': '🍛',
        'color': const Color(0xFFF59E0B),
        'time': 'দুপুর ১:৩০',
      },
      {
        'title': 'রাতের খাবার',
        'desc': 'সুপ + সবজি + রুটি',
        'icon': '🍲',
        'color': const Color(0xFF10B981),
        'time': 'রাত ৮:৩০',
      },
    ];

    return Column(
      children: meals.map((meal) {
        final color = meal['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    meal['icon'] as String,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (meal['title'] as String).tr(context),
                      style: TextStyle(
                        
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      (meal['desc'] as String), style: TextStyle(
                        
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (meal['time'] as String), style: TextStyle(
                    
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWaterReminderCard(BuildContext context) {
    final progress = (_waterGlasses / 8).clamp(0.0, 1.0);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF), // Very soft sky blue background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFBAE6FD),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0EA5E9).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.water_drop_rounded,
                    color: Color(0xFF0EA5E9),
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'পানি রিমাইন্ডার', style: TextStyle(
                      
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0369A1),
                    ),
                  ),
                ],
              ),
              Text(
                '${AppConstants.toBengaliNumber(_waterGlasses)}${' / ৮ গ্লাস'.tr(context)}',
                style: TextStyle(
                  
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0369A1),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Interactive Glasses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(8, (index) {
              final bool isFilled = index < _waterGlasses;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _waterGlasses = index + 1;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 32,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isFilled ? const Color(0xFF0EA5E9) : Colors.white.withValues(alpha: 0.7),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color: const Color(0xFF0EA5E9),
                      width: 1.5,
                    ),
                    boxShadow: isFilled
                        ? [
                            BoxShadow(
                              color: const Color(0xFF0EA5E9).withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.water_drop_rounded,
                      color: isFilled ? Colors.white : const Color(0xFF0EA5E9).withValues(alpha: 0.4),
                      size: 14,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 12),
          Text(
            'প্রতিটি গ্লাসে ট্যাপ করে আপনার আজকের পানি পানের হিসাব রাখুন'.tr(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0369A1),
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryDetails(String type) {
    String title = '';
    Widget content = const SizedBox.shrink();

    if (type == 'diet') {
      title = 'গর্ভবতীর ডায়েট গাইড';
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(context, '🥬 শাকসবজি ও ফলমূল', 'আয়রন, ফলিক অ্যাসিড ও কোষ্ঠকাঠিন্য দূর করতে ফাইবার প্রদান করে।'),
          _buildDetailItem(context, '🥛 দুধ ও ক্যালসিয়াম সমৃদ্ধ খাবার', 'শিশুর হাড় ও দাঁতের গঠন মজবুত করতে দিনে অন্তত ২ গ্লাস দুধ পান করুন।'),
          _buildDetailItem(context, '🥚 ডিম ও মাছ/মাংস', 'উচ্চমানের প্রোটিন শিশুর পেশী গঠনে মুখ্য ভূমিকা রাখে।'),
          _buildDetailItem(context, '🫘 ডাল ও লাল চাল', 'প্রয়োজনীয় কার্বোহাইড্রেট ও শক্তি সরবরাহ করে।'),
        ],
      );
    } else if (type == 'water') {
      title = 'পানি পান নির্দেশিকা';
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(context, '💧 কেন পানি প্রয়োজন?', 'গর্ভে পর্যাপ্ত অ্যামনিয়াটিক তরল বজায় রাখতে এবং ইউরিনারি ইনফেকশন (UTI) প্রতিরোধ করতে দিনে অন্তত ৮-১০ গ্লাস পানি আবশ্যক।'),
          _buildDetailItem(context, '🥤 ফলের রস ও ডাবের পানি', 'খাবার পানির পাশাপাশি ডাবের পানি বা তাজা ফলের রস গর্ভবতী মায়ের ক্লান্তি দূর করতে সহায়ক।'),
        ],
      );
    } else if (type == 'exercise') {
      title = 'গর্ভাবস্থায় নিরাপদ ব্যায়াম';
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(context, '🚶‍♀️ হালকা হাঁটা', 'প্রতিদিন সকালে বা বিকেলে ১৫-২০ মিনিট ধীর গতিতে হাঁটা রক্ত সঞ্চালন স্বাভাবিক রাখে।'),
          _buildDetailItem(context, '🧘‍♀️ প্রেগন্যান্সি যোগব্যায়াম', 'পেশী শিথিল করতে ও প্রসববেদনা সহজ করতে নিরাপদ যোগাসন করুন।'),
          _buildDetailItem(context, '💪 কেগেল ব্যায়াম', 'শ্রোণিদেশের পেশী মজবুত করতে অত্যন্ত সহায়ক।'),
        ],
      );
    } else if (type == 'vitamins') {
      title = 'ভিটামিন ও সাপ্লিমেন্ট';
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(context, '💊 ফলিক অ্যাসিড', 'গর্ভাবস্থার প্রথম ১২ সপ্তাহ শিশুর মেরুদণ্ড ও মস্তিষ্কের ত্রুটি প্রতিরোধে অত্যন্ত জরুরি।'),
          _buildDetailItem(context, '🩸 আয়রন ও ফলিক ট্যাবলেট', 'রক্তশূন্যতা দূর করতে প্রতিদিন চিকিৎসকের পরামর্শে আয়রন ক্যাপসুল গ্রহণ করুন।'),
          _buildDetailItem(context, '🦴 ক্যালসিয়াম ও ভিটামিন ডি', 'দুগ্ধজাত খাবারের পাশাপাশি ক্যালসিয়াম সাপ্লিমেন্ট হাড়ের ক্ষয় রোধে আবশ্যক।'),
        ],
      );
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                title.tr(context),
                style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
              ),
              SizedBox(height: 16),
              content,
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('ঠিক আছে'.tr(context)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, style: TextStyle(
              
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2),
          Text(
            desc, style: TextStyle(
              
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
