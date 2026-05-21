import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/header_banner_widget.dart';
import '../widgets/module_card_widget.dart';
import '../widgets/daily_tip_widget.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../kick_counter/screens/kick_counter_screen.dart';
import '../../doctor_consultation/screens/doctor_consultation_screen.dart';
import '../../nutrition/screens/nutrition_screen.dart';
import '../../weekly_update/screens/weekly_update_screen.dart';
import '../../reminders/screens/reminders_screen.dart';
import '../../delivery_prep/screens/delivery_prep_screen.dart';
import '../../anc/screens/anc_screen.dart';
import '../../profile/screens/profile_edit_screen.dart';
import '../../profile/screens/settings_screen.dart';
import '../../emergency/screens/blood_donor_screen.dart';
import '../../emergency/screens/hospital_directory_screen.dart';
import '../../emergency/screens/helpline_screen.dart';
import '../../emergency/screens/about_app_screen.dart';
import '../../pregnancy_registration/screens/pregnancy_registration_screen.dart';
import '../../../core/localization/app_translations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<DashboardBloc>().add(
        DashboardLoadRequested(userId: authState.user.id),
      );
    }
  }

  void _navigateToModule(String route, BuildContext context) {
    Widget screen;
    switch (route) {
      case '/kick-counter':
        screen = const KickCounterScreen();
        break;
      case '/doctor':
        screen = const DoctorConsultationScreen();
        break;
      case '/nutrition':
        screen = const NutritionScreen();
        break;
      case '/weekly-update':
        screen = const WeeklyUpdateScreen();
        break;
      case '/reminders':
        screen = const RemindersScreen();
        break;
      case '/delivery-prep':
        screen = const DeliveryPrepScreen();
        break;
      case '/pregnancy-reg':
        screen = const PregnancyRegistrationScreen();
        break;
      case '/blood':
        screen = const BloodDonorScreen();
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // ── Purple Header ──────────────────────────────────────────
            _buildAppBar(context),

            // ── Body ───────────────────────────────────────────────────
            Expanded(
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  if (state is DashboardLoaded) {
                    return RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () async {
                        context.read<DashboardBloc>().add(
                          const DashboardRefreshRequested(),
                        );
                        await Future.delayed(
                          const Duration(milliseconds: 400),
                        );
                      },
                      child: CustomScrollView(
                        slivers: [
                          // ── Main Dashboard Banner ──────────────────────
                          SliverToBoxAdapter(
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, authState) {
                                final user = authState is AuthAuthenticated ? authState.user : null;
                                return Container(
                                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6B21A8), Color(0xFF7C3AED)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.monitor_heart_rounded, color: Colors.white, size: 20),
                                          const SizedBox(width: 8),
                                          const Expanded(
                                            child: Text(
                                              'মূল ড্যাশবোর্ড',
                                              style: TextStyle(fontFamily: 'Hind_Siliguri', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.green.withValues(alpha: 0.3),
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.green.shade300, width: 1),
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.circle, color: Colors.greenAccent, size: 8),
                                                SizedBox(width: 4),
                                                Text('লাইভ মনিটরিং চালু', style: TextStyle(fontFamily: 'Hind_Siliguri', color: Colors.white, fontSize: 10)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'গর্ভবতী আয়না — মাতৃ ও শিশু স্বাস্থ্য সেবার সারসংক্ষেপ',
                                        style: TextStyle(fontFamily: 'Hind_Siliguri', color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                                      ),
                                      if (user != null) ...[
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                                              child: Text(user.initials, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(user.name, style: const TextStyle(fontFamily: 'Hind_Siliguri', color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                                                  Text('${user.pregnancyWeeks} সপ্তাহ গর্ভবতী', style: TextStyle(fontFamily: 'Hind_Siliguri', color: Colors.white.withValues(alpha: 0.7), fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // ── Stats Cards ─────────────────────────────────
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 1.7,
                                children: [
                                  _buildStatCard('মোট নিবন্ধিত গর্ভবতী', '৩.৫ মিলিয়ন', '+৪.২%', Icons.people_alt_rounded, const Color(0xFF6B21A8)),
                                  _buildStatCard('ঝুঁকিপূর্ণ গর্ভাবস্থা', '৪৫,২৩০', '⚠ উচ্চ', Icons.warning_amber_rounded, Colors.red.shade600),
                                  _buildStatCard('সক্রিয় রেফারেল', '১,২০৪', 'ট্রান্সিটে', Icons.local_shipping_outlined, Colors.teal.shade600),
                                  _buildStatCard('কমিউনিটি ক্লিনিক', '১৮,৪৫০', 'সক্রিয়', Icons.local_hospital_outlined, Colors.indigo.shade500),
                                ],
                              ),
                            ),
                          ),

                          // ── Monthly Registration Trends (Line Chart) ────
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 2))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.trending_up_rounded, color: Color(0xFF6B21A8), size: 18),
                                      const SizedBox(width: 6),
                                      const Text('মাসিক নিবন্ধন প্রবণতা', style: TextStyle(fontFamily: 'Hind_Siliguri', fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    height: 160,
                                    child: LineChart(
                                      LineChartData(
                                        gridData: FlGridData(
                                          show: true,
                                          drawVerticalLine: false,
                                          getDrawingHorizontalLine: (v) => const FlLine(color: Color(0xFFEEEEEE), strokeWidth: 1),
                                        ),
                                        titlesData: FlTitlesData(
                                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              interval: 1,
                                              getTitlesWidget: (v, _) {
                                                const months = ['জানু', 'ফেব্রু', 'মার্চ', 'এপ্রিল', 'মে', 'জুন'];
                                                if (v.toInt() < months.length) {
                                                  return Text(months[v.toInt()], style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 10, color: Colors.grey));
                                                }
                                                return const SizedBox.shrink();
                                              },
                                            ),
                                          ),
                                        ),
                                        borderData: FlBorderData(show: false),
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: const [
                                              FlSpot(0, 2.6), FlSpot(1, 2.8), FlSpot(2, 3.1),
                                              FlSpot(3, 3.2), FlSpot(4, 3.4), FlSpot(5, 3.5),
                                            ],
                                            isCurved: true,
                                            color: const Color(0xFF7C3AED),
                                            barWidth: 3,
                                            dotData: const FlDotData(show: true),
                                            belowBarData: BarAreaData(
                                              show: true,
                                              color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                                            ),
                                          ),
                                        ],
                                        minY: 2.4,
                                        maxY: 3.7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ── Risk Level Distribution (Donut Chart) ───────
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 2))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.pie_chart_rounded, color: Color(0xFF6B21A8), size: 18),
                                      const SizedBox(width: 6),
                                      const Text('ঝুঁকিমাত্রার বিতরণ', style: TextStyle(fontFamily: 'Hind_Siliguri', fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 160,
                                        width: 160,
                                        child: PieChart(
                                          PieChartData(
                                            sectionsSpace: 2,
                                            centerSpaceRadius: 40,
                                            sections: [
                                              PieChartSectionData(value: 55, color: Colors.teal, title: '', radius: 40),
                                              PieChartSectionData(value: 25, color: Colors.orange, title: '', radius: 40),
                                              PieChartSectionData(value: 15, color: Colors.red.shade400, title: '', radius: 40),
                                              PieChartSectionData(value: 5, color: Colors.red.shade700, title: '', radius: 40),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildLegendItem(Colors.teal, 'কম ঝুঁকি (৫৫%)'),
                                            const SizedBox(height: 8),
                                            _buildLegendItem(Colors.orange, 'মাঝারি ঝুঁকি (২৫%)'),
                                            const SizedBox(height: 8),
                                            _buildLegendItem(Colors.red.shade400, 'উচ্চ ঝুঁকি (১৫%)'),
                                            const SizedBox(height: 8),
                                            _buildLegendItem(Colors.red.shade700, 'ক্রিটিকাল (৫%)'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ── ANC Compliance Bar Chart ─────────────────────
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 2))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.bar_chart_rounded, color: Color(0xFF6B21A8), size: 18),
                                      const SizedBox(width: 6),
                                      const Text('এএনসি মেনে চলা ও মিসড ভিজিট', style: TextStyle(fontFamily: 'Hind_Siliguri', fontWeight: FontWeight.bold, fontSize: 13)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    height: 180,
                                    child: BarChart(
                                      BarChartData(
                                        alignment: BarChartAlignment.spaceAround,
                                        barTouchData: BarTouchData(enabled: false),
                                        titlesData: FlTitlesData(
                                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (v, _) {
                                                const labels = ['ANC 1', 'ANC 2', 'ANC 3', 'ANC 4', 'মিসড'];
                                                if (v.toInt() < labels.length) {
                                                  return Text(labels[v.toInt()], style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 10, color: Colors.grey));
                                                }
                                                return const SizedBox.shrink();
                                              },
                                            ),
                                          ),
                                        ),
                                        gridData: const FlGridData(show: false),
                                        borderData: FlBorderData(show: false),
                                        barGroups: [
                                          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 88, color: Colors.blue.shade400, width: 28, borderRadius: BorderRadius.circular(4))]),
                                          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 75, color: Colors.teal, width: 28, borderRadius: BorderRadius.circular(4))]),
                                          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 65, color: Colors.purple.shade400, width: 28, borderRadius: BorderRadius.circular(4))]),
                                          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 72, color: Colors.green.shade500, width: 28, borderRadius: BorderRadius.circular(4))]),
                                          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 18, color: Colors.red.shade400, width: 28, borderRadius: BorderRadius.circular(4))]),
                                        ],
                                        maxY: 100,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ── Quick Actions ────────────────────────────────
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 2))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.flash_on_rounded, color: Color(0xFF6B21A8), size: 18),
                                      const SizedBox(width: 6),
                                      const Text('দ্রুত অ্যাকশন', style: TextStyle(fontFamily: 'Hind_Siliguri', fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  const Text('মাতৃ স্বাস্থ্য সেবার গুরুত্বপূর্ণ ফিচারগুলোতে সরাসরি প্রবেশ করুন', style: TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 11, color: Colors.grey)),
                                  const SizedBox(height: 12),
                                  _buildQuickActionItem(context, Icons.pregnant_woman_rounded, 'গর্ভাবস্থা ট্র্যাকার', const Color(0xFF7C3AED), '/kick-counter'),
                                  _buildQuickActionItem(context, Icons.assignment_add, 'গর্ভবতী নিবন্ধন', Colors.green.shade600, '/pregnancy-reg'),
                                  _buildQuickActionItem(context, Icons.restaurant_menu_rounded, 'পুষ্টি ও ডায়েট গাইড', Colors.orange.shade600, '/nutrition'),
                                  _buildQuickActionItem(context, Icons.bloodtype_outlined, 'জরুরি রক্তের গ্রুপ', Colors.red.shade600, '/blood'),
                                ],
                              ),
                            ),
                          ),

                          // ── Module Grid ──────────────────────────────────
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                              child: Row(
                                children: [
                                  Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4))),
                                  const SizedBox(width: 10),
                                  Text('আপনার মডিউল সমূহ'.tr(context), style: AppTextStyles.headingMedium),
                                ],
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                            sliver: SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final module = state.modules[index];
                                  return ModuleCardWidget(
                                    module: module,
                                    onTap: () => _navigateToModule(module.route, context),
                                  );
                                },
                                childCount: state.modules.length,
                              ),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                            ),
                          ),

                          // Daily Tip
                          if (state.showTip)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24, bottom: 8),
                                child: DailyTipWidget(
                                  tip: state.dailyTip,
                                  onDismiss: () => context.read<DashboardBloc>().add(const DashboardTipDismissed()),
                                  onDetails: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                                      builder: (_) => _TipDetailSheet(tip: state.dailyTip),
                                    );
                                  },
                                ),
                              ),
                            ),

                          const SliverToBoxAdapter(child: SizedBox(height: 32)),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_rounded, 'হোম'.tr(context)),
                  _buildNavItem(1, Icons.pregnant_woman_rounded, 'গর্ভাবস্থা'.tr(context)),
                  _buildNavItem(2, Icons.child_care_rounded, 'শিশুর জন্য'.tr(context)),
                  _buildNavItem(3, Icons.person_rounded, 'প্রোফাইল'.tr(context)),
                  _buildNavItem(4, Icons.menu_rounded, 'আরও'.tr(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        if (index == 1) {
          _showPregnancyMenu(context);
        } else if (index == 2) {
          _showBabyMenu(context);
        } else if (index == 3) {
          _showProfileMenu(context);
        } else if (index == 4) {
          _showMoreMenu(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Hind_Siliguri',
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Row(
            children: [
              // Brand Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'গর্ভবতী আয়না'.tr(context),
                style: AppTextStyles.onPrimaryHeading,
              ),
              const Spacer(),

              // Profile Avatar
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String name = 'ম';
                  String subtitle = 'প্রোফাইল দেখুন';
                  if (state is AuthAuthenticated) {
                    name = state.user.initials;
                    subtitle = state.user.name;
                  }
                  return GestureDetector(
                    onTap: () => _showProfileMenu(context),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 19,
                          backgroundColor: AppColors.primaryDark,
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subtitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'প্রোফাইল দেখুন'.tr(context),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ProfileMenuSheet(
        onLogout: () {
          Navigator.pop(context);
          context.read<AuthBloc>().add(const AuthLogoutRequested());
        },
      ),
    ).then((_) {
      setState(() {
        _currentIndex = 0;
      });
    });
  }

  void _showPregnancyMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _PregnancyMenuSheet(
        onModuleTap: (route) => _navigateToModule(route, context),
      ),
    ).then((_) {
      setState(() {
        _currentIndex = 0;
      });
    });
  }

  void _showBabyMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _BabyMenuSheet(
        onModuleTap: (route) => _navigateToModule(route, context),
      ),
    ).then((_) {
      setState(() {
        _currentIndex = 0;
      });
    });
  }

  void _showMoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _MoreMenuSheet(),
    ).then((_) {
      setState(() {
        _currentIndex = 0;
      });
    });
  }

  Widget _buildStatCard(String title, String value, String badge, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(title, style: TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 10, color: Colors.grey.shade600), maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          Text(value, style: TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 15, fontWeight: FontWeight.bold, color: color)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(badge, style: TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 9, color: color, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 11, color: Colors.black87))),
      ],
    );
  }

  Widget _buildQuickActionItem(BuildContext context, IconData icon, String label, Color color, String route) {
    return InkWell(
      onTap: () => _navigateToModule(route, context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 10),
            Expanded(child: Text(label, style: TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 13, color: color, fontWeight: FontWeight.w500))),
            Icon(Icons.arrow_forward_ios_rounded, size: 12, color: color.withValues(alpha: 0.6)),
          ],
        ),
      ),
    );
  }
}

