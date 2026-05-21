import '../localization/language_cubit.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'গর্ভবতী আয়না';
  static const String appVersion = '1.0.0';
  static const String appNameEn = 'MHRIS';

  // Routes
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeDashboard = '/dashboard';
  static const String routeKickCounter = '/kick-counter';
  static const String routeDoctor = '/doctor';
  static const String routeNutrition = '/nutrition';
  static const String routeWeeklyUpdate = '/weekly-update';
  static const String routeReminders = '/reminders';
  static const String routeDeliveryPrep = '/delivery-prep';
  static const String routeProfile = '/profile';

  // Shared Prefs Keys
  static const String prefIsLoggedIn = 'is_logged_in';
  static const String prefUserName = 'user_name';
  static const String prefWeeks = 'pregnancy_weeks';

  // Pregnancy Trimesters
  static const int firstTrimesterEnd = 13;
  static const int secondTrimesterEnd = 26;

  static String getTrimester(int weeks) {
    if (globalLanguage == 'English') {
      if (weeks <= firstTrimesterEnd) return '1st Trimester';
      if (weeks <= secondTrimesterEnd) return '2nd Trimester';
      return '3rd Trimester';
    }
    if (weeks <= firstTrimesterEnd) return '১ম ট্রাইমেস্টার চলছে';
    if (weeks <= secondTrimesterEnd) return '২য় ট্রাইমেস্টার চলছে';
    return '৩য় ট্রাইমেস্টার চলছে';
  }

  static String toBengaliNumber(int number) {
    if (globalLanguage == 'English') {
      return number.toString();
    }
    const digits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return number.toString().split('').map((d) {
      final idx = int.tryParse(d);
      return idx != null ? digits[idx] : d;
    }).join();
  }
}
