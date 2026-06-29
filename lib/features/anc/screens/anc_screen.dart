import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ANCScreen extends StatefulWidget {
  const ANCScreen({super.key});

  @override
  State<ANCScreen> createState() => _ANCScreenState();
}

class _ANCScreenState extends State<ANCScreen> {
  int _activeStep = 0;

  final List<ANCStep> _steps = const [
    ANCStep(
      stepNumber: 1,
      title: 'প্রথম ভিজিট',
      duration: '১২ সপ্তাহ বা তার আগে',
      trimester: 'প্রথম ত্রৈমাসিক',
      goal: 'গর্ভাবস্থা নিশ্চিত করা, প্রসবের সম্ভাব্য তারিখ নির্ধারণ এবং আপনার স্বাস্থ্যের প্রাথমিক মূল্যায়ন।',
      stepIcon: Icons.calendar_month_rounded,
      activities: [
        ANCActivity(
          title: 'শারীরিক পরীক্ষা',
          icon: Icons.health_and_safety_outlined,
          color: Colors.blue,
        ),
        ANCActivity(
          title: 'রক্তচাপ পরিমাপ',
          icon: Icons.favorite_outline_rounded,
          color: Colors.red,
        ),
        ANCActivity(
          title: 'রক্ত ও প্রস্রাব পরীক্ষা (যেমন: রক্তের গ্রুপ, অ্যানিমিয়া, এইচআইভি এবং সংক্রমণ)',
          icon: Icons.science_outlined,
          color: Colors.purple,
        ),
      ],
    ),
    ANCStep(
      stepNumber: 2,
      title: 'দ্বিতীয় ভিজিট',
      duration: '২০ থেকে ২৪ সপ্তাহ',
      trimester: 'দ্বিতীয় ত্রৈমাসিক',
      goal: 'গর্ভের শিশুর বৃদ্ধি ও বিকাশ পর্যবেক্ষণ করা।',
      stepIcon: Icons.pregnant_woman_rounded,
      activities: [
        ANCActivity(
          title: 'আল্ট্রাসাউন্ড স্ক্যান (সাধারণত ডিটেইলড অ্যানোমালি স্ক্যান)',
          icon: Icons.personal_video_rounded,
          color: Colors.indigo,
        ),
        ANCActivity(
          title: 'ভ্রূণের হৃদস্পন্দন পরীক্ষা',
          icon: Icons.favorite_rounded,
          color: Colors.pink,
        ),
        ANCActivity(
          title: 'ফান্ডাল হাইট মাপা (পেটের উচ্চতা)',
          icon: Icons.straighten_rounded,
          color: Colors.orange,
        ),
      ],
    ),
    ANCStep(
      stepNumber: 3,
      title: 'তৃতীয় ভিজিট',
      duration: '২৮ থেকে ৩২ সপ্তাহ',
      trimester: 'তৃতীয় ত্রৈমাসিক',
      goal: 'পরবর্তী সময়ের জটিলতা যেমন প্রি-এক্লাম্পসিয়া বা জেস্টেশনাল ডায়াবেটিসের জন্য স্ক্রিনিং করা।',
      stepIcon: Icons.medical_services_rounded,
      activities: [
        ANCActivity(
          title: 'রক্তচাপ পরীক্ষা',
          icon: Icons.favorite_border_rounded,
          color: Colors.teal,
        ),
        ANCActivity(
          title: 'প্রস্রাব পরীক্ষা',
          icon: Icons.water_drop_outlined,
          color: Colors.amber,
        ),
        ANCActivity(
          title: 'অ্যানিমিয়ার জন্য পুনরায় রক্ত পরীক্ষা',
          icon: Icons.bloodtype_outlined,
          color: Colors.redAccent,
        ),
      ],
    ),
    ANCStep(
      stepNumber: 4,
      title: 'চতুর্থ ভিজিট',
      duration: '৩৬ সপ্তাহ থেকে প্রসব পর্যন্ত',
      trimester: 'তৃতীয় ত্রৈমাসিক',
      goal: 'প্রসবের জন্য প্রস্তুতি নেওয়া এবং শিশুর অবস্থান (মাথা নিচে) নিশ্চিত করা।',
      stepIcon: Icons.offline_pin_rounded,
      activities: [
        ANCActivity(
          title: 'শিশুর অবস্থান নিশ্চিত করা',
          icon: Icons.child_friendly_rounded,
          color: Colors.deepPurple,
        ),
        ANCActivity(
          title: 'আপনার প্রসব পরিকল্পনা নিয়ে আলোচনা',
          icon: Icons.assignment_outlined,
          color: Colors.blueAccent,
        ),
        ANCActivity(
          title: 'প্রসবের লক্ষণগুলো সম্পর্কে পর্যালোচনা',
          icon: Icons.info_outline_rounded,
          color: Colors.green,
        ),
      ],
    ),
  ];

