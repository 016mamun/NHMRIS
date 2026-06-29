import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class KegelExerciseScreen extends StatefulWidget {
  const KegelExerciseScreen({super.key});

  @override
  State<KegelExerciseScreen> createState() => _KegelExerciseScreenState();
}

class _KegelExerciseScreenState extends State<KegelExerciseScreen>
    with SingleTickerProviderStateMixin {
  bool _isRunning = false;
  int _secondsLeft = 5;
  int _reps = 0;
  int _targetReps = 10;

  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _startExercise() {
    setState(() {
      _isRunning = true;
      _secondsLeft = 5;
    });
    _runTimer();
  }

  void _runTimer() async {
    for (int i = 5; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() => _secondsLeft = i);
    }
    if (!mounted) return;
    setState(() {
      _reps += 1;
      _isRunning = false;
    });
  }

  void _reset() {
    setState(() {
      _isRunning = false;
      _secondsLeft = 5;
      _reps = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _buildBenefitsCard(),
                const SizedBox(height: 20),
                _buildExerciseTracker(),
                const SizedBox(height: 20),
                _buildHowToCard(),
                const SizedBox(height: 16),
                _buildCautionCard(),
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
                    Text('Kegel ব্যায়াম', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('শ্রোণিদেশের পেশী মজবুত করুন', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildBenefitsCard() {
    final benefits = ['প্রসব সহজ হয়', 'মূত্রনালীর নিয়ন্ত্রণ ভালো হয়', 'প্রসব পরবর্তী পুনরুদ্ধার দ্রুত হয়', 'শ্রোণিদেশের ব্যথা কমায়'];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFFFF3F8)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD81B60).withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('✨', style: TextStyle(fontSize: 22)),
              SizedBox(width: 8),
              Text('কেন করবেন?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFFAD1457))),
            ],
          ),
          const SizedBox(height: 10),
          ...benefits.map((b) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFFD81B60), size: 16),
                const SizedBox(width: 8),
                Text(b, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildExerciseTracker() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD81B60).withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: const Color(0xFFD81B60).withValues(alpha: 0.07), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Text(
            'ব্যায়াম ট্র্যাকার',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => Transform.scale(
              scale: _isRunning ? _pulse.value : 1.0,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isRunning ? const Color(0xFFD81B60) : const Color(0xFFFCE4EC),
                  boxShadow: _isRunning ? [BoxShadow(color: const Color(0xFFD81B60).withValues(alpha: 0.35), blurRadius: 20, spreadRadius: 4)] : null,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isRunning ? '$_secondsLeft' : '💪',
                        style: TextStyle(
                          
                          fontSize: _isRunning ? 48 : 36,
                          fontWeight: FontWeight.w900,
                          color: _isRunning ? Colors.white : const Color(0xFFD81B60),
                        ),
                      ),
                      if (_isRunning)
                        const Text('সেকেন্ড', style: TextStyle(fontSize: 13, color: Colors.white70)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('$_reps / $_targetReps', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFD81B60))),
          const Text('সম্পন্ন', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _targetReps > 0 ? _reps / _targetReps : 0,
              backgroundColor: const Color(0xFFFCE4EC),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFD81B60)),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: (_isRunning || _reps >= _targetReps) ? null : _startExercise,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('শুরু করুন', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD81B60),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFD81B60),
                  side: const BorderSide(color: Color(0xFFD81B60)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
                child: const Icon(Icons.refresh_rounded),
              ),
            ],
          ),
          if (_reps >= _targetReps)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text('🎉 আজকের লক্ষ্য সম্পন্ন!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF43A047))),
            ),
        ],
      ),
    );
  }

  Widget _buildHowToCard() {
    final steps = [
      'প্রথমে প্রস্রাব করার পেশীকে চিহ্নিত করুন',
      'পেশী সংকুচিত করুন এবং ৫ সেকেন্ড ধরে রাখুন',
      'ধীরে ধীরে পেশী শিথিল করুন',
      '৫ সেকেন্ড বিশ্রাম নিন',
      'এটি ১ বার। দিনে ১০ বার করুন',
      'বসে, শুয়ে বা দাঁড়িয়ে যেকোনো অবস্থায় করা যায়',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD81B60).withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📋 কীভাবে করবেন?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFFAD1457))),
          const SizedBox(height: 10),
          ...steps.asMap().entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(color: const Color(0xFFD81B60), shape: BoxShape.circle),
                  child: Center(child: Text('${e.key + 1}', style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700))),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(e.value, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCautionCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF8F00).withValues(alpha: 0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFFFF8F00), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'যদি ব্যায়াম করতে ব্যথা লাগে তাহলে থামুন এবং ডাক্তারের পরামর্শ নিন। প্রস্রাব করার সময় এই ব্যায়াম করবেন না।',
              style: TextStyle(fontSize: 12, color: Color(0xFF7B4F00), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
