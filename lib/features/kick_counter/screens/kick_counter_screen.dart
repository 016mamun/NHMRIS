import '../../../core/localization/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/kick_counter_bloc.dart';
import '../bloc/kick_counter_event.dart';
import '../bloc/kick_counter_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_translations.dart';

class KickCounterScreen extends StatelessWidget {
  const KickCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    return BlocProvider(
      create: (_) => KickCounterBloc(),
      child: const _KickCounterView(),
    );
  }
}

class _KickCounterView extends StatelessWidget {
  const _KickCounterView();

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: BlocBuilder<KickCounterBloc, KickCounterState>(
              builder: (context, state) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 40, // Account for vertical padding (16 + 24)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Timer Card Display (Full Width, Neat & Clear)
                            _TimerCard(state: state),

                            // Big Kick Button
                            _KickButton(state: state),

                            // Weekly Chart Card with Integrated Today's Goal Progress!
                            _WeeklyChartCard(state: state),

                            // Info Card
                            _InfoCard(),
                          ],
                        ),
                      ),
                    );
                  },
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
      decoration: BoxDecoration(
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
                      Text('কিক কাউন্টার'.tr(context), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                      Text('শিশুর নড়াচড়া ট্র্যাক করুন'.tr(context), style: TextStyle(fontSize: 12, color: Colors.white70)),
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

}

class _TimerCard extends StatelessWidget {
  final KickCounterState state;
  const _TimerCard({required this.state});

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('সময়'.tr(context), style: AppTextStyles.labelSmall),
          SizedBox(height: 2),
          Text(
            state.formattedTime,
            style: TextStyle(
              
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: state.isRunning
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.primarySurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              state.isRunning ? '● চলমান' : 'শুরু হয়নি',
              style: TextStyle(
                
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: state.isRunning ? AppColors.success : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KickButton extends StatelessWidget {
  final KickCounterState state;
  const _KickButton({required this.state});

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    final isGoal = state.isGoalReached;
    return Column(
      children: [
        GestureDetector(
          onTap: () =>
              context.read<KickCounterBloc>().add(const KickCounterKickAdded()),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: isGoal
                  ? const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    )
                  : AppColors.bannerGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (isGoal ? AppColors.success : AppColors.primary)
                      .withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppConstants.toBengaliNumber(state.kickCount),
                  style: TextStyle(
                    
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  isGoal ? '🎉 লক্ষ্য পূরণ!' : 'কিক',
                  style: TextStyle(
                    
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isGoal
                  ? 'চমৎকার! ১০টি কিক সম্পন্ন হয়েছে।'
                  : 'নড়াচড়া করলে বাটনে চাপ দিন',
              style: TextStyle(
                
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () =>
                  context.read<KickCounterBloc>().add(const KickCounterReset()),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.refresh_rounded, size: 12, color: AppColors.primary),
                    SizedBox(width: 2),
                    Text(
                      'রিসেট'.tr(context),
                      style: TextStyle(
                        
                        fontSize: 11,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.kickCounterBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kickCounterIcon.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.kickCounterIcon,
            size: 18,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '২৮তম সপ্তাহ থেকে প্রতিদিন শিশুর নড়াচড়া গণনা করুন। ২ ঘণ্টার মধ্যে ১০টি কিক স্বাভাবিক।'.tr(context),
              style: AppTextStyles.bodySmall.copyWith(
                
                color: AppColors.kickCounterIcon,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Weekly Chart Card with Integrated Goal Progress ──────────────────────────
class _WeeklyChartCard extends StatelessWidget {
  final KickCounterState state;
  const _WeeklyChartCard({required this.state});

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    // Mock kick data for the last 6 days, and today's dynamic count
    final List<Map<String, dynamic>> weeklyData = [
      {'day': 'শনি', 'count': 11},
      {'day': 'রবি', 'count': 8},
      {'day': 'সোম', 'count': 14},
      {'day': 'মঙ্গল', 'count': 10},
      {'day': 'বুধ', 'count': 12},
      {'day': 'বৃহঃ', 'count': 9},
      {'day': 'আজ', 'count': state.kickCount},
    ];

    // Find the maximum value to scale heights proportionally
    int maxKicks = 15;
    for (final dayData in weeklyData) {
      final count = dayData['count'] as int;
      if (count > maxKicks) {
        maxKicks = count;
      }
    }

    final progress = (state.kickCount / 10).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 3,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'সাপ্তাহিক কিক রেকর্ড'.tr(context),
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                'আজকের লক্ষ্য: ${AppConstants.toBengaliNumber(state.kickCount)} / ১০',
                style: TextStyle(
                  
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Goal Progress Bar integrated directly on top of the chart!
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.primarySurface,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          SizedBox(height: 14),

          // Chart Bars
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyData.map((dayData) {
                final String day = dayData['day'] as String;
                final int count = dayData['count'] as int;
                final bool isToday = day == 'আজ';

                // Proportional height (capped to max 45px height)
                final double barHeight = maxKicks > 0 ? (count / maxKicks) * 45 : 0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Count Label on top
                    Text(
                      AppConstants.toBengaliNumber(count),
                      style: TextStyle(
                        
                        fontSize: 9,
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                        color: isToday ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4),
                    // Bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 12,
                      height: barHeight.clamp(4.0, 45.0),
                      decoration: BoxDecoration(
                        gradient: isToday
                            ? AppColors.primaryGradient
                            : LinearGradient(
                                colors: [
                                  AppColors.primary.withValues(alpha: 0.3),
                                  AppColors.primary.withValues(alpha: 0.15),
                                ],
                              ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(height: 4),
                    // Day Label
                    Text(
                      day,
                      style: TextStyle(
                        
                        fontSize: 10,
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                        color: isToday ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
