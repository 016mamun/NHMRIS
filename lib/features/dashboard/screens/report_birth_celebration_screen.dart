import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'baby_profile_edit_screen.dart';

class ReportBirthCelebrationScreen extends StatefulWidget {
  const ReportBirthCelebrationScreen({super.key});

  @override
  State<ReportBirthCelebrationScreen> createState() => _ReportBirthCelebrationScreenState();
}

class _ReportBirthCelebrationScreenState extends State<ReportBirthCelebrationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // Navigate to next screen after 1.5 seconds (1 second wait + some animation time)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BabyProfileEditScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FA), // Light blue tint matching the image background
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Central party popper icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: const Icon(
                  Icons.celebration_rounded,
                  size: 100,
                  color: Color(0xFFE86A45),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'অভিনন্দন!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE86A45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
