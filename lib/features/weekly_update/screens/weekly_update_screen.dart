import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

class WeeklyUpdateScreen extends StatefulWidget {
  const WeeklyUpdateScreen({super.key});

  @override
  State<WeeklyUpdateScreen> createState() => _WeeklyUpdateScreenState();
}

class _WeeklyUpdateScreenState extends State<WeeklyUpdateScreen> {
  int _selectedWeek = 28;
  int _activeTab = 0; // 0: বেবির বিকাশ, 1: মায়ের শরীরে পরিবর্তন, 2: পরামর্শ

  static const _weeklyData = {
    24: {
      'size': 'ভুট্টা',
      'emoji': '🌽',
      'weight': '৬০০ গ্রাম',
      'length': '৩০ সেমি',
      'development': 'শিশুর চোখ খুলতে শুরু করেছে। ঘুম-জাগার ছন্দ তৈরি হচ্ছে। এ সময় বেবির চোখের পাতার সংবেদনশীলতা বৃদ্ধি পায়।',
      'mother': 'গর্ভাশয়ের আকার বৃদ্ধির সাথে সাথে পিঠ ও কোমরে ব্যথা হতে পারে। ত্বকে সামান্য স্ট্রেচ মার্ক দেখা দিতে পারে।',
      'advice': 'হাঁটার সময় মেরুদণ্ড সোজা রাখুন এবং ভারী কিছু বহন করা এড়িয়ে চলুন। বাম কাতে শোয়ার অভ্যাস করুন।'
    },
    25: {
      'size': 'ফুলকপি',
      'emoji': '🥦',
      'weight': '৬৬০ গ্রাম',
      'length': '৩৪ সেমি',
      'development': 'শিশু এখন বাইরের আওয়াজ খুব স্পষ্ট শুনতে পাচ্ছে। হৃদস্পন্দন আরও শক্তিশালী হয়েছে।',
      'mother': 'পায়ের গোড়ালি এবং শরীরে হালকা পানি জমতে পারে। বদহজমের সমস্যা কিছুটা বাড়তে পারে।',
      'advice': 'পর্যাপ্ত পানি পান করুন এবং দীর্ঘক্ষণ একটানা দাঁড়িয়ে থাকবেন না। শোবার সময় পা কিছুটা উঁচুতে রাখুন।'
    },
    26: {
      'size': 'লেটুস',
      'emoji': '🥬',
      'weight': '৭৬০ গ্রাম',
      'length': '৩৫ সেমি',
      'development': 'শিশুর ফুসফুস ও রক্তনালীগুলো তৈরি হচ্ছে। চোখের পাতা আলাদা হচ্ছে এবং আলো অনুভব করতে পারছে।',
      'mother': 'পেটের ওপর হালকা চুলকানি বা স্ট্রেচ মার্কস দেখা দিতে পারে। নাভি বাইরের দিকে প্রসারিত হতে পারে।',
      'advice': 'অলিভ অয়েল বা ভালো ময়েশ্চারাইজার পেটে মালিশ করতে পারেন। ঢিলেঢালা সুতির পোশাক পরিধান করুন।'
    },
    27: {
      'size': 'বাঁধাকপি',
      'emoji': '🥬',
      'weight': '৮৭৫ গ্রাম',
      'length': '৩৬ সেমি',
      'development': 'শিশুর মস্তিষ্কের দ্রুত বিকাশ হচ্ছে এবং সে এখন নিয়মিত বিরতিতে চোখ পিটপিট করতে পারছে।',
      'mother': 'হালকা শ্বাসকষ্ট বা বুক ধড়ফড়ানি হতে পারে। গর্ভাশয় নাভির উপরে উঠে আসে।',
      'advice': 'বিশ্রাম নেওয়ার সময় বাম কাতে কাত হয়ে শোন। প্রতিদিন পুষ্টিকর ক্যালসিয়াম ও আয়রনযুক্ত খাবার খান।'
    },
    28: {
      'size': 'বেগুন',
      'emoji': '🍆',
      'weight': '১.১ কেজি',
      'length': '৩৭.৬ সেমি',
      'development': 'এ সময় বেবির ফুসফুস আরও শক্তিশালী হচ্ছে এবং ওজন দ্রুত বাড়ছে। বেবি এখন বাইরের শব্দ শুনতে পারে।',
      'mother': 'গর্ভাশয় বুকের খাঁচার কাছে চলে আসায় সামান্য শ্বাসকষ্ট হতে পারে এবং পা সামান্য ফুলতে পারে।',
      'advice': 'প্রতিদিন শিশুর নড়াচড়া (কিক) কমপক্ষে ১০ বার হচ্ছে কিনা তা ট্র্যাক করুন। প্রয়োজনে কিক কাউন্টার ব্যবহার করুন।'
    },
    29: {
      'size': 'আনারস',
      'emoji': '🍍',
      'weight': '১.২ কেজি',
      'length': '৩৮ সেমি',
      'development': 'হাড় শক্ত হচ্ছে, মাংসপেশী শক্তিশালী হচ্ছে এবং শিশুটি আলোর গতিবিধি অনুসরণ করার চেষ্টা করছে।',
      'mother': 'ঘন ঘন প্রস্রাবের বেগ হতে পারে এবং কোষ্ঠকাঠিন্যের সমস্যা বৃদ্ধি পেতে পারে।',
      'advice': 'খাদ্যতালিকায় প্রচুর আঁশযুক্ত খাবার, সবুজ শাকসবজি এবং তাজা ফলমূল রাখুন। প্রচুর পানি পান করুন।'
    },
    30: {
      'size': 'তরমুজ',
      'emoji': '🍉',
      'weight': '১.৩ কেজি',
      'length': '৪০ সেমি',
      'development': 'শিশুর মস্তিষ্কে লাখ লাখ নিউরন তৈরি হচ্ছে এবং তার নড়াচড়া আরও জোরালো হচ্ছে।',
      'mother': 'সহজেই ক্লান্তিভাব আসবে এবং ঘুমাতে কিছুটা সমস্যা হতে পারে। পিঠের ব্যথা বাড়তে পারে।',
      'advice': 'শোবার ঘরে হালকা আলো রাখুন এবং ঘুমানোর আগে মোবাইল ফোন ব্যবহার করবেন না। কুসুম গরম পানিতে গোসল করতে পারেন।'
    },
    32: {
      'size': 'নারকেল',
      'emoji': '🥥',
      'weight': '১.৭ কেজি',
      'length': '৪২ সেমি',
      'development': 'শিশু এখন মাথা নিচে নামিয়ে নেওয়ার চেষ্টা করছে। হাত ও পায়ের নখগুলো সম্পূর্ণ বিকশিত হয়েছে।',
      'mother': 'ব্র্যাক্সটন হিকস (Braxton Hicks) সংকোচন বা ফলস লেবার পেইন মাঝেমধ্যে হতে পারে।',
      'advice': 'যদি সংকোচন বা ব্যথা খুব তীব্র ও ঘন ঘন হয়, তবে অবিলম্বে চিকিৎসকের পরামর্শ নিন। হাঁটাচলা সচল রাখুন।'
    },
    36: {
      'size': 'রোমেইন লেটুস',
      'emoji': '🥗',
      'weight': '২.৬ কেজি',
      'length': '৪৭ সেমি',
      'development': 'শিশু প্রায় সম্পূর্ণ বিকাশ লাভ করেছে। তার মেদ বাড়ছে এবং ত্বক মসৃণ হচ্ছে।',
      'mother': 'শিশুর মাথা শ্রোণীতে নেমে আসায় শ্বাস নিতে আগের চেয়ে সহজ লাগবে, কিন্তু হাঁটতে সমস্যা হতে পারে।',
      'advice': 'ডেলিভারির জন্য হাসপাতাল ব্যাগ এবং জরুরি রক্তের দাতা ঠিক রাখুন। নিয়মিত চেকআপ বজায় রাখুন।'
    },
    40: {
      'size': 'কুমড়া',
      'emoji': '🎃',
      'weight': '৩.৪ কেজি',
      'length': '৫১ সেমি',
      'development': 'শিশু ডেলিভারির জন্য প্রস্তুত! গর্ভের বাইরে আসার জন্য সম্পূর্ণ সুস্থ ও বিকশিত।',
      'mother': 'যেকোনো সময় প্রসব বেদনা উঠতে পারে বা অ্যামনিয়াটিক ফ্লুইড বের হতে পারে। শ্রোণীতে চাপ অনুভব করবেন।',
      'advice': 'শান্ত থাকুন এবং পরিবারের লোকজনকে নিয়ে প্রস্তুত থাকুন। অবিলম্বে হাসপাতালে যাওয়ার জন্য যানবাহন প্রস্তুত রাখুন।'
    },
  };