  void _nextStep() {
    if (_activeStep < _steps.length - 1) {
      setState(() {
        _activeStep++;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    final currentStep = _steps[_activeStep];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          _buildHeader(context),

          // ── Main Stepper & View ─────────────────────────────────────────────
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Custom Stepper Indicator
                        _buildStepper(context),

                        SizedBox(height: 16),

                        // Main Content Card
                        _buildMainCard(context, currentStep),

                        SizedBox(height: 24),

                        // Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _nextStep,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (_activeStep == _steps.length - 1
                                      ? 'ঠিক আছে'
                                      : 'পরবর্তী ধাপ'), style: TextStyle(
                                    
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                if (_activeStep < _steps.length - 1) ...[
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                  child: Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('এএনসি (গর্ভকালীন সেবা)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('আপনার গর্ভকালীন স্বাস্থ্যের ৪টি গুরুত্বপূর্ণ ধাপ', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildStepper(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(_steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              // Line spacer
              final int lineIndex = index ~/ 2;
              final isPassed = lineIndex < _activeStep;
              return Expanded(
                child: Container(
                  height: 3,
                  color: isPassed
                      ? AppColors.primary
                      : AppColors.border.withValues(alpha: 0.6),
                ),
              );
            } else {
              // Step Dot
              final int stepIndex = index ~/ 2;
              final isActive = stepIndex == _activeStep;
              final isPassed = stepIndex < _activeStep;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _activeStep = stepIndex;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : isPassed
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive || isPassed
                          ? AppColors.primary
                          : AppColors.border,
                      width: 2,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '${stepIndex + 1}',
                      style: TextStyle(
                        
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isActive
                            ? Colors.white
                            : isPassed
                                ? AppColors.primary
                                : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
        ),
        SizedBox(height: 8),
        Text(
          'আপনার গর্ভাবস্থার যত্নের ৪টি গুরুত্বপূর্ণ ধাপ'.tr(context),
          style: TextStyle(
            
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMainCard(BuildContext context, ANCStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Step Illustration Card ──────────────────────────────────────────
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primarySurface, Color(0xFFFCE7F3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  step.stepIcon,
                  size: 150,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        step.trimester, style: TextStyle(
                          
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      step.title, style: TextStyle(
                        
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      step.duration.tr(context),
                      style: TextStyle(
                        
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ── Goal Section ────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'লক্ষ্য'.tr(context),
                style: TextStyle(
                  
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 6),
              Text(
                step.goal, style: TextStyle(
                  
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ── Activities Section ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            'মূল কার্যক্রম'.tr(context),
            style: TextStyle(
              
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),

        Column(
          children: step.activities.map((activity) => _buildActivityItem(context, activity)).toList(),
        ),
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context, ANCActivity activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: activity.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activity.icon,
              color: activity.color,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              activity.title, style: TextStyle(
                
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ANCStep {
  final int stepNumber;
  final String title;
  final String duration;
  final String trimester;
  final String goal;
  final List<ANCActivity> activities;
  final IconData stepIcon;

  const ANCStep({
    required this.stepNumber,
    required this.title,
    required this.duration,
    required this.trimester,
    required this.goal,
    required this.activities,
    required this.stepIcon,
  });
}

class ANCActivity {
  final String title;
  final IconData icon;
  final Color color;

  const ANCActivity({
    required this.title,
    required this.icon,
    required this.color,
  });
}
