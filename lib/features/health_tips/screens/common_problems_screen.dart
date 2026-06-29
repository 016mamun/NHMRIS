import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CommonProblemsScreen extends StatelessWidget {
  const CommonProblemsScreen({super.key});

  static const List<Map<String, dynamic>> _problems = [
    {
      'emoji': '🤢',
      'title': 'বমি বমি ভাব ও মর্নিং সিকনেস',
      'cause': 'গর্ভের প্রথম দিকে হরমোনের পরিবর্তনে এটি হয়।',
      'solution': 'সকালে শুকনো বিস্কুট বা চা খান। অল্প অল্প করে বারবার খাবার খান। ভারী বা তেলজাতীয় খাবার এড়িয়ে চলুন।',
      'warn': false,
      'color': Color(0xFFEC407A),
      'bg': Color(0xFFFCE4EC),
    },
    {
      'emoji': '🦶',
      'title': 'পা ফোলা ও ব্যথা',
      'cause': 'রক্ত সঞ্চালন বাড়ার কারণে পায়ে পানি জমে।',
      'solution': 'পা উঁচু করে বিশ্রাম নিন। লবণ কম খান। হালকা হাঁটাহাঁটি করুন। আঁটসাঁট জুতো পরবেন না।',
      'warn': false,
      'color': Color(0xFF1E88E5),
      'bg': Color(0xFFE3F2FD),
    },
    {
      'emoji': '😣',
      'title': 'কোমর ও পিঠের ব্যথা',
      'cause': 'পেটের বাড়তি ওজনের কারণে মেরুদণ্ডে চাপ পড়ে।',
      'solution': 'সোজা হয়ে বসুন। শক্ত বিছানায় ঘুমান। গরম সেঁক দিন। দীর্ঘক্ষণ দাঁড়িয়ে থাকবেন না।',
      'warn': false,
      'color': Color(0xFF7C3AED),
      'bg': Color(0xFFEDE7F6),
    },
    {
      'emoji': '😤',
      'title': 'শ্বাসকষ্ট ও ক্লান্তি',
      'cause': 'বর্ধিত জরায়ু ডায়াফ্রামে চাপ দেওয়ায় শ্বাসকষ্ট হয়।',
      'solution': 'সোজা হয়ে বসুন। অতিরিক্ত পরিশ্রম এড়িয়ে চলুন। বালিশ উঁচু করে ঘুমান। যদি হঠাৎ তীব্র শ্বাসকষ্ট হয় — তাৎক্ষণিক ডাক্তার দেখান।',
      'warn': true,
      'color': Color(0xFFE53935),
      'bg': Color(0xFFFFEBEE),
    },
    {
      'emoji': '🔴',
      'title': 'বুকজ্বালা ও অ্যাসিডিটি',
      'cause': 'হরমোন পরিবর্তনে পাকস্থলীর দরজা শিথিল হয়।',
      'solution': 'অল্প পরিমাণে বারবার খান। খাওয়ার পর শুয়ে পড়বেন না। মশলাদার খাবার এড়িয়ে চলুন।',
      'warn': false,
      'color': Color(0xFFFF8F00),
      'bg': Color(0xFFFFF3E0),
    },
    {
      'emoji': '⚠️',
      'title': 'এগুলো হলে অবশ্যই ডাক্তার দেখান',
      'cause': '',
      'solution': '• প্রচণ্ড মাথাব্যথা\n• চোখে ঝাপসা দেখা\n• পেটে তীব্র ব্যথা\n• যোনিপথে রক্তপাত\n• গর্ভের নড়াচড়া কমে যাওয়া',
      'warn': true,
      'color': Color(0xFFE53935),
      'bg': Color(0xFFFFEBEE),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: _problems.length,
              itemBuilder: (_, i) => _buildCard(_problems[i]),
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
                    color: Colors.white.withValues(alpha: 0.2),
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
                    Text('সাধারণ সমস্যা ও সমাধান', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('গর্ভাবস্থায় সাধারণ সমস্যা ও করণীয়', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> p) {
    final color = p['color'] as Color;
    final isWarn = p['warn'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: p['bg'] as Color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(p['emoji'] as String, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    p['title'] as String,
                    style: TextStyle(
                      
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
                if (isWarn)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'সতর্কতা',
                      style: TextStyle(
                        
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
              ],
            ),
            if ((p['cause'] as String).isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildInfoRow('কারণ:', p['cause'] as String),
            ],
            const SizedBox(height: 8),
            _buildInfoRow(isWarn ? '' : 'সমাধান:', p['solution'] as String),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 6, top: 1),
            child: Text(
              label,
              style: const TextStyle(
                
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
