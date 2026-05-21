import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum ModuleType {
  kickCounter,
  doctor,
  nutrition,
  weeklyUpdate,
  reminders,
  deliveryPrep,
}

class ModuleModel {
  final ModuleType type;
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color arrowColor;
  final String route;

  const ModuleModel({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.arrowColor,
    required this.route,
  });

  static List<ModuleModel> get allModules => const [
    ModuleModel(
      type: ModuleType.kickCounter,
      title: 'কিক কাউন্টার ও স্বাস্থ্য',
      description: 'আপনার শিশুর নড়াচড়া ট্র্যাক করুন এবং দৈনন্দিন স্বাস্থ্য আপডেট রাখুন।',
      icon: Icons.child_care_rounded,
      iconColor: AppColors.kickCounterIcon,
      bgColor: AppColors.kickCounterBg,
      arrowColor: AppColors.arrowGreen,
      route: '/kick-counter',
    ),
    ModuleModel(
      type: ModuleType.doctor,
      title: 'ডাক্তার পরামর্শ',
      description: 'বিশেষজ্ঞ গাইনী ডাক্তারের সাথে অনলাইনে পরামর্শ ও অ্যাপয়েন্টমেন্ট নিন।',
      icon: Icons.medical_services_outlined,
      iconColor: AppColors.doctorIcon,
      bgColor: AppColors.doctorBg,
      arrowColor: AppColors.arrowBlue,
      route: '/doctor',
    ),
    ModuleModel(
      type: ModuleType.nutrition,
      title: 'পুষ্টি ও ডায়েট গাইড',
      description: 'গর্ভাবস্থার সঠিক খাদ্য তালিকা, রেসিপি এবং পানি পান ট্র্যাকিং।',
      icon: Icons.restaurant_menu_rounded,
      iconColor: AppColors.nutritionIcon,
      bgColor: AppColors.nutritionBg,
      arrowColor: AppColors.arrowGreen,
      route: '/nutrition',
    ),
    ModuleModel(
      type: ModuleType.weeklyUpdate,
      title: 'সাপ্তাহিক বেবি আপডেট',
      description: 'আপনার শিশুর আকার, ওজন এবং প্রতি সপ্তাহের নতুন পরিবর্তন জানুন।',
      icon: Icons.calendar_month_rounded,
      iconColor: AppColors.weeklyIcon,
      bgColor: AppColors.weeklyBg,
      arrowColor: AppColors.arrowPurple,
      route: '/weekly-update',
    ),
    ModuleModel(
      type: ModuleType.reminders,
      title: 'শিশুর টিকা সূচি',
      description: 'শিশুর সকল সরকারি ও বেসরকারি টিকার সঠিক সময়সূচি ও বিবরণ।',
      icon: Icons.vaccines_rounded,
      iconColor: AppColors.reminderIcon,
      bgColor: AppColors.reminderBg,
      arrowColor: AppColors.arrowPink,
      route: '/reminders',
    ),
    ModuleModel(
      type: ModuleType.deliveryPrep,
      title: 'ডেলিভারির প্রস্তুতি',
      description: 'হাসপাতাল চেকলিস্ট, লেবার পেইন ট্র্যাকার ও দরকারি নির্দেশিকা।',
      icon: Icons.checklist_rounded,
      iconColor: AppColors.deliveryIcon,
      bgColor: AppColors.deliveryBg,
      arrowColor: AppColors.arrowOrange,
      route: '/delivery-prep',
    ),
  ];
}
