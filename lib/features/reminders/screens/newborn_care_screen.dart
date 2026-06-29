import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';

class NewbornCareScreen extends StatefulWidget {
  const NewbornCareScreen({super.key});

  @override
  State<NewbornCareScreen> createState() => _NewbornCareScreenState();
}

class _NewbornCareScreenState extends State<NewbornCareScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabCtrl,
              labelColor: const Color(0xFF43A047),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF43A047),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              unselectedLabelStyle: const TextStyle(fontSize: 13),
              tabs: [
                Tab(text: 'যত্ন'.tr(context)),
                Tab(text: 'পুষ্টি'.tr(context)),
                Tab(text: 'বিপদ চিহ্ন'.tr(context)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _buildCareTab(context),
                _buildNutritionTab(context),
                _buildDangerTab(context),
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
                  child: Text('নবজাতকের যত্ন ও পুষ্টি'.tr(context), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCareTab(BuildContext context) {
    final items = [
      {'emoji': '🌡️', 'title': 'শরীরের তাপমাত্রা রক্ষা', 'desc': 'নবজাতককে সবসময় উষ্ণ রাখুন। ঠান্ডা বাতাস থেকে দূরে রাখুন। কানুরু কেয়ার (মা বা বাবার বুকে রেখে উষ্ণ রাখা) অত্যন্ত কার্যকর।', 'color': const Color(0xFFFF8F00)},
      {'emoji': '🛁', 'title': 'গোসল ও পরিষ্কার', 'desc': 'নাভি পড়ে যাওয়ার আগে ভেজা কাপড় দিয়ে মুছে দিন। গোসল সপ্তাহে ২–৩ বার দিলেই চলে। নাভির গোড়া পরিষ্কার ও শুকনো রাখুন।', 'color': const Color(0xFF1E88E5)},
      {'emoji': '😴', 'title': 'ঘুম ও বিশ্রাম', 'desc': 'নবজাতক দিনে ১৬–১৮ ঘণ্টা ঘুমায়। শিশুকে চিৎ করে শুয়ে দিন। বালিশ বা নরম কম্বল এড়িয়ে চলুন (SIDS ঝুঁকি)।', 'color': const Color(0xFF7C3AED)},
      {'emoji': '👁️', 'title': 'চোখের যত্ন', 'desc': 'চোখ পরিষ্কার তুলো বা নরম কাপড় দিয়ে মুছুন। যদি লাল বা পুঁজ হয় তাহলে ডাক্তার দেখান।', 'color': const Color(0xFF00897B)},
      {'emoji': '👂', 'title': 'শ্রবণ পরীক্ষা', 'desc': 'জন্মের ১ মাসের মধ্যে শিশুর শ্রবণ পরীক্ষা করুন। উচ্চ শব্দে সাড়া না দিলে বিশেষজ্ঞ দেখান।', 'color': const Color(0xFFEC407A)},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: items.map((item) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['emoji'] as String, style: TextStyle(fontSize: 28)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((item['title'] as String).tr(context), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: item['color'] as Color)),
                  SizedBox(height: 4),
                  Text((item['desc'] as String).tr(context), style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildNutritionTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _greenCard(context, '🤱 প্রথম ৬ মাস', 'শুধুমাত্র বুকের দুধ\n\nবুকের দুধ শিশুর সকল পুষ্টির চাহিদা পূরণ করে — পানি, ভিটামিন, মিনারেল সবকিছু। কোনো অতিরিক্ত পানি বা খাবার দেবেন না।'),
        SizedBox(height: 12),
        _greenCard(context, '🥣 ৬ মাস পর থেকে', 'বুকের দুধের পাশাপাশি পরিপূরক খাবার\n\n• খিচুড়ি (চাল + ডাল + সবজি + তেল)\n• নরম ভাত\n• ফল: কলা, পেঁপে, আম\n• দিনে ২–৩ বার ছোট ছোট পরিমাণে'),
        SizedBox(height: 12),
        _greenCard(context, '⚠️ কী এড়াবেন', '• ১ বছরের আগে গরুর দুধ নয়\n• মধু নয় (botulism ঝুঁকি)\n• বাজারের প্যাকেট খাবার এড়িয়ে চলুন\n• অতিরিক্ত লবণ ও চিনি নয়'),
      ],
    );
  }

  Widget _greenCard(BuildContext context, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF43A047).withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.tr(context), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
          SizedBox(height: 8),
          Text(body.tr(context), style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildDangerTab(BuildContext context) {
    final dangers = [
      'শ্বাস-প্রশ্বাস দ্রুত বা কঠিন হওয়া',
      'শরীর হলুদ হয়ে যাওয়া (জন্ডিস) — জন্মের ২৪ ঘণ্টার মধ্যে',
      'নাভি থেকে পুঁজ বা দুর্গন্ধ',
      'খাওয়া একদম বন্ধ করে দেওয়া',
      'শরীর ঠান্ডা বা অস্বাভাবিক নীল হওয়া',
      'খিঁচুনি',
      '৩৮°C-এর বেশি জ্বর',
      'ডায়রিয়া বা বমি বারবার হওয়া',
      'অস্বাভাবিক কান্না বা একদম চুপ থাকা',
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE53935).withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.emergency_rounded, color: Color(0xFFE53935), size: 24),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'এই লক্ষণগুলো দেখলে তাৎক্ষণিক হাসপাতালে যান'.tr(context),
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFFE53935)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              ...dangers.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning_rounded, color: Color(0xFFE53935), size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(d.tr(context), style: TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4)),
                    ),
                  ],
                ),
              )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '📞 জরুরি হেল্পলাইন: ১৬০০০'.tr(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