// ── Tip Detail Bottom Sheet ──────────────────────────────────────────────────
class _TipDetailSheet extends StatelessWidget {
  final String tip;
  const _TipDetailSheet({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text('💧', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text('আজকের টিপস', style: AppTextStyles.headingMedium),
          const SizedBox(height: 12),
          Text(
            tip,
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ঠিক আছে'),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
      ),
    );
  }
}

// ── Profile Menu Bottom Sheet ─────────────────────────────────────────────────
class _ProfileMenuSheet extends StatelessWidget {
  final VoidCallback onLogout;
  const _ProfileMenuSheet({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        return Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.primarySurface,
                child: Text(
                  user?.initials ?? 'ম',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user?.name ?? '',
                style: AppTextStyles.headingMedium,
              ),
              Text(
                user?.phone ?? '',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text('প্রোফাইল সম্পাদনা'.tr(context)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) => const ProfileEditScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text('সেটিংস'.tr(context)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) => const SettingsScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.error,
                ),
                title: Text(
                  'লগআউট'.tr(context),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
                onTap: onLogout,
              ),
              const SizedBox(height: 12),
            ],
          ),
          ),
        );
      },
    );
  }
}

// ── Pregnancy Menu Sheet ──────────────────────────────────────────────────────
class _PregnancyMenuSheet extends StatelessWidget {
  final Function(String) onModuleTap;
  const _PregnancyMenuSheet({required this.onModuleTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          Text('গর্ভাবস্থা ট্র্যাকার সমূহ'.tr(context), style: AppTextStyles.headingMedium),
          const SizedBox(height: 16),
          _buildMenuItem(context, Icons.pregnant_woman_rounded, 'কিক কাউন্টার', '/kick-counter', AppColors.kickCounterIcon),
          _buildMenuItem(context, Icons.restaurant_menu_rounded, 'পুষ্টি ও ডায়েট গাইড', '/nutrition', AppColors.nutritionIcon),
          _buildMenuItem(context, Icons.checklist_rounded, 'ডেলিভারির প্রস্তুতি', '/delivery-prep', AppColors.deliveryIcon),
          _buildMenuItem(context, Icons.local_hospital_outlined, 'ডাক্তার পরামর্শ', '/doctor', AppColors.doctorIcon),
          const SizedBox(height: 12),
        ],
      ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String route, Color color) {
    return ListTile(
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Center(child: Icon(icon, color: color, size: 20)),
      ),
      title: Text(title.tr(context), style: AppTextStyles.labelMedium),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: () {
        Navigator.pop(context);
        onModuleTap(route);
      },
    );
  }
}