  Map<String, dynamic> get _currentData {
    final keys = _weeklyData.keys.toList()..sort();
    int nearest = keys.first;
    for (final k in keys) {
      if (k <= _selectedWeek) nearest = k;
    }
    return _weeklyData[nearest]!;
  }

  String _getTrimester(int week) {
    if (week <= 13) return '১ম ট্রাইমিস্টার';
    if (week <= 27) return '২য় ট্রাইমিস্টার';
    return '৩য় ট্রাইমিস্টার';
  }

  @override
  Widget build(BuildContext context) {
    final data = _currentData;
    final trimester = _getTrimester(_selectedWeek);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          _buildHeader(context),

          // ── Scrollable Body ─────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Week Selection Slider
                  _buildSliderCard(),

                  const SizedBox(height: 16),

                  // ── Top Baby Specs Card ──────────────────────────────────────────
                  _buildBabySpecsCard(data, trimester),

                  const SizedBox(height: 16),

                  // ── Tab Bar Rows ────────────────────────────────────────────────
                  _buildTabRow(),

                  const SizedBox(height: 12),

                  // ── Tab Content Card ────────────────────────────────────────────
                  _buildTabContentCard(data),
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
                    Text('সাপ্তাহিক বেবি আপডেট', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('শিশুর সাপ্তাহিক বিকাশ ট্র্যাক করুন', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSliderCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'সপ্তাহ নির্বাচন করুন',
                style: TextStyle(
                  
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${AppConstants.toBengaliNumber(_selectedWeek)} সপ্তাহ',
                  style: const TextStyle(
                    
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: _selectedWeek.toDouble(),
            min: 24,
            max: 40,
            divisions: 16,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.primary.withValues(alpha: 0.15),
            onChanged: (v) {
              setState(() {
                _selectedWeek = v.round();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '২৪ সপ্তাহ',
                  style: TextStyle(
                    
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '৪০ সপ্তাহ',
                  style: TextStyle(
                    
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBabySpecsCard(Map<String, dynamic> data, String trimester) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Left Side Details ──
          Expanded(
            flex: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'আপনার বেবি',
                      style: TextStyle(
                        
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.purple.shade900,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('🍼', style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${AppConstants.toBengaliNumber(_selectedWeek)} সপ্তাহ ($trimester)',
                  style: TextStyle(
                    
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.purple.shade700,
                  ),
                ),
                const SizedBox(height: 12),

                // Length Spec Card
                _buildBabySpecRow(
                  Icons.straighten_rounded,
                  Colors.amber.shade700,
                  Colors.amber.shade50,
                  'দৈর্ঘ্য',
                  data['length'] as String,
                ),
                const SizedBox(height: 8),

                // Weight Spec Card
                _buildBabySpecRow(
                  Icons.monitor_weight_outlined,
                  Colors.blue.shade600,
                  Colors.blue.shade50,
                  'ওজন',
                  data['weight'] as String,
                ),
                const SizedBox(height: 8),

                // Size Veggie Spec Card
                _buildBabySpecRow(
                  Icons.eco_rounded,
                  Colors.purple.shade600,
                  Colors.purple.shade50,
                  'বেবির আকার',
                  '${data['size']}র মতো',
                  leadingWidget: Text(
                    data['emoji'] as String,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ── Right Side Womb/Baby representation ──
          Expanded(
            flex: 9,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow circles representing the womb
                  Container(
                    width: 140,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFCE7F3), // Soft pink
                          const Color(0xFFFBCFE8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(70),
                      border: Border.all(
                        color: const Color(0xFFF472B6),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF472B6).withValues(alpha: 0.25),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  // Stylized placenta / warm core
                  Container(
                    width: 110,
                    height: 130,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFDA4AF),
                          const Color(0xFFE11D48).withValues(alpha: 0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Inside sleeping baby avatar
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '👶',
                          style: TextStyle(fontSize: 48),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'নিরাপদ',
                          style: TextStyle(
                            
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE11D48),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBabySpecRow(
    IconData icon,
    Color iconColor,
    Color bgColor,
    String title,
    String value, {
    Widget? leadingWidget,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: leadingWidget ??
                  Icon(
                    icon,
                    color: iconColor,
                    size: 16,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabRow() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildTabItem(0, 'বেবির বিকাশ', Icons.child_care_rounded),
          _buildTabItem(1, 'মায়ের শরীরে পরিবর্তন', Icons.pregnant_woman_rounded),
          _buildTabItem(2, 'পরামর্শ', Icons.favorite_rounded),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String title, IconData icon) {
    final bool isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeTab = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : AppColors.primary,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isActive ? Colors.white : AppColors.textSecondary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContentCard(Map<String, dynamic> data) {
    String textContent = '';
    IconData cardIcon = Icons.child_care_rounded;

    if (_activeTab == 0) {
      textContent = data['development'] as String;
      cardIcon = Icons.child_care_rounded;
    } else if (_activeTab == 1) {
      textContent = data['mother'] as String;
      cardIcon = Icons.pregnant_woman_rounded;
    } else {
      textContent = data['advice'] as String;
      cardIcon = Icons.tips_and_updates_rounded;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Detail text column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textContent,
                      style: const TextStyle(
                        
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Mother sitting / Yoga graphics representation
              Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        cardIcon,
                        size: 60,
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                      const Text(
                        '🧘‍♀️',
                        style: TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // "আরও বিস্তারিত পড়ুন" Button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () => _showDetailedInfo(data),
              icon: const Icon(Icons.menu_book_rounded, size: 16),
              label: const Text(
                'আরও বিস্তারিত পড়ুন',
                style: TextStyle(
                  
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailedInfo(Map<String, dynamic> data) {
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
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('📖 ', style: TextStyle(fontSize: 20)),
                  Text(
                    '${AppConstants.toBengaliNumber(_selectedWeek)} সপ্তাহের গাইড',
                    style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildModalDetailRow('👶 বেবির বিকাশ:', data['development'] as String),
              _buildModalDetailRow('🤰 মায়ের শরীর:', data['mother'] as String),
              _buildModalDetailRow('💡 ডাক্তারের পরামর্শ:', data['advice'] as String),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ঠিক আছে'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              
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
