import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/localization/language_cubit.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';

import '../../anc/screens/mayer_shastho_screen.dart';
import '../../delivery_prep/screens/babar_koronio_screen.dart';
import '../../doctor_consultation/screens/gorvokalin_shastho_somossha_screen.dart';
import '../../anc/screens/gorvokalin_sheba_screen.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../dashboard/bloc/dashboard_state.dart';
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
import '../../pregnancy_registration/screens/pregnancy_setup_flow_screen.dart';
import 'baby_profile_screen.dart';
import 'baby_profile_edit_screen.dart';
import '../../health_tips/screens/daily_tips_screen.dart';
import '../../health_tips/screens/common_problems_screen.dart';
import '../../health_tips/screens/complications_screen.dart';
import '../../health_tips/screens/medicine_guide_screen.dart';
import '../../health_tips/screens/kegel_exercise_screen.dart';
import '../../health_tips/screens/bmi_calculator_screen.dart';
import '../../health_tips/screens/gmp_chart_screen.dart';
import '../../anc/screens/pnc_screen.dart';
import '../../reminders/screens/newborn_care_screen.dart';
import '../../reminders/screens/baby_food_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  final ScrollController _scrollCtrl = ScrollController();
  bool _headerCollapsed = false;
  int? _selectedWeek;
  bool _isSummaryExpanded = false;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();

    _scrollCtrl.addListener(() {
      final collapsed = _scrollCtrl.offset > 60;
      if (collapsed != _headerCollapsed) {
        setState(() => _headerCollapsed = collapsed);
      }
    });

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<DashboardBloc>().add(
        DashboardLoadRequested(userId: authState.user.id),
      );
    }
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  Future<void> _navigateToScreen(Widget screen) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => screen,
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: _buildBottomNavBar(context),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            return FadeTransition(
              opacity: _fadeAnim,
              child: NestedScrollView(
                controller: _scrollCtrl,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  _buildSliverAppBar(context),
                ],
                body: RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async {
                    context.read<DashboardBloc>().add(const DashboardRefreshRequested());
                    await Future.delayed(const Duration(milliseconds: 400));
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Pregnancy Progress Card ──────────────────────
                        _buildPregnancyProgressCard(context),

                        // ── Section: শিশু ও মায়ের তথ্য ─────────────────
                        _buildSectionTitle('শিশু ও মায়ের তথ্য'.tr(context), Icons.child_care_rounded, AppColors.primary),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'প্রতিদিনের টিপস'.tr(context),
                            icon: Icons.tips_and_updates_rounded,
                            color: const Color(0xFF7C3AED),
                            bgColor: const Color(0xFFEDE7F6),
                            subtitle: 'দৈনিক স্বাস্থ্য টিপস ও পরামর্শ'.tr(context),
                            onTap: () => _navigateToScreen(const DailyTipsScreen()),
                          ),
                          _buildFeatureCard(
                            title: 'গর্ভের শিশুর অবস্থা'.tr(context),
                            icon: Icons.monitor_heart_rounded,
                            color: const Color(0xFF2196F3),
                            bgColor: const Color(0xFFE3F2FD),
                            subtitle: 'শিশু 3D ছবি, দৈর্ঘ্য, ওজন, ধাপ'.tr(context),
                            onTap: () => _navigateToScreen(const WeeklyUpdateScreen()),
                          ),
                        ),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'মায়ের স্বাস্থ্য'.tr(context),
                            icon: Icons.woman_rounded,
                            color: const Color(0xFFEC407A),
                            bgColor: const Color(0xFFFCE4EC),
                            subtitle: 'মায়ের বিস্তারিত অবস্থা ও সমস্যা'.tr(context),
                            onTap: () => _navigateToScreen(const MayerShasthoScreen()),
                          ),
                          _buildFeatureCard(
                            title: 'বাবার করণীয়'.tr(context),
                            icon: Icons.man_rounded,
                            color: const Color(0xFF00897B),
                            bgColor: const Color(0xFFE0F2F1),
                            subtitle: 'বাবার দায়িত্ব ও কর্তব্য'.tr(context),
                            onTap: () => _navigateToScreen(const BabarKoronioScreen()),
                          ),
                        ),

                        // ── Section: গর্ভবতী সেবা ────────────────────────
                        _buildSectionTitle('গর্ভবতী সেবা'.tr(context), Icons.pregnant_woman_rounded, const Color(0xFF7C3AED)),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'গর্ভবতী নিবন্ধন'.tr(context),
                            icon: Icons.app_registration_rounded,
                            color: const Color(0xFF43A047),
                            bgColor: const Color(0xFFE8F5E9),
                            subtitle: 'সেবা কার্ড ও নিবন্ধন'.tr(context),
                            onTap: () => _navigateToScreen(const PregnancyRegistrationScreen()),
                          ),
                          _buildFeatureCard(
                            title: 'খাদ্য তালিকা ও পুষ্টি'.tr(context),
                            icon: Icons.restaurant_menu_rounded,
                            color: const Color(0xFFFF8F00),
                            bgColor: const Color(0xFFFFF3E0),
                            subtitle: 'পুষ্টিকর খাদ্য পরিকল্পনা'.tr(context),
                            onTap: () => _navigateToScreen(const NutritionScreen()),
                          ),
                        ),
                        _buildFullWidthCard(
                          title: 'গর্ভকালীন স্বাস্থ্য সমস্যা ও সমাধান'.tr(context),
                          icon: Icons.medical_information_rounded,
                          color: const Color(0xFF5E35B1),
                          bgColor: const Color(0xFFEDE7F6),
                          subtitle: 'সকল গর্ভকালীন জটিলতা ও পরামর্শ'.tr(context),
                          onTap: () => _navigateToScreen(const GorvokalinShasthoSomosshaScreen()),
                        ),

                        // ── Section: স্বাস্থ্য সমস্যা ───────────────────
                        _buildSectionTitle('স্বাস্থ্য ও জটিলতা'.tr(context), Icons.health_and_safety_rounded, const Color(0xFFE53935)),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'সাধারণ সমস্যা ও সমাধান'.tr(context),
                            icon: Icons.warning_amber_rounded,
                            color: const Color(0xFFE53935),
                            bgColor: const Color(0xFFFFEBEE),
                            subtitle: 'জরুরি স্বাস্থ্য তথ্য'.tr(context),
                            onTap: () => _navigateToScreen(const CommonProblemsScreen()),
                          ),
                          _buildFeatureCard(
                            title: 'গর্ভকালীন জটিলতা ও করণীয়'.tr(context),
                            icon: Icons.emergency_rounded,
                            color: const Color(0xFFD81B60),
                            bgColor: const Color(0xFFFCE4EC),
                            subtitle: 'জরুরি পদক্ষেপ'.tr(context),
                            onTap: () => _navigateToScreen(const ComplicationsScreen()),
                          ),
                        ),
                        _buildFullWidthCard(
                          title: 'ওষুধ, চিকিৎসা ও পরীক্ষা'.tr(context),
                          icon: Icons.science_rounded,
                          color: const Color(0xFF0277BD),
                          bgColor: const Color(0xFFE1F5FE),
                          subtitle: 'ল্যাব রিপোর্ট ও পরীক্ষার ফলাফল বিশ্লেষণ'.tr(context),
                          onTap: () => _navigateToScreen(const MedicineguideScreen()),
                        ),

                        // ── Section: ANC ও PNC সেবা ────────────────────
                        _buildSectionTitle('ANC ও PNC সেবা'.tr(context), Icons.baby_changing_station_rounded, const Color(0xFF00897B)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'প্রসবপূর্ব (ANC) সেবা আপডেট'.tr(context),
                            icon: Icons.pregnant_woman_rounded,
                            color: const Color(0xFF7C3AED),
                            bgColor: const Color(0xFFEDE7F6),
                            onTap: () => _navigateToScreen(const ANCScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'গর্ভকালীন সেবা ও করণীয়'.tr(context),
                            icon: Icons.medical_services_rounded,
                            color: const Color(0xFF00897B),
                            bgColor: const Color(0xFFE0F2F1),
                            onTap: () => _navigateToScreen(const GorvokalinShebaScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'প্রসব পরবর্তী (PNC) সেবা আপডেট'.tr(context),
                            icon: Icons.child_friendly_rounded,
                            color: const Color(0xFFEC407A),
                            bgColor: const Color(0xFFFCE4EC),
                            onTap: () => _navigateToScreen(const PncScreen()),
                          ),
                        ),

                        // ── Section: জরুরি সেবা ────────────────────────
                        _buildSectionTitle('জরুরি সেবা'.tr(context), Icons.emergency_rounded, const Color(0xFFE53935)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'রক্তদাতা'.tr(context),
                            icon: Icons.bloodtype_rounded,
                            color: const Color(0xFFE53935),
                            bgColor: const Color(0xFFFFEBEE),
                            onTap: () => _navigateToScreen(const BloodDonorScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'জরুরি যোগাযোগ নম্বর'.tr(context),
                            icon: Icons.phone_in_talk_rounded,
                            color: const Color(0xFF1E88E5),
                            bgColor: const Color(0xFFE3F2FD),
                            onTap: () => _navigateToScreen(const HelplineScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'স্বাস্থ্যকেন্দ্র/হাসপাতাল'.tr(context),
                            icon: Icons.local_hospital_rounded,
                            color: const Color(0xFF00897B),
                            bgColor: const Color(0xFFE0F2F1),
                            badge: 'GPS',
                            onTap: () => _navigateToScreen(const HospitalDirectoryScreen()),
                          ),
                        ),

                        // ── Section: নবজাতকের সেবা ────────────────────
                        _buildSectionTitle('নবজাতকের সেবা'.tr(context), Icons.child_care_rounded, const Color(0xFF43A047)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'নবজাতকের যত্ন ও পুষ্টি'.tr(context),
                            icon: Icons.baby_changing_station_rounded,
                            color: const Color(0xFF43A047),
                            bgColor: const Color(0xFFE8F5E9),
                            onTap: () => _navigateToScreen(const NewbornCareScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'টিকা'.tr(context),
                            icon: Icons.vaccines_rounded,
                            color: const Color(0xFFEC407A),
                            bgColor: const Color(0xFFFCE4EC),
                            onTap: () => _navigateToScreen(const RemindersScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'শিশুর খাদ্য তালিকা'.tr(context),
                            icon: Icons.restaurant_rounded,
                            color: const Color(0xFFFF8F00),
                            bgColor: const Color(0xFFFFF3E0),
                            onTap: () => _navigateToScreen(const BabyFoodScreen()),
                          ),
                        ),

                        // ── Section: টুলস ─────────────────────────────
                        _buildSectionTitle('স্বাস্থ্য টুলস'.tr(context), Icons.build_circle_rounded, const Color(0xFF5E35B1)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'গর্ভের শিশুর নড়াচড়া'.tr(context),
                            icon: Icons.touch_app_rounded,
                            color: const Color(0xFF7C3AED),
                            bgColor: const Color(0xFFEDE7F6),
                            onTap: () => _navigateToScreen(const KickCounterScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'Kegel ব্যায়াম'.tr(context),
                            icon: Icons.fitness_center_rounded,
                            color: const Color(0xFFD81B60),
                            bgColor: const Color(0xFFFCE4EC),
                            onTap: () => _navigateToScreen(const KegelExerciseScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'BMI Calculator'.tr(context),
                            icon: Icons.calculate_rounded,
                            color: const Color(0xFF1E88E5),
                            bgColor: const Color(0xFFE3F2FD),
                            onTap: () => _navigateToScreen(const BmiCalculatorScreen()),
                          ),
                        ),
                        _buildFullWidthCard(
                          title: 'GMP চার্ট'.tr(context),
                          icon: Icons.bar_chart_rounded,
                          color: const Color(0xFF00897B),
                          bgColor: const Color(0xFFE0F2F1),
                          subtitle: 'শিশুর বৃদ্ধির মনিটরিং চার্ট (Growth Monitoring Programme)'.tr(context),
                          onTap: () => _navigateToScreen(const GmpChartScreen()),
                        ),

                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
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
              Expanded(child: _buildNavItem(0, Icons.home_rounded, 'হোম'.tr(context))),
              Expanded(child: _buildNavItem(1, Icons.medical_services_rounded, 'পরামর্শ'.tr(context))),
              Expanded(child: _buildNavItem(2, Icons.track_changes_rounded, 'ট্র্যাকার'.tr(context))),
              Expanded(child: _buildNavItem(3, Icons.local_hospital_rounded, 'হাসপাতাল'.tr(context))),
              Expanded(child: _buildNavItem(4, Icons.menu_rounded, 'আরও'.tr(context))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppColors.primary : Colors.grey.shade600;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        if (index == 1) {
          _navigateToScreen(const DoctorConsultationScreen()).then((_) {
            if (mounted) setState(() => _currentIndex = 0);
          });
        } else if (index == 2) {
          _showTrackerMenu(context);
        } else if (index == 3) {
          _navigateToScreen(const HospitalDirectoryScreen()).then((_) {
            if (mounted) setState(() => _currentIndex = 0);
          });
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
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showTrackerMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _TrackerMenuSheet(
        onModuleTap: (screen) => _navigateToScreen(screen),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = 0;
        });
      }
    });
  }

  void _showMoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _MoreMenuSheet(
        onModuleTap: (screen) => _navigateToScreen(screen),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = 0;
        });
      }
    });
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
      ),
      title: _buildAppBarContent(context),
    );
  }

  Widget _buildAppBarContent(BuildContext context) {
    return Row(
      children: [
        // Logo
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              'assets/images/child-mother.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 8),
        // App Title
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'গর্ভবতী আয়না',
                style: AppTextStyles.onPrimaryHeading.copyWith(fontSize: 16),
              ),
              Text(
                'NHMRIS · মাতৃস্বাস্থ্য',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        // Profile Avatar
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String initials = 'ম'.tr(context);
            String name = 'প্রোফাইল'.tr(context);
            if (state is AuthAuthenticated) {
              name = state.user.name.tr(context);
              initials = name.isNotEmpty ? name[0] : 'ম'.tr(context);
            }
            return GestureDetector(
              onTap: () => _showProfileBottomSheet(context),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'প্রোফাইল দেখুন'.tr(context),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primaryDark,
                    child: Text(
                      initials,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTaglineBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSloganDialog(context),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7C4FC4), Color(0xFF5B2D9A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.format_quote_rounded, color: Colors.white, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"নিরাপদ হোক প্রতিটি প্রসব, যত্নে থাকুক মা ও নবজাতক"'.tr(context),
                    style: TextStyle(
                      
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'একনজরে দেখুন →'.tr(context),
                        style: TextStyle(
                          
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPregnancyProgressCard(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        int currentWeeks = 26;
        DateTime? edd;
        
        if (state is AuthAuthenticated) {
          final user = state.user;
          // Get EDD from unborn baby
          if (user.babies.isEmpty) {
            currentWeeks = user.pregnancyWeeks;
          } else {
            final unbornBaby = user.babies.firstWhere(
              (b) => !b.isBorn,
              orElse: () => user.babies.first,
            );
            if (unbornBaby.birthDate != null) {
              try {
                edd = DateTime.parse(unbornBaby.birthDate!);
              } catch (e) {
                edd = null;
              }
            }
            
            // Calculate current week based on EDD
            if (edd != null) {
              final now = DateTime.now();
              final differenceDays = edd.difference(now).inDays;
              final daysPassed = 280 - differenceDays;
              currentWeeks = daysPassed ~/ 7;
              if (currentWeeks < 1) currentWeeks = 1;
              if (currentWeeks > 42) currentWeeks = 42;
            } else {
              currentWeeks = user.pregnancyWeeks;
            }
          }
        }
        
        int weeks = _selectedWeek ?? currentWeeks;
        if (weeks < 1) weeks = 1;
        if (weeks > 42) weeks = 42;

        // Weekly baby size data
        const weeklyInfo = {
          1: {'bn': 'একটি বীজ', 'en': 'A seed', 'emoji': '🌱'},
          2: {'bn': 'একটি তিলের দানা', 'en': 'A sesame seed', 'emoji': '🌾'},
          3: {'bn': 'একটি মটর দানা', 'en': 'A pea', 'emoji': '🫛'},
          4: {'bn': 'একটি সরিষা দানা', 'en': 'A poppy seed', 'emoji': '🌿'},
          5: {'bn': 'একটি তিল', 'en': 'A sesame', 'emoji': '🌱'},
          6: {'bn': 'একটি মসুর ডাল', 'en': 'A lentil', 'emoji': '🫘'},
          7: {'bn': 'একটি মটরশুটি', 'en': 'A blueberry', 'emoji': '🫐'},
          8: {'bn': 'একটি আঙুর', 'en': 'A grape', 'emoji': '🍇'},
          9: {'bn': 'একটি জলপাই', 'en': 'An olive', 'emoji': '🫒'},
          10: {'bn': 'একটি স্ট্রবেরি', 'en': 'A strawberry', 'emoji': '🍓'},
          11: {'bn': 'একটি ডুমুর', 'en': 'A fig', 'emoji': '🫐'},
          12: {'bn': 'একটি লেবু', 'en': 'A lemon', 'emoji': '🍋'},
          13: {'bn': 'একটি মটর', 'en': 'A peach', 'emoji': '🍑'},
          14: {'bn': 'একটি কমলা', 'en': 'An orange', 'emoji': '🍊'},
          15: {'bn': 'একটি আপেল', 'en': 'An apple', 'emoji': '🍎'},
          16: {'bn': 'একটি নাশপাতি', 'en': 'A pear', 'emoji': '🍐'},
          17: {'bn': 'একটি ডালিম', 'en': 'A pomegranate', 'emoji': '🍈'},
          18: {'bn': 'একটি মিষ্টি আলু', 'en': 'A sweet potato', 'emoji': '🍠'},
          19: {'bn': 'একটি আম', 'en': 'A mango', 'emoji': '🥭'},
          20: {'bn': 'একটি কলা', 'en': 'A banana', 'emoji': '🍌'},
          21: {'bn': 'একটি গাজর', 'en': 'A carrot', 'emoji': '🥕'},
          22: {'bn': 'একটি কচুর লতি', 'en': 'A corn', 'emoji': '🌽'},
          23: {'bn': 'একটি বড় আম', 'en': 'A large mango', 'emoji': '🥭'},
          24: {'bn': 'একটি ভুট্টা', 'en': 'A corn cob', 'emoji': '🌽'},
          25: {'bn': 'একটি ফুলকপি', 'en': 'A cauliflower', 'emoji': '🥦'},
          26: {'bn': 'একটি ঝিঙ্গা', 'en': 'A ridge gourd', 'emoji': '🥒'},
          27: {'bn': 'একটি বাঁধাকপি', 'en': 'A cabbage', 'emoji': '🥬'},
          28: {'bn': 'একটি বেগুন', 'en': 'An eggplant', 'emoji': '🍆'},
          29: {'bn': 'একটি আনারস', 'en': 'A pineapple', 'emoji': '🍍'},
          30: {'bn': 'একটি তরমুজ', 'en': 'A watermelon', 'emoji': '🍉'},
          31: {'bn': 'একটি নারকেল', 'en': 'A coconut', 'emoji': '🥥'},
          32: {'bn': 'একটি নারকেল', 'en': 'A coconut', 'emoji': '🥥'},
          33: {'bn': 'একটি আনারস', 'en': 'A pineapple', 'emoji': '🍍'},
          34: {'bn': 'একটি কুমড়া', 'en': 'A pumpkin', 'emoji': '🎃'},
          35: {'bn': 'একটি মাঝারি কুমড়া', 'en': 'A medium pumpkin', 'emoji': '🎃'},
          36: {'bn': 'একটি লেটুস', 'en': 'A head of lettuce', 'emoji': '🥬'},
          37: {'bn': 'একটি বড় বাঁধাকপি', 'en': 'A large cabbage', 'emoji': '🥬'},
          38: {'bn': 'একটি লাউ', 'en': 'A bottle gourd', 'emoji': '🎃'},
          39: {'bn': 'একটি ছোট তরমুজ', 'en': 'A small watermelon', 'emoji': '🍉'},
          40: {'bn': 'একটি কুমড়া', 'en': 'A pumpkin', 'emoji': '🎃'},
          41: {'bn': 'একটি তরমুজ', 'en': 'A watermelon', 'emoji': '🍉'},
          42: {'bn': 'একটি কাঁঠাল', 'en': 'A jackfruit', 'emoji': '🍈'},
        };

        final info = weeklyInfo[weeks] ?? weeklyInfo[26]!;
        final isEnglish = context.read<LanguageCubit>().state == 'English';
        final sizeName = isEnglish ? info['en']! : info['bn']!;
        final emoji = info['emoji']!;

        // Date range for selected week (based on EDD)
        final now = DateTime.now();
        DateTime lmp;
        if (edd != null) {
          lmp = edd.subtract(const Duration(days: 280));
        } else {
          lmp = now.subtract(Duration(days: (currentWeeks - 1) * 7));
        }
        
        // Calculate week start and end based on LMP
        final weekStart = lmp.add(Duration(days: (weeks - 1) * 7));
        final weekEnd = weekStart.add(const Duration(days: 6));
        final dateRange = '${weekStart.day.toString().padLeft(2, '0')} ${_monthNameShort(weekStart.month)} - ${weekEnd.day.toString().padLeft(2, '0')} ${_monthNameShort(weekEnd.month)}';

        // Expected delivery date (use EDD from baby profile)
        String expectedDeliveryStr = '';
        if (edd != null) {
          expectedDeliveryStr = '${edd.day.toString().padLeft(2, '0')} ${_monthName(edd.month)}, ${edd.year}';
        } else {
          final lmp = now.subtract(Duration(days: (currentWeeks - 1) * 7));
          final calculatedEdd = lmp.add(const Duration(days: 280));
          expectedDeliveryStr = '${calculatedEdd.day.toString().padLeft(2, '0')} ${_monthName(calculatedEdd.month)}, ${calculatedEdd.year}';
        }

        // Ongoing days (total pregnancy progress in months and days)
        int totalDaysPassed = 0;
        if (edd != null) {
          final now = DateTime.now();
          final differenceDays = edd.difference(now).inDays;
          totalDaysPassed = 280 - differenceDays;
        } else {
          totalDaysPassed = (currentWeeks - 1) * 7 + now.weekday;
        }
        
        // Convert to months and days (1 month = 30 days)
        int totalMonths = totalDaysPassed ~/ 30;
        int remainingDays = totalDaysPassed % 30;
        if (totalMonths > 10) {
          totalMonths = 10;
          remainingDays = totalDaysPassed - (10 * 30);
          if (remainingDays < 0) remainingDays = 0;
        }

        return _WeeklyProgressCard(
          weeks: weeks,
          emoji: emoji,
          sizeName: sizeName,
          dateRange: dateRange,
          isEnglish: isEnglish,
          totalMonths: totalMonths,
          remainingDays: remainingDays,
          expectedDeliveryDate: expectedDeliveryStr,
          isExpanded: _isSummaryExpanded,
          onPrevWeek: () {
            setState(() {
              _selectedWeek = (weeks - 1).clamp(1, 42);
            });
          },
          onNextWeek: () {
            setState(() {
              _selectedWeek = (weeks + 1).clamp(1, 42);
            });
          },
          onToggleSummary: () {
            setState(() {
              _isSummaryExpanded = !_isSummaryExpanded;
            });
          },
        );
      },
    );
  }

  Widget _WeeklyProgressCard({
    required int weeks,
    required String emoji,
    required String sizeName,
    required String dateRange,
    required bool isEnglish,
    required int totalMonths,
    required int remainingDays,
    required String expectedDeliveryDate,
    required bool isExpanded,
    required VoidCallback onPrevWeek,
    required VoidCallback onNextWeek,
    required VoidCallback onToggleSummary,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: weeks > 1 ? onPrevWeek : null,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: weeks > 1 ? Colors.grey.shade100 : Colors.grey.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: weeks > 1 ? Colors.grey.shade600 : Colors.grey.shade300),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            dateRange,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isEnglish ? 'Week $weeks ongoing' : '$weeksতম সপ্তাহ চলছে',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: weeks < 42 ? onNextWeek : null,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: weeks < 42 ? Colors.grey.shade100 : Colors.grey.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: weeks < 42 ? Colors.grey.shade600 : Colors.grey.shade300),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade200, thickness: 1),
                const SizedBox(height: 16),
                // Bottom section
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isEnglish ? 'Baby size is about' : 'শিশুর আকৃতি প্রায়',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            sizeName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isEnglish ? 'in size' : 'এর সমান',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image / Emoji
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 60),
                    ),
                  ],
                ),
                
                // Expanded summary section
                if (isExpanded) ...[
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.shade200, thickness: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isEnglish 
                            ? '$totalMonths months $remainingDays days' 
                            : '${['০','১','২','৩','৪','৫','৬','৭','৮','৯','১০'][totalMonths.clamp(0, 10)]} মাস ${['০','১','২','৩','৪','৫','৬','৭','৮','৯','১০','১১','১২','১৩','১৪','১৫','১৬','১৭','১৮','১৯','২০','২১','২২','২৩','২৪','২৫','২৬','২৭','২৮','২৯','৩০'][remainingDays.clamp(0, 30)]} দিন',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.info_outline_rounded, size: 18, color: Colors.grey.shade500),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress bar (10 months = 300 days for progress calculation)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (totalMonths * 30 + remainingDays) / 300,
                      backgroundColor: Colors.grey.shade200,
                      color: const Color(0xFF5A5A5A),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isEnglish ? 'Expected delivery: $expectedDeliveryDate' : 'সম্ভাব্য ডেলিভারি: $expectedDeliveryDate',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
              ],
            ),
          ),
          // Summary pill
          Positioned(
            bottom: -14,
            child: GestureDetector(
              onTap: onToggleSummary,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFD3E3FD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isEnglish ? 'Summary' : 'সামারি',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 16, color: const Color(0xFF1E3A8A)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _monthNameShort(int month) {
    const months = [
      'জানু', 'ফেব্রু', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
      'জুলাই', 'আগস্ট', 'সেপ্টে', 'অক্টো', 'নভে', 'ডিসে'
    ];
    return months[month - 1];
  }

  String _monthName(int month) {
    const months = [
      'জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
      'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর'
    ];
    return months[month - 1];
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [

          Icon(icon, color: color, size: 18),
          SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1030),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow2Cards(Widget left, Widget right) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: left),
            SizedBox(width: 10),
            Expanded(child: right),
          ],
        ),
      ),
    );
  }

  Widget _buildRow3Cards(Widget a, Widget b, Widget c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: a),
            SizedBox(width: 8),
            Expanded(child: b),
            SizedBox(width: 8),
            Expanded(child: c),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1030),
                height: 1.3,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                
                fontSize: 10,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallFeatureCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
    String? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                if (badge != null)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1030),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullWidthCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1030),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    subtitle,
    style: TextStyle(
                      
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.arrow_forward_rounded, color: color, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showSloganDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF7C4FC4), Color(0xFF5B2D9A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite_rounded, color: Colors.white, size: 48),
              SizedBox(height: 16),
              const Text(
                'গর্ভবতী আয়না',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              const Text(
                '"নিরাপদ হোক প্রতিটি প্রসব, যত্নে থাকুক মা ও নবজাতক"',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, height: 1.6),
              ),
              SizedBox(height: 8),
              Text(
                'NHMRIS - National Health Management & Reporting Information System',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 11, height: 1.5),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('বন্ধ করুন', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature শীঘ্রই আসছে...', style: TextStyle(fontFamily: 'Hind_Siliguri')),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          final String name = (user?.name ?? '').tr(context);
          final String initials = name.isNotEmpty ? name[0] : 'ম'.tr(context);

          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            minChildSize: 0.4,
            builder: (_, scrollCtrl) => ListView(
              controller: scrollCtrl,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primarySurface,
                    child: Text(initials, style: TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 12),
                Center(child: Text(name, style: AppTextStyles.headingMedium)),
                Center(child: Text(user?.phone ?? '', style: AppTextStyles.bodyMedium)),
                const SizedBox(height: 24),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.person_outline, color: AppColors.primary),
                  title: Text('প্রোফাইল সম্পাদনা'.tr(context)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () { Navigator.pop(context); _navigateToScreen(const ProfileEditScreen()); },
                ),
                ListTile(
                  leading: Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
                  title: const Text('গর্ভধারণ যোগ করুন'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () { Navigator.pop(context); _navigateToScreen(const PregnancySetupFlowScreen()); },
                ),
                ListTile(
                  leading: Icon(Icons.settings_outlined, color: AppColors.primary),
                  title: Text('সেটিংস'.tr(context)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () { Navigator.pop(context); _navigateToScreen(const SettingsScreen()); },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline, color: AppColors.primary),
                  title: Text('অ্যাপ সম্পর্কে'.tr(context)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () { Navigator.pop(context); _navigateToScreen(const AboutAppScreen()); },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.logout_rounded, color: AppColors.error),
                  title: Text('লগআউট', style: AppTextStyles.labelMedium.copyWith(color: AppColors.error)),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AuthBloc>().add(const AuthLogoutRequested());
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    ).then((_) {
      if (mounted) {
        setState(() { _currentIndex = 0; });
      }
    });
  }
}
// ── Tracker Menu Sheet ────────────────────────────────────────────────────────
class _TrackerMenuSheet extends StatelessWidget {
  final Function(Widget) onModuleTap;
  const _TrackerMenuSheet({required this.onModuleTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
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
            Text('সকল ট্র্যাকার সমূহ'.tr(context), style: AppTextStyles.headingMedium),
            SizedBox(height: 16),
            _buildMenuItem(context, Icons.pregnant_woman_rounded, 'কিক কাউন্টার'.tr(context), const KickCounterScreen(), const Color(0xFF7C3AED)),
            _buildMenuItem(context, Icons.calendar_month_rounded, 'সাপ্তাহিক বেবি আপডেট'.tr(context), const WeeklyUpdateScreen(), const Color(0xFF00897B)),
            _buildMenuItem(context, Icons.vaccines_rounded, 'শিশুর টিকা সূচি'.tr(context), const RemindersScreen(), const Color(0xFFEC407A)),
            _buildMenuItem(context, Icons.checklist_rounded, 'ডেলিভারির প্রস্তুতি'.tr(context), const DeliveryPrepScreen(), const Color(0xFFFF8F00)),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Widget screen, Color color) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Center(child: Icon(icon, color: color, size: 20)),
      ),
      title: Text(title, style: AppTextStyles.labelMedium),
      trailing: Icon(Icons.arrow_forward_ios, size: 14),
      onTap: () {
        Navigator.pop(context);
        onModuleTap(screen);
      },
    );
  }
}

