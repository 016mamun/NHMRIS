import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MockDialerWidget extends StatefulWidget {
  final String name;
  final String phone;

  const MockDialerWidget({
    super.key,
    required this.name,
    required this.phone,
  });

  @override
  State<MockDialerWidget> createState() => _MockDialerWidgetState();
}

class _MockDialerWidgetState extends State<MockDialerWidget> with SingleTickerProviderStateMixin {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isConnected = false;
  int _seconds = 0;
  Timer? _timer;
  Timer? _connectionTimer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Mock connection delay: after 1.8 seconds, change to "connected" and start calling timer
    _connectionTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() {
          _isConnected = true;
        });
        _pulseController.stop();
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  String _formatDuration() {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    _connectionTimer?.cancel();
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A), // Premium sleek dark mode dialer background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Slide indicator
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade700, borderRadius: BorderRadius.circular(2))),
            SizedBox(height: 36),

            // Pulsing Call Avatar or Icon
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final scale = 1.0 + (_pulseController.value * 0.12);
                return Transform.scale(
                  scale: _isConnected ? 1.0 : scale,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _isConnected ? AppColors.success.withValues(alpha: 0.15) : AppColors.error.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isConnected ? AppColors.success : AppColors.error,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _isConnected ? Icons.phone_in_talk_rounded : Icons.phone_forwarded_rounded,
                        color: _isConnected ? AppColors.success : AppColors.error,
                        size: 40,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),

            // Caller Details
            Text(
              widget.name,
              style: TextStyle(
                
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              widget.phone,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 16),

            // Calling status / Ticking Timer
            Text(
              _isConnected ? 'কল চলছে • ${_formatDuration()}' : 'কল করা হচ্ছে...',
              style: TextStyle(
                
                fontSize: 14.5,
                color: _isConnected ? AppColors.success : Colors.grey.shade400,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 48),

            // Dialer Buttons Panel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Mute Mic Button
                Column(
                  children: [
                    IconButton(
                      iconSize: 28,
                      style: IconButton.styleFrom(
                        backgroundColor: _isMuted ? Colors.white : Colors.white.withValues(alpha: 0.08),
                        foregroundColor: _isMuted ? const Color(0xFF0F172A) : Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                      icon: Icon(_isMuted ? Icons.mic_off_rounded : Icons.mic_rounded),
                      onPressed: () => setState(() => _isMuted = !_isMuted),
                    ),
                    SizedBox(height: 8),
                    const Text(
                      'মিউট',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    )
                  ],
                ),

                // Decline Call Button (Center red button)
                Column(
                  children: [
                    IconButton(
                      iconSize: 34,
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                      icon: Icon(Icons.call_end_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(height: 8),
                    const Text(
                      'কাটুন',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    )
                  ],
                ),

                // Speaker Toggle
                Column(
                  children: [
                    IconButton(
                      iconSize: 28,
                      style: IconButton.styleFrom(
                        backgroundColor: _isSpeakerOn ? Colors.white : Colors.white.withValues(alpha: 0.08),
                        foregroundColor: _isSpeakerOn ? const Color(0xFF0F172A) : Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                      icon: Icon(_isSpeakerOn ? Icons.volume_up_rounded : Icons.volume_down_rounded),
                      onPressed: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
                    ),
                    SizedBox(height: 8),
                    const Text(
                      'লাউড স্পিকার',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