// ── Baby Menu Sheet ───────────────────────────────────────────────────────────
class _BabyMenuSheet extends StatelessWidget {
  final Function(String) onModuleTap;
  const _BabyMenuSheet({required this.onModuleTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          Text('শিশুর জন্য সেবা সমূহ'.tr(context), style: AppTextStyles.headingMedium),
          const SizedBox(height: 16),
          _buildMenuItem(context, Icons.calendar_month_rounded, 'সাপ্তাহিক বেবি আপডেট', '/weekly-update', AppColors.weeklyIcon),
          _buildMenuItem(context, Icons.vaccines_rounded, 'শিশুর টিকা সূচি', '/reminders', AppColors.reminderIcon),
          _buildMenuItem(context, Icons.child_care_rounded, 'শিশুর পুষ্টি ও যত্ন', '/nutrition', AppColors.nutritionIcon),
          const SizedBox(height: 12),
        ],
      ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String route, Color color) {
    return ListTile(
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Center(child: Icon(icon, color: color, size: 20)),
      ),
      title: Text(title.tr(context), style: AppTextStyles.labelMedium),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: () {
        Navigator.pop(context);
        onModuleTap(route);
      },
    );
  }
}

// ── More Menu Sheet ───────────────────────────────────────────────────────────
class _MoreMenuSheet extends StatelessWidget {
  const _MoreMenuSheet();

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          Text('আরও ফিচার সমূহ'.tr(context), style: AppTextStyles.headingMedium),
          const SizedBox(height: 16),
          _buildMenuItem(
            context,
            Icons.assignment_add,
            'গর্ভবতী নিবন্ধন ও সেবা কার্ড',
            AppColors.success,
            () => _navigateToScreen(context, const PregnancyRegistrationScreen()),
          ),
          _buildMenuItem(
            context,
            Icons.baby_changing_station_rounded,
            'এএনসি (গর্ভকালীন সেবা)',
            AppColors.primary,
            () => _navigateToScreen(context, const ANCScreen()),
          ),
          _buildMenuItem(
            context,
            Icons.bloodtype_outlined,
            'জরুরি রক্তের গ্রুপ',
            AppColors.error,
            () => _navigateToScreen(context, const BloodDonorScreen()),
          ),
          _buildMenuItem(
            context,
            Icons.local_hospital_outlined,
            'নিকটস্থ হাসপাতাল',
            AppColors.primary,
            () => _navigateToScreen(context, const HospitalDirectoryScreen()),
          ),
          _buildMenuItem(
            context,
            Icons.phone_in_talk_outlined,
            'জরুরি যোগাযোগ (হেল্পলাইন)',
            AppColors.success,
            () => _navigateToScreen(context, const HelplineScreen()),
          ),
          _buildMenuItem(
            context,
            Icons.info_outline,
            'অ্যাপ সম্পর্কে জানুন',
            AppColors.textSecondary,
            () => _navigateToScreen(context, const AboutAppScreen()),
          ),
          const SizedBox(height: 12),
        ],
      ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Center(child: Icon(icon, color: color, size: 20)),
      ),
      title: Text(title.tr(context), style: AppTextStyles.labelMedium),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }
}