// ── More Menu Sheet ───────────────────────────────────────────────────────────
class _MoreMenuSheet extends StatelessWidget {
  final Function(Widget) onModuleTap;
  const _MoreMenuSheet({required this.onModuleTap});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (_, scrollCtrl) => Column(
        children: [
          SizedBox(height: 12),
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
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('আরও ফিচার সমূহ'.tr(context), style: AppTextStyles.headingMedium),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView(
              controller: scrollCtrl,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              children: [
                _buildSectionHeader('শিশু ও মায়ের তথ্য'.tr(context), Icons.child_care_rounded, AppColors.primary),
                _buildMenuItem(context, Icons.tips_and_updates_rounded, 'প্রতিদিনের টিপস'.tr(context), const DailyTipsScreen(), const Color(0xFF7C3AED)),
                _buildMenuItem(context, Icons.monitor_heart_rounded, 'গর্ভের শিশুর অবস্থা'.tr(context), const KickCounterScreen(), const Color(0xFF2196F3)),
                _buildMenuItem(context, Icons.woman_rounded, 'মায়ের স্বাস্থ্য'.tr(context), const ANCScreen(), const Color(0xFFEC407A)),
                _buildMenuItem(context, Icons.man_rounded, 'বাবার করণীয়'.tr(context), const DeliveryPrepScreen(), const Color(0xFF00897B)),

                _buildSectionHeader('গর্ভবতী সেবা'.tr(context), Icons.pregnant_woman_rounded, const Color(0xFF7C3AED)),
                _buildMenuItem(context, Icons.app_registration_rounded, 'গর্ভবতী নিবন্ধন'.tr(context), const PregnancyRegistrationScreen(), const Color(0xFF43A047)),
                _buildMenuItem(context, Icons.restaurant_menu_rounded, 'খাদ্য তালিকা ও পুষ্টি'.tr(context), const NutritionScreen(), const Color(0xFFFF8F00)),
                _buildMenuItem(context, Icons.medical_information_rounded, 'গর্ভকালীন স্বাস্থ্য সমস্যা ও সমাধান'.tr(context), const DoctorConsultationScreen(), const Color(0xFF5E35B1)),

                _buildSectionHeader('ANC ও PNC সেবা'.tr(context), Icons.baby_changing_station_rounded, const Color(0xFF00897B)),
                _buildMenuItem(context, Icons.pregnant_woman_rounded, 'প্রসবপূর্ব (ANC) সেবা আপডেট'.tr(context), const ANCScreen(), const Color(0xFF7C3AED)),
                _buildMenuItem(context, Icons.child_friendly_rounded, 'প্রসব পরবর্তী (PNC) সেবা আপডেট'.tr(context), const PncScreen(), const Color(0xFFEC407A)),
                _buildMenuItem(context, Icons.medical_services_rounded, 'গর্ভকালীন সেবা ও করণীয়'.tr(context), const DoctorConsultationScreen(), const Color(0xFF00897B)),

                _buildSectionHeader('জরুরি সেবা'.tr(context), Icons.emergency_rounded, const Color(0xFFE53935)),
                _buildMenuItem(context, Icons.bloodtype_rounded, 'রক্তদাতা'.tr(context), const BloodDonorScreen(), const Color(0xFFE53935)),
                _buildMenuItem(context, Icons.phone_in_talk_rounded, 'জরুরি যোগাযোগ নম্বর'.tr(context), const HelplineScreen(), const Color(0xFF1E88E5)),
                _buildMenuItem(context, Icons.local_hospital_rounded, 'স্বাস্থ্যকেন্দ্র/হাসপাতাল'.tr(context), const HospitalDirectoryScreen(), const Color(0xFF00897B)),

                _buildSectionHeader('নবজাতকের সেবা'.tr(context), Icons.child_care_rounded, const Color(0xFF43A047)),
                _buildMenuItem(context, Icons.baby_changing_station_rounded, 'নবজাতকের যত্ন ও পুষ্টি'.tr(context), const NewbornCareScreen(), const Color(0xFF43A047)),
                _buildMenuItem(context, Icons.vaccines_rounded, 'টিকা'.tr(context), const RemindersScreen(), const Color(0xFFEC407A)),
                _buildMenuItem(context, Icons.restaurant_rounded, 'শিশুর খাদ্য তালিকা'.tr(context), const BabyFoodScreen(), const Color(0xFFFF8F00)),

                _buildSectionHeader('স্বাস্থ্য টুলস'.tr(context), Icons.build_circle_rounded, const Color(0xFF5E35B1)),
                _buildMenuItem(context, Icons.touch_app_rounded, 'গর্ভের শিশুর নড়াচড়া'.tr(context), const KickCounterScreen(), const Color(0xFF7C3AED)),

                _buildSectionHeader('অ্যাপ সম্পর্কে'.tr(context), Icons.info_outline, Colors.grey.shade600),
                _buildMenuItem(context, Icons.info_outline, 'অ্যাপ সম্পর্কে জানুন'.tr(context), const AboutAppScreen(), Colors.grey.shade600),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 4),
      child: Row(
        children: [
          Container(width: 3, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
          SizedBox(width: 8),
          Icon(icon, color: color, size: 15),
          SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Widget screen, Color color) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Center(child: Icon(icon, color: color, size: 18)),
      ),
      title: Text(title, style: AppTextStyles.labelMedium),
      trailing: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
      onTap: () {
        Navigator.pop(context);
        onModuleTap(screen);
      },
    );
  }
}

