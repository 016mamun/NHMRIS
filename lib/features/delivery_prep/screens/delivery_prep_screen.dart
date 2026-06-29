import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class DeliveryPrepScreen extends StatefulWidget {
  const DeliveryPrepScreen({super.key});

  @override
  State<DeliveryPrepScreen> createState() => _DeliveryPrepScreenState();
}

class _DeliveryPrepScreenState extends State<DeliveryPrepScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  final List<Map<String, dynamic>> _checklist = [
    {'item': 'মায়ের জামাকাপড় (৩-৪ সেট)', 'checked': false, 'category': 'মায়ের জিনিস'},
    {'item': 'হাসপাতালের কাগজপত্র ও রিপোর্ট', 'checked': false, 'category': 'কাগজপত্র'},
    {'item': 'জাতীয় পরিচয়পত্র / জন্ম সনদ', 'checked': false, 'category': 'কাগজপত্র'},
    {'item': 'নবজাতকের জামাকাপড় (৫-৬ সেট)', 'checked': false, 'category': 'শিশুর জিনিস'},
    {'item': 'ডায়াপার (১ প্যাকেট)', 'checked': false, 'category': 'শিশুর জিনিস'},
    {'item': 'শিশুর কম্বল ও চাদর', 'checked': true, 'category': 'শিশুর জিনিস'},
    {'item': 'ফোন চার্জার ও পাওয়ার ব্যাংক', 'checked': true, 'category': 'অন্যান্য'},
    {'item': 'নগদ অর্থ ও বিমা কার্ড', 'checked': false, 'category': 'আর্থিক'},
    {'item': 'স্যানিটারি প্যাড', 'checked': false, 'category': 'মায়ের জিনিস'},
    {'item': 'খাবার পানি ও হালকা স্ন্যাকস', 'checked': false, 'category': 'অন্যান্য'},
  ];

  static const _laborSigns = [
    {'sign': 'নিয়মিত ব্যথা', 'desc': 'প্রতি ৫-১০ মিনিটে ব্যথা শুরু হয়', 'urgent': false},
    {'sign': 'পানি ভেঙে পড়া', 'desc': 'অ্যামনিওটিক ফ্লুইড বের হওয়া - এখনই হাসপাতালে যান', 'urgent': true},
    {'sign': 'রক্তপাত', 'desc': 'যেকোনো রক্তপাত দেখলে সাথে সাথে ডাক্তার ডাকুন', 'urgent': true},
    {'sign': 'শিশুর নড়াচড়া কমে যাওয়া', 'desc': '২ ঘণ্টায় ১০টির কম কিক হলে সতর্ক থাকুন', 'urgent': true},
    {'sign': 'ঘন ঘন প্রস্রাব', 'desc': 'শিশু নিচে নামার কারণে চাপ বাড়তে পারে', 'urgent': false},
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  int get _checkedCount => _checklist.where((i) => i['checked'] as bool).length;

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tab,
              labelColor: AppColors.deliveryIcon,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.deliveryIcon,
              labelStyle: AppTextStyles.labelMedium,
              tabs: [Tab(text: 'চেকলিস্ট'.tr(context)), Tab(text: 'লেবার সাইন'.tr(context))],
            ),
          ),
          Expanded(child: TabBarView(controller: _tab, children: [
            _buildChecklistTab(),
            _buildLaborSignsTab(),
          ])),
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
                    Text('ডেলিভারির প্রস্তুতি'.tr(context), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('সময়মতো প্রস্তুত থাকুন'.tr(context), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildChecklistTab() {
    return Column(children: [
      // Progress
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.deliveryBg, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.deliveryIcon.withValues(alpha: 0.3)),
        ),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('প্রস্তুতির অগ্রগতি'.tr(context), style: AppTextStyles.headingSmall),
            Text('$_checkedCount/${_checklist.length}', style: AppTextStyles.labelMedium.copyWith(color: AppColors.deliveryIcon)),
          ]),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _checkedCount / _checklist.length,
              minHeight: 10,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation(AppColors.deliveryIcon),
            ),
          ),
        ]),
      ),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: _checklist.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final item = _checklist[i];
            final done = item['checked'] as bool;
            return GestureDetector(
              onTap: () => setState(() => item['checked'] = !done),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: done ? AppColors.success.withValues(alpha: 0.06) : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: done ? AppColors.success.withValues(alpha: 0.3) : AppColors.border),
                  boxShadow: done ? [] : [BoxShadow(color: AppColors.shadow, blurRadius: 6)],
                ),
                child: Row(children: [
                  Container(
                    width: 26, height: 26,
                    decoration: BoxDecoration(
                      color: done ? AppColors.success : Colors.transparent, shape: BoxShape.circle,
                      border: Border.all(color: done ? AppColors.success : AppColors.border, width: 2),
                    ),
                    child: done ? const Center(child: Icon(Icons.check, color: Colors.white, size: 15)) : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      (item['item'] as String).tr(context),
                      style: AppTextStyles.labelMedium.copyWith(
                        color: done ? AppColors.textHint : AppColors.textPrimary,
                        decoration: done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text((item['category'] as String).tr(context), style: AppTextStyles.bodySmall),
                  ])),
                ]),
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget _buildLaborSignsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _laborSigns.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final s = _laborSigns[i];
        final urgent = s['urgent'] as bool;
        final color = urgent ? AppColors.error : AppColors.deliveryIcon;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
              child: Center(child: Icon(urgent ? Icons.warning_amber_rounded : Icons.info_outline_rounded, color: color)),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text((s['sign'] as String).tr(context), style: AppTextStyles.headingSmall.copyWith(color: color)),
                if (urgent) ...[const SizedBox(width: 6), Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(20)),
                  child: Text('জরুরি'.tr(context), style: const TextStyle(fontSize: 10, color: Colors.white)),
                )],
              ]),
              const SizedBox(height: 4),
              Text((s['desc'] as String).tr(context), style: AppTextStyles.bodyMedium),
            ])),
          ]),
        );
      },
    );
  }
}
