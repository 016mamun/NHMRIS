import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';

class BabyFoodScreen extends StatelessWidget {
  const BabyFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _buildAgeBanner(context),
                const SizedBox(height: 20),
                ..._foodStages.map((s) => _buildStageCard(context, s)),
                const SizedBox(height: 8),
                _buildFoodRulesCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _foodStages = [
    {
      'age': '০–৬ মাস',
      'emoji': '🤱',
      'title': 'শুধুমাত্র বুকের দুধ',
      'color': Color(0xFFEC407A),
      'bg': Color(0xFFFCE4EC),
      'foods': ['শুধু বুকের দুধ', 'কোনো পানি বা অন্য খাবার নয়', 'চাহিদামতো দুধ দিন'],
      'tip': '১ ঘণ্টার মধ্যে বুকের দুধ শুরু করুন।',
    },
    {
      'age': '৬–৮ মাস',
      'emoji': '🥣',
      'title': 'পরিপূরক খাবার শুরু',
      'color': Color(0xFF43A047),
      'bg': Color(0xFFE8F5E9),
      'foods': ['নরম খিচুড়ি (চাল+ডাল+সবজি+তেল)', 'কলা, পেঁপে, আম', 'নরম সুজি বা চালের পায়েস', 'বুকের দুধ চালু রাখুন'],
      'tip': 'প্রথমে ২ চামচ দিয়ে শুরু করুন, ধীরে ধীরে বাড়ান।',
    },
    {
      'age': '৯–১১ মাস',
      'emoji': '🍛',
      'title': 'বৈচিত্র্যময় খাবার',
      'color': Color(0xFF1E88E5),
      'bg': Color(0xFFE3F2FD),
      'foods': ['ভাত + ডাল + মাছ/মুরগি', 'নরম আলু, গাজর, কুমড়া', 'দই, পনির', 'ছোট ছোট করে কাটা ফল'],
      'tip': 'দিনে ৩ বেলা + ২ বার স্ন্যাকস।',
    },
    {
      'age': '১২–২৪ মাস',
      'emoji': '🍽️',
      'title': 'পারিবারিক খাবার',
      'color': Color(0xFF7C3AED),
      'bg': Color(0xFFEDE7F6),
      'foods': ['পরিবারের মতো খাবার (কম মশলা)', 'দুধ চালু রাখুন', 'সব ধরনের সবজি ও ফল', 'ডিম, মাছ, মুরগি নিয়মিত'],
      'tip': 'দিনে ৩ বেলা খাবার + ২–৩ বার স্ন্যাকস।',
    },
  ];

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
                    Text('শিশুর খাদ্য তালিকা'.tr(context), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildAgeBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFF8E1)]),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFF8F00).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Text('🌟', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'সঠিক পুষ্টি শিশুর মস্তিষ্ক ও শরীরের বিকাশ নিশ্চিত করে। বয়স অনুযায়ী সঠিক খাবার দিন।'.tr(context),
              style: TextStyle(fontSize: 13, color: Color(0xFF7B4F00), height: 1.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageCard(BuildContext context, Map<String, dynamic> s) {
    final color = s['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: s['bg'] as Color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(s['emoji'] as String, style: const TextStyle(fontSize: 30)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                        child: Text((s['age'] as String).tr(context), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
                      ),
                      const SizedBox(height: 4),
                      Text((s['title'] as String).tr(context), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...(s['foods'] as List<String>).map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Container(width: 5, height: 5, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(f.tr(context), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
                ],
              ),
            )),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_rounded, color: color, size: 16),
                  const SizedBox(width: 6),
                  Expanded(child: Text((s['tip'] as String).tr(context), style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodRulesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF43A047).withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('✅ সুষম পুষ্টির ৫টি নিয়ম'.tr(context), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
          const SizedBox(height: 10),
          ...['প্রতিবেলা শক্তি (ভাত/রুটি) + প্রোটিন (মাছ/ডাল) + সবজি দিন', 'রঙিন সবজি ও ফল নিয়মিত দিন', 'পর্যাপ্ত পানি ও তরল খাবার দিন', 'বাজারের প্যাকেট খাবার এড়িয়ে চলুন', 'খাবার সময় জোর করবেন না — শিশুর ক্ষুধার সংকেত দেখুন'].map(
            (rule) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Color(0xFF43A047), size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(rule.tr(context), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
