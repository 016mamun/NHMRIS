import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ComplicationsScreen extends StatelessWidget {
  const ComplicationsScreen({super.key});

  static const List<Map<String, dynamic>> _items = [
    {
      'emoji': '🔴',
      'title': 'অতিরিক্ত রক্তপাত',
      'risk': 'অতি উচ্চ ঝুঁকি',
      'signs': 'যোনিপথে প্রচুর রক্তপাত, পেটে তীব্র ব্যথা',
      'action': 'তাৎক্ষণিক নিকটস্থ হাসপাতালে যান বা ৯৯৯ কল করুন।',
      'emergency': true,
      'color': Color(0xFFE53935),
      'bg': Color(0xFFFFEBEE),
    },
    {
      'emoji': '🩺',
      'title': 'উচ্চ রক্তচাপ (প্রি-এক্লাম্পসিয়া)',
      'risk': 'উচ্চ ঝুঁকি',
      'signs': 'প্রচণ্ড মাথাব্যথা, চোখে ঝাপসা দেখা, মুখ ও হাত ফুলে যাওয়া',
      'action': 'অবিলম্বে ডাক্তারের কাছে যান। রক্তচাপ পরিমাপ করুন।',
      'emergency': true,
      'color': Color(0xFFD81B60),
      'bg': Color(0xFFFCE4EC),
    },
    {
      'emoji': '👶',
      'title': 'গর্ভের শিশুর নড়াচড়া কমে যাওয়া',
      'risk': 'উচ্চ ঝুঁকি',
      'signs': '১২ ঘণ্টায় ১০ বারের কম নড়াচড়া',
      'action': 'ঠান্ডা কিছু খেয়ে বাঁ দিকে শুয়ে থাকুন এবং নড়াচড়া গণনা করুন। পরিবর্তন না হলে ডাক্তার দেখান।',
      'emergency': false,
      'color': Color(0xFF7C3AED),
      'bg': Color(0xFFEDE7F6),
    },
    {
      'emoji': '💧',
      'title': 'অ্যামনিয়াটিক তরল ভেঙে যাওয়া',
      'risk': 'অতি উচ্চ ঝুঁকি',
      'signs': 'যোনি থেকে হঠাৎ তরল বের হওয়া (প্রস্রাবের চেয়ে বেশি)',
      'action': 'সাথে সাথে হাসপাতালে যান। এটি প্রসবের প্রাথমিক লক্ষণ হতে পারে।',
      'emergency': true,
      'color': Color(0xFF1E88E5),
      'bg': Color(0xFFE3F2FD),
    },
    {
      'emoji': '🌡️',
      'title': 'জ্বর ও সংক্রমণ',
      'risk': 'মধ্যম ঝুঁকি',
      'signs': 'তাপমাত্রা ৩৮°C-এর বেশি, কাঁপুনি, প্রস্রাবে জ্বালা',
      'action': 'ডাক্তারের পরামর্শ ছাড়া কোনো ওষুধ নেবেন না। জরুরি চিকিৎসা নিন।',
      'emergency': false,
      'color': Color(0xFFFF8F00),
      'bg': Color(0xFFFFF3E0),
    },
    {
      'emoji': '⚡',
      'title': 'খিঁচুনি (Eclampsia)',
      'risk': 'অতি উচ্চ ঝুঁকি',
      'signs': 'শরীরে খিঁচুনি, চেতনা হারানো',
      'action': 'এটি একটি প্রাণঘাতী জরুরি অবস্থা। তাৎক্ষণিক ৯৯৯ কল করুন।',
      'emergency': true,
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
              itemCount: _items.length,
              itemBuilder: (_, i) => _buildCard(_items[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildEmergencyFAB(context),
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
                    Text('গর্ভকালীন জটিলতা', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('জরুরি লক্ষণ ও করণীয়', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> item) {
    final color = item['color'] as Color;
    final isEmergency = item['emergency'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: item['bg'] as Color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25), width: isEmergency ? 1.5 : 1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item['emoji'] as String, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item['title'] as String,
                    style: TextStyle(
                      
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['risk'] as String,
                    style: TextStyle(
                      
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            _infoRow('🔍 লক্ষণ:', item['signs'] as String),
            const SizedBox(height: 8),
            _infoRow('✅ করণীয়:', item['action'] as String),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('জরুরি যোগাযোগ', style: TextStyle(fontWeight: FontWeight.w700)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _emergencyContact('৯৯৯', 'জাতীয় জরুরি সেবা'),
                _emergencyContact('১৬০০০', 'স্বাস্থ্য বাতায়ন'),
                _emergencyContact('১৩২৪', 'গর্ভকালীন বিশেষ হেল্পলাইন'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('বন্ধ করুন', style: TextStyle(fontFamily: 'Hind_Siliguri')),
              ),
            ],
          ),
        );
      },
      backgroundColor: const Color(0xFFE53935),
      icon: const Icon(Icons.phone_in_talk, color: Colors.white),
      label: const Text('জরুরি কল', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
    );
  }

  Widget _emergencyContact(String number, String label) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.phone, color: Color(0xFFE53935)),
      title: Text(number, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      subtitle: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}
