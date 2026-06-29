import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: _buildBottomNavBar(context),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
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
                        // ── Tagline Banner ──────────────────────────────
                        _buildTaglineBanner(context),

                        // ── Pregnancy Progress Card ──────────────────────
                        _buildPregnancyProgressCard(context),

                        // ── Section: শিশু ও মায়ের তথ্য ─────────────────
                        _buildSectionTitle('শিশু ও মায়ের তথ্য', Icons.child_care_rounded, AppColors.primary),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'প্রতিদিনের\nটিপস',
                            icon: Icons.tips_and_updates_rounded,
                            color: const Color(0xFF7C3AED),
                            bgColor: const Color(0xFFEDE7F6),
                            subtitle: 'দৈনিক স্বাস্থ্য টিপস ও পরামর্শ',
                            onTap: () => _navigateToScreen(const WeeklyUpdateScreen()),
                          ),
                          _buildFeatureCard(
                            title: 'গর্ভের শিশুর\nঅবস্থা',
                            icon: Icons.monitor_heart_rounded,
                            color: const Color(0xFF2196F3),
                            bgColor: const Color(0xFFE3F2FD),
                            subtitle: 'শিশু 3D ছবি, দৈর্ঘ্য, ওজন, ধাপ',
                            onTap: () => _navigateToScreen(const WeeklyUpdateScreen()),
                          ),
                        ),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'মায়ের\nস্বাস্থ্য',
                            icon: Icons.woman_rounded,
                            color: const Color(0xFFEC407A),
                            bgColor: const Color(0xFFFCE4EC),
                            subtitle: 'মায়ের বিস্তারিত অবস্থা ও সমস্যা',
                            onTap: () => _navigateToScreen(const ANCScreen()),
                          ),
                          _buildFeatureCard(
                            title: 'বাবার\nকরণীয়',
                            icon: Icons.man_rounded,
                            color: const Color(0xFF00897B),
                            bgColor: const Color(0xFFE0F2F1),
                            subtitle: 'বাবার দায়িত্ব ও কর্তব্য',
                            onTap: () => _navigateToScreen(const DeliveryPrepScreen()),
                          ),
                        ),

                        // ── Section: গর্ভবতী সেবা ────────────────────────
                        _buildSectionTitle('গর্ভবতী সেবা', Icons.pregnant_woman_rounded, const Color(0xFF7C3AED)),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'গর্ভবতী\nনিবন্ধন',
                            icon: Icons.app_registration_rounded,
                            color: const Color(0xFF43A047),
                            bgColor: const Color(0xFFE8F5E9),
                            subtitle: 'সেবা কার্ড ও নিবন্ধন',
                            onTap: () => _navigateToScreen(const PregnancyRegistrationScreen()),
                          ),
                          _buildFeatureCard(
                            title: 'খাদ্য তালিকা\nও পুষ্টি',
                            icon: Icons.restaurant_menu_rounded,
                            color: const Color(0xFFFF8F00),
                            bgColor: const Color(0xFFFFF3E0),
                            subtitle: 'পুষ্টিকর খাদ্য পরিকল্পনা',
                            onTap: () => _navigateToScreen(const NutritionScreen()),
                          ),
                        ),
                        _buildFullWidthCard(
                          title: 'গর্ভকালীন স্বাস্থ্য\nসমস্যা ও সমাধান',
                          icon: Icons.medical_information_rounded,
                          color: const Color(0xFF5E35B1),
                          bgColor: const Color(0xFFEDE7F6),
                          subtitle: 'সকল গর্ভকালীন জটিলতা ও পরামর্শ',
                          onTap: () => _navigateToScreen(const DoctorConsultationScreen()),
                        ),

                        // ── Section: স্বাস্থ্য সমস্যা ───────────────────
                        _buildSectionTitle('স্বাস্থ্য ও জটিলতা', Icons.health_and_safety_rounded, const Color(0xFFE53935)),
                        _buildRow2Cards(
                          _buildFeatureCard(
                            title: 'সাধারণ সমস্যা\nও সমাধান',
                            icon: Icons.warning_amber_rounded,
                            color: const Color(0xFFE53935),
                            bgColor: const Color(0xFFFFEBEE),
                            subtitle: 'জরুরি স্বাস্থ্য তথ্য',
                            onTap: () => _showComingSoon(context, 'মার্কেট সমস্যা ও সমাধান'),
                          ),
                          _buildFeatureCard(
                            title: 'গর্ভকালীন\nজটিলতা ও করণীয়',
                            icon: Icons.emergency_rounded,
                            color: const Color(0xFFD81B60),
                            bgColor: const Color(0xFFFCE4EC),
                            subtitle: 'জরুরি পদক্ষেপ',
                            onTap: () => _showComingSoon(context, 'গর্ভকালীন জটিলতা'),
                          ),
                        ),
                        _buildFullWidthCard(
                          title: 'ওষুধ, চিকিৎসা\nও পরীক্ষা',
                          icon: Icons.science_rounded,
                          color: const Color(0xFF0277BD),
                          bgColor: const Color(0xFFE1F5FE),
                          subtitle: 'ল্যাব রিপোর্ট ও পরীক্ষার ফলাফল বিশ্লেষণ',
                          onTap: () => _showComingSoon(context, 'উপকরণ টেস্টিং'),
                        ),

                        // ── Section: ANC ও PNC সেবা ────────────────────
                        _buildSectionTitle('ANC ও PNC সেবা', Icons.baby_changing_station_rounded, const Color(0xFF00897B)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'প্রসবপূর্ব (ANC)\nসেবা আপডেট',
                            icon: Icons.pregnant_woman_rounded,
                            color: const Color(0xFF7C3AED),
                            bgColor: const Color(0xFFEDE7F6),
                            onTap: () => _navigateToScreen(const ANCScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'গর্ভকালীন সেবা\nও করণীয়',
                            icon: Icons.medical_services_rounded,
                            color: const Color(0xFF00897B),
                            bgColor: const Color(0xFFE0F2F1),
                            onTap: () => _navigateToScreen(const DoctorConsultationScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'প্রসব পরবর্তী (PNC)\nসেবা আপডেট',
                            icon: Icons.child_friendly_rounded,
                            color: const Color(0xFFEC407A),
                            bgColor: const Color(0xFFFCE4EC),
                            onTap: () => _showComingSoon(context, 'PNC সেবা'),
                          ),
                        ),

                        // ── Section: জরুরি সেবা ────────────────────────
                        _buildSectionTitle('জরুরি সেবা', Icons.emergency_rounded, const Color(0xFFE53935)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'রক্তদাতা',
                            icon: Icons.bloodtype_rounded,
                            color: const Color(0xFFE53935),
                            bgColor: const Color(0xFFFFEBEE),
                            onTap: () => _navigateToScreen(const BloodDonorScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'জরুরি যোগাযোগ\nনম্বর',
                            icon: Icons.phone_in_talk_rounded,
                            color: const Color(0xFF1E88E5),
                            bgColor: const Color(0xFFE3F2FD),
                            onTap: () => _navigateToScreen(const HelplineScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'স্বাস্থ্যকেন্দ্র/\nহাসপাতাল',
                            icon: Icons.local_hospital_rounded,
                            color: const Color(0xFF00897B),
                            bgColor: const Color(0xFFE0F2F1),
                            badge: 'GPS',
                            onTap: () => _navigateToScreen(const HospitalDirectoryScreen()),
                          ),
                        ),

                        // ── Section: নবজাতকের সেবা ────────────────────
                        _buildSectionTitle('নবজাতকের সেবা', Icons.child_care_rounded, const Color(0xFF43A047)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'নবজাতকের\nযত্ন ও পুষ্টি',
                            icon: Icons.baby_changing_station_rounded,
                            color: const Color(0xFF43A047),
                            bgColor: const Color(0xFFE8F5E9),
                            onTap: () => _showComingSoon(context, 'নবজাতকের যত্ন'),
                          ),
                          _buildSmallFeatureCard(
                            title: 'টিকা',
                            icon: Icons.vaccines_rounded,
                            color: const Color(0xFFEC407A),
                            bgColor: const Color(0xFFFCE4EC),
                            onTap: () => _navigateToScreen(const RemindersScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'শিশুর খাদ্য\nতালিকা',
                            icon: Icons.restaurant_rounded,
                            color: const Color(0xFFFF8F00),
                            bgColor: const Color(0xFFFFF3E0),
                            onTap: () => _showComingSoon(context, 'শিশুর খাদ্য তালিকা'),
                          ),
                        ),

                        // ── Section: টুলস ─────────────────────────────
                        _buildSectionTitle('স্বাস্থ্য টুলস', Icons.build_circle_rounded, const Color(0xFF5E35B1)),
                        _buildRow3Cards(
                          _buildSmallFeatureCard(
                            title: 'গর্ভের শিশুর\nনড়াচড়া',
                            icon: Icons.touch_app_rounded,
                            color: const Color(0xFF7C3AED),
                            bgColor: const Color(0xFFEDE7F6),
                            onTap: () => _navigateToScreen(const KickCounterScreen()),
                          ),
                          _buildSmallFeatureCard(
                            title: 'Kegel\nব্যায়াম',
                            icon: Icons.fitness_center_rounded,
                            color: const Color(0xFFD81B60),
                            bgColor: const Color(0xFFFCE4EC),
                            onTap: () => _showComingSoon(context, 'Kegel ব্যায়াম'),
                          ),
                          _buildSmallFeatureCard(
                            title: 'BMI\nCalculator',
                            icon: Icons.calculate_rounded,
                            color: const Color(0xFF1E88E5),
                            bgColor: const Color(0xFFE3F2FD),
                            onTap: () => _showComingSoon(context, 'BMI Calculator'),
                          ),
                        ),
                        _buildFullWidthCard(
                          title: 'GMP চার্ট',
                          icon: Icons.bar_chart_rounded,
                          color: const Color(0xFF00897B),
                          bgColor: const Color(0xFFE0F2F1),
                          subtitle: 'শিশুর বৃদ্ধির মনিটরিং চার্ট (Growth Monitoring Programme)',
                          onTap: () => _showComingSoon(context, 'GMP চার্ট'),
                        ),

                        const SizedBox(height: 16),
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
              _buildNavItem(0, Icons.home_rounded, 'হোম'),
              _buildNavItem(1, Icons.medical_services_rounded, 'পরামর্শ'),
              _buildNavItem(2, Icons.track_changes_rounded, 'ট্র্যাকার'),
              _buildNavItem(3, Icons.local_hospital_rounded, 'হাসপাতাল'),
              _buildNavItem(4, Icons.menu_rounded, 'আরও'),
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
        const SizedBox(width: 8),
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
            String initials = 'ম';
            String name = 'প্রোফাইল';
            if (state is AuthAuthenticated) {
              initials = state.user.initials;
              name = state.user.name;
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'প্রোফাইল দেখুন',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primaryDark,
                    child: Text(
                      initials,
                      style: const TextStyle(
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
              child: const Icon(Icons.format_quote_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '"নিরাপদ হোক প্রতিটি প্রসব, যত্নে থাকুক মা ও নবজাতক"',
                    style: TextStyle(
                      fontFamily: 'Hind_Siliguri',
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'একনজরে দেখুন →',
                        style: TextStyle(
                          fontFamily: 'Hind_Siliguri',
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
        int weeks = 26;
        if (state is AuthAuthenticated) {
          weeks = state.user.pregnancyWeeks;
        }

        final deliveryDate = DateTime.now().add(Duration(days: (40 - weeks) * 7));
        final deliveryStr =
            '${deliveryDate.day.toString().padLeft(2, '0')} ${_monthName(deliveryDate.month)} ${deliveryDate.year}';
        final progress = weeks / 40.0;

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.pregnant_woman_rounded, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weeks}তম সপ্তাহ চলছে',
                          style: const TextStyle(
                            fontFamily: 'Hind_Siliguri',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1030),
                          ),
                        ),
                        Text(
                          'সম্ভাব্য ডেলিভারি: $deliveryStr',
                          style: TextStyle(
                            fontFamily: 'Hind_Siliguri',
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${(40 - weeks)} সপ্তাহ বাকি',
                      style: const TextStyle(
                        fontFamily: 'Hind_Siliguri',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'গর্ভাবস্থার অগ্রগতি',
                        style: TextStyle(
                          fontFamily: 'Hind_Siliguri',
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontFamily: 'Hind_Siliguri',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: AppColors.primarySurface,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '১ম ত্রৈমাসিক',
                        style: TextStyle(fontSize: 9, color: Colors.grey.shade500, fontFamily: 'Hind_Siliguri'),
                      ),
                      Text(
                        '২য় ত্রৈমাসিক',
                        style: TextStyle(fontSize: 9, color: Colors.grey.shade500, fontFamily: 'Hind_Siliguri'),
                      ),
                      Text(
                        '৩য় ত্রৈমাসিক',
                        style: TextStyle(fontSize: 9, color: Colors.grey.shade500, fontFamily: 'Hind_Siliguri'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
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
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Hind_Siliguri',
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
      child: Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 10),
          Expanded(child: right),
        ],
      ),
    );
  }

  Widget _buildRow3Cards(Widget a, Widget b, Widget c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Row(
        children: [
          Expanded(child: a),
          const SizedBox(width: 8),
          Expanded(child: b),
          const SizedBox(width: 8),
          Expanded(child: c),
        ],
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
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Hind_Siliguri',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1030),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Hind_Siliguri',
                fontSize: 10,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'দেখুন',
                  style: TextStyle(
                    fontFamily: 'Hind_Siliguri',
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, size: 12, color: color),
              ],
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
          mainAxisSize: MainAxisSize.min,
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Hind_Siliguri',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1030),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Icon(Icons.arrow_forward_rounded, size: 12, color: color),
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
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Hind_Siliguri',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1030),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Hind_Siliguri',
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
              const Icon(Icons.favorite_rounded, color: Colors.white, size: 48),
              const SizedBox(height: 16),
              const Text(
                'গর্ভবতী আয়না',
                style: TextStyle(
                  fontFamily: 'Hind_Siliguri',
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '"নিরাপদ হোক প্রতিটি প্রসব, যত্নে থাকুক মা ও নবজাতক"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Hind_Siliguri',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'NHMRIS - National Health Management & Reporting Information System',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Hind_Siliguri',
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
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
        content: Text(
          '$feature শীঘ্রই আসছে...',
          style: const TextStyle(fontFamily: 'Hind_Siliguri'),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  Text(user?.name ?? '', style: AppTextStyles.headingMedium),
                  Text(user?.phone ?? '', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 24),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.person_outline, color: AppColors.primary),
                    title: const Text('প্রোফাইল সম্পাদনা', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToScreen(const ProfileEditScreen());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined, color: AppColors.primary),
                    title: const Text('সেটিংস', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToScreen(const SettingsScreen());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: AppColors.primary),
                    title: const Text('অ্যাপ সম্পর্কে', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToScreen(const AboutAppScreen());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded, color: AppColors.error),
                    title: Text(
                      'লগআউট',
                      style: AppTextStyles.labelMedium.copyWith(color: AppColors.error),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<AuthBloc>().add(const AuthLogoutRequested());
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = 0;
        });
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
            const SizedBox(height: 20),
            Text('সকল ট্র্যাকার সমূহ', style: AppTextStyles.headingMedium),
            const SizedBox(height: 16),
            _buildMenuItem(context, Icons.pregnant_woman_rounded, 'কিক কাউন্টার', const KickCounterScreen(), const Color(0xFF7C3AED)),
            _buildMenuItem(context, Icons.calendar_month_rounded, 'সাপ্তাহিক বেবি আপডেট', const WeeklyUpdateScreen(), const Color(0xFF00897B)),
            _buildMenuItem(context, Icons.vaccines_rounded, 'শিশুর টিকা সূচি', const RemindersScreen(), const Color(0xFFEC407A)),
            _buildMenuItem(context, Icons.checklist_rounded, 'ডেলিভারির প্রস্তুতি', const DeliveryPrepScreen(), const Color(0xFFFF8F00)),
            const SizedBox(height: 12),
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
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
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
          const SizedBox(height: 12),
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
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('আরও ফিচার সমূহ', style: AppTextStyles.headingMedium),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              controller: scrollCtrl,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              children: [

                _buildSectionHeader('শিশু ও মায়ের তথ্য', Icons.child_care_rounded, AppColors.primary),
                _buildMenuItem(context, Icons.tips_and_updates_rounded, 'প্রতিদিনের টিপস', const WeeklyUpdateScreen(), const Color(0xFF7C3AED)),
                _buildMenuItem(context, Icons.monitor_heart_rounded, 'গর্ভের শিশুর অবস্থা', const KickCounterScreen(), const Color(0xFF2196F3)),
                _buildMenuItem(context, Icons.woman_rounded, 'মায়ের স্বাস্থ্য', const ANCScreen(), const Color(0xFFEC407A)),
                _buildMenuItem(context, Icons.man_rounded, 'বাবার করণীয়', const DeliveryPrepScreen(), const Color(0xFF00897B)),

                _buildSectionHeader('গর্ভবতী সেবা', Icons.pregnant_woman_rounded, const Color(0xFF7C3AED)),
                _buildMenuItem(context, Icons.app_registration_rounded, 'গর্ভবতী নিবন্ধন', const PregnancyRegistrationScreen(), const Color(0xFF43A047)),
                _buildMenuItem(context, Icons.restaurant_menu_rounded, 'খাদ্য তালিকা ও পুষ্টি', const NutritionScreen(), const Color(0xFFFF8F00)),
                _buildMenuItem(context, Icons.medical_information_rounded, 'গর্ভকালীন স্বাস্থ্য সমস্যা ও সমাধান', const DoctorConsultationScreen(), const Color(0xFF5E35B1)),

                _buildSectionHeader('ANC ও PNC সেবা', Icons.baby_changing_station_rounded, const Color(0xFF00897B)),
                _buildMenuItem(context, Icons.pregnant_woman_rounded, 'প্রসবপূর্ব (ANC) সেবা আপডেট', const ANCScreen(), const Color(0xFF7C3AED)),
                _buildMenuItem(context, Icons.medical_services_rounded, 'গর্ভকালীন সেবা ও করণীয়', const DoctorConsultationScreen(), const Color(0xFF00897B)),

                _buildSectionHeader('জরুরি সেবা', Icons.emergency_rounded, const Color(0xFFE53935)),
                _buildMenuItem(context, Icons.bloodtype_rounded, 'রক্তদাতা', const BloodDonorScreen(), const Color(0xFFE53935)),
                _buildMenuItem(context, Icons.phone_in_talk_rounded, 'জরুরি যোগাযোগ নম্বর', const HelplineScreen(), const Color(0xFF1E88E5)),
                _buildMenuItem(context, Icons.local_hospital_rounded, 'স্বাস্থ্যকেন্দ্র / হাসপাতাল', const HospitalDirectoryScreen(), const Color(0xFF00897B)),

                _buildSectionHeader('নবজাতকের সেবা', Icons.child_care_rounded, const Color(0xFF43A047)),
                _buildMenuItem(context, Icons.vaccines_rounded, 'টিকা', const RemindersScreen(), const Color(0xFFEC407A)),

                _buildSectionHeader('স্বাস্থ্য টুলস', Icons.build_circle_rounded, const Color(0xFF5E35B1)),
                _buildMenuItem(context, Icons.touch_app_rounded, 'গর্ভের শিশুর নড়াচড়া (কিক)', const KickCounterScreen(), const Color(0xFF7C3AED)),

                _buildSectionHeader('অ্যাপ', Icons.info_outline, Colors.grey.shade600),
                _buildMenuItem(context, Icons.info_outline, 'অ্যাপ সম্পর্কে জানুন', const AboutAppScreen(), Colors.grey.shade600),
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
          const SizedBox(width: 8),
          Icon(icon, color: color, size: 15),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Hind_Siliguri',
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
      trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
      onTap: () {
        Navigator.pop(context);
        onModuleTap(screen);
      },
    );
  }
}
