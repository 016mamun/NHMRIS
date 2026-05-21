import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_cubit.dart';

class AppTranslations {
  static const Map<String, Map<String, String>> _dict = {
    // Nav / Tabs
    'Home': {'বাংলা': 'হোম', 'English': 'Home'},
    'হোম': {'বাংলা': 'হোম', 'English': 'Home'},
    'Pregnancy': {'বাংলা': 'গর্ভাবস্থা', 'English': 'Pregnancy'},
    'গর্ভাবস্থা': {'বাংলা': 'গর্ভাবস্থা', 'English': 'Pregnancy'},
    'Baby Care': {'বাংলা': 'শিশুর জন্য', 'English': 'Baby Care'},
    'শিশুর জন্য': {'বাংলা': 'শিশুর জন্য', 'English': 'Baby Care'},
    'Profile': {'বাংলা': 'প্রোফাইল', 'English': 'Profile'},
    'প্রোফাইল': {'বাংলা': 'প্রোফাইল', 'English': 'Profile'},
    'More': {'বাংলা': 'আরও', 'English': 'More'},
    'আরও': {'বাংলা': 'আরও', 'English': 'More'},
    
    // Dashboard Header / Banner
    'your_modules': {'বাংলা': 'আপনার মডিউল সমূহ', 'English': 'Your Modules'},
    'maternal_panel': {'বাংলা': 'গর্ভবতী আয়না - MHRIS', 'English': 'Maternal Panel - MHRIS'},
    'welcome_back': {'বাংলা': 'স্বাগতম,', 'English': 'Welcome back,'},
    'home': {'বাংলা': 'হোম', 'English': 'Home'},
    'week_gestation': {'বাংলা': 'সপ্তাহের গর্ভাবস্থা', 'English': 'Weeks Gestation'},
    'days_left': {'বাংলা': 'দিন বাকি', 'English': 'Days Left'},
    'baby_size': {'বাংলা': 'শিশুর সম্ভাব্য আকার:', 'English': 'Estimated Baby Size:'},
    'weight': {'বাংলা': 'ওজন:', 'English': 'Weight:'},
    
    // Module Card Titles
    'কিক কাউন্টার ও স্বাস্থ্য': {'বাংলা': 'কিক কাউন্টার ও স্বাস্থ্য', 'English': 'Kick Counter & Health'},
    'কিক কাউন্টার': {'বাংলা': 'কিক কাউন্টার', 'English': 'Kick Counter'},
    'ডাক্তার পরামর্শ': {'বাংলা': 'ডাক্তার পরামর্শ', 'English': 'Doctor Consultation'},
    'পুষ্টি ও ডায়েট গাইড': {'বাংলা': 'পুষ্টি ও ডায়েট গাইড', 'English': 'Nutrition & Diet Guide'},
    'সাপ্তাহিক বেবি আপডেট': {'বাংলা': 'সাপ্তাহিক বেবি আপডেট', 'English': 'Weekly Baby Updates'},
    'শিশুর টিকা সূচি': {'বাংলা': 'শিশুর টিকা সূচি', 'English': 'Baby Vaccine Schedule'},
    'ডেলিভারির প্রস্তুতি': {'বাংলা': 'ডেলিভারির প্রস্তুতি', 'English': 'Delivery Preparation'},
    
    // Module Card Descriptions
    'description_kickCounter': {
      'বাংলা': 'আপনার শিশুর নড়াচড়া ট্র্যাক করুন এবং দৈনন্দিন স্বাস্থ্য আপডেট রাখুন।',
      'English': 'Track your baby\'s movement and keep daily health updates.'
    },
    'description_doctor': {
      'বাংলা': 'विशेषজ্ঞ গাইনী ডাক্তারের সাথে অনলাইনে পরামর্শ ও অ্যাপয়েন্টমেন্ট নিন।',
      'English': 'Consult online & book appointments with expert gynecologists.'
    },
    'description_nutrition': {
      'বাংলা': 'গর্ভাবস্থার সঠিক খাদ্য তালিকা, রেসিপি এবং পানি পান ট্র্যাকিং।',
      'English': 'Pregnancy meal plans, recipes, and water intake tracker.'
    },
    'description_weeklyUpdate': {
      'বাংলা': 'আপনার শিশুর আকার, ওজন এবং প্রতি সপ্তাহের নতুন পরিবর্তন জানুন।',
      'English': 'Learn your baby\'s size, weight, and changes week-by-week.'
    },
    'description_reminders': {
      'বাংলা': 'শিশুর সকল সরকারি ও বেসরকারি টিকার সঠিক সময়সূচি ও বিবরণ।',
      'English': 'Accurate schedules & details of government & private child vaccines.'
    },
    'description_deliveryPrep': {
      'বাংলা': 'হাসপাতাল চেকলিস্ট, লেবার পেইন ট্র্যাকার ও দরকারি নির্দেশিকা।',
      'English': 'Hospital checklist, labor contraction tracker, & guides.'
    },
    
    // Bottom Sheets & Menu Items
    'আরও ফিচার সমূহ': {'বাংলা': 'আরও ফিচার সমূহ', 'English': 'More Features'},
    'এএনসি (গর্ভকালীন সেবা)': {'বাংলা': 'এএনসি (গর্ভকালীন সেবা)', 'English': 'ANC (Maternal Care)'},
    'জরুরি রক্তের গ্রুপ': {'বাংলা': 'জরুরি রক্তের গ্রুপ', 'English': 'Emergency Blood Group'},
    'নিকটস্থ হাসপাতাল': {'বাংলা': 'নিকটস্থ হাসপাতাল', 'English': 'Nearby Hospitals'},
    'জরুরি যোগাযোগ (হেল্পলাইন)': {'বাংলা': 'জরুরি যোগাযোগ (হেল্পলাইন)', 'English': 'Emergency Helplines'},
    'অ্যাপ সম্পর্কে জানুন': {'বাংলা': 'অ্যাপ সম্পর্কে জানুন', 'English': 'About the App'},
    'সেটিংস': {'বাংলা': 'সেটিংস', 'English': 'Settings'},
    'লগআউট': {'বাংলা': 'লগআউট', 'English': 'Logout'},
    'প্রোফাইল সম্পাদনা': {'বাংলা': 'প্রোফাইল সম্পাদনা', 'English': 'Edit Profile'},
    
    // Settings Screen
    'সেটিংস (Settings)': {'বাংলা': 'সেটিংস (Settings)', 'English': 'Settings'},
    'সাধারণ সেটিংস (General)': {'বাংলা': 'সাধারণ সেটিংস (General)', 'English': 'General Settings'},
    'অ্যাপের ভাষা': {'বাংলা': 'অ্যাপের ভাষা', 'English': 'App Language'},
    'অফলাইন ডাটা সিঙ্ক ও ব্যাকআপ': {'বাংলা': 'অফলাইন ডাটা সিঙ্ক ও ব্যাকআপ', 'English': 'Offline Sync & Backup'},
    'আপনার মেডিকেল রেকর্ড ক্লাউডে সেভ করুন': {'বাংলা': 'আপনার মেডিকেল রেকর্ড ক্লাউডে সেভ করুন', 'English': 'Save your medical records to the cloud'},
    'বিজ্ঞপ্তি ও রিমাইন্ডার সেটিংস': {'বাংলা': 'বিজ্ঞপ্তি ও রিমাইন্ডার সেটিংস', 'English': 'Notification & Reminder Settings'},
    'টিকার রিমাইন্ডার এলার্ট': {'বাংলা': 'টিকার রিমাইন্ডার এলার্ট', 'English': 'Vaccine Reminder Alerts'},
    'ভ্যাকসিনের তারিখের পূর্বের নোটিফিকেশন': {'বাংলা': 'ভ্যাকসিনের তারিখের পূর্বের নোটিফিকেশন', 'English': 'Notifications before vaccine dates'},
    'ডাক্তারের এপয়েন্টমেন্ট রিমাইন্ডার': {'বাংলা': 'ডাক্তারের এপয়েন্টমেন্ট রিমাইন্ডার', 'English': 'Doctor Appointment Reminders'},
    'চেকআপ তারিখের নোটিফিকেশন এলার্ট': {'বাংলা': 'চেকআপ তারিখের নোটিফিকেশন এলার্ট', 'English': 'Notification alerts for checkup dates'},
    'গর্ভকালীন দৈনিক স্বাস্থ্য টিপস': {'বাংলা': 'গর্ভকালীন দৈনিক স্বাস্থ্য টিপস', 'English': 'Daily Pregnancy Health Tips'},
    'মা ও শিশুর বিকাশের প্রয়োজনীয় পুষ্টি টিপস': {'বাংলা': 'মা ও শিশুর বিকাশের প্রয়োজনীয় পুষ্টি টিপস', 'English': 'Essential nutrition tips for mother & baby development'},
    'কিক কাউন্টার অনুস্মারক': {'বাংলা': 'কিক কাউন্টার অনুস্মারক', 'English': 'Kick Counter Reminders'},
    'দৈনিক গর্ভের শিশুর কিক গুনতে রিমাইন্ডার': {'বাংলা': 'দৈনিক গর্ভের শিশুর কিক গুনতে রিমাইন্ডার', 'English': 'Reminders to count baby\'s daily kicks'},
    'নিরাপত্তা ও ডাটা পলিসি': {'বাংলা': 'নিরাপত্তা ও ডাটা পলিসি', 'English': 'Security & Data Policy'},
    'অ্যাপ পাসকোড লক': {'বাংলা': 'অ্যাপ পাসকোড লক', 'English': 'App Passcode Lock'},
    'অ্যাপ খোলার সময় পিন লক নিশ্চিত করুন': {'বাংলা': 'অ্যাপ খোলার সময় পিন লক নিশ্চিত করুন', 'English': 'Enable PIN lock when launching the app'},
    'বায়োমেট্রিক আনলক (ফিঙ্গারপ্রিন্ট)': {'বাংলা': 'বায়োমেট্রিক আনলক (ফিঙ্গারপ্রিন্ট)', 'English': 'Biometric Unlock (Fingerprint)'},
    'দ্রুত অ্যাক্সেসের জন্য ফিঙ্গারপ্রিন্ট সেট করুন': {'বাংলা': 'দ্রুত অ্যাক্সেসের জন্য ফিঙ্গারপ্রিন্ট সেট করুন', 'English': 'Set fingerprint for fast secure access'},
    'অ্যাকাউন্ট সেটিংস': {'বাংলা': 'অ্যাকাউন্ট সেটিংস', 'English': 'Account Settings'},
    'পাসওয়ার্ড পরিবর্তন করুন': {'বাংলা': 'পাসওয়ার্ড পরিবর্তন করুন', 'English': 'Change Password'},
    'আপনার গোপনীয় পাসওয়ার্ড পরিবর্তন করুন': {'বাংলা': 'আপনার গোপনীয় পাসওয়ার্ড পরিবর্তন করুন', 'English': 'Change your private password'},
    'অ্যাকাউন্ট মুছে ফেলুন (Delete Account)': {'বাংলা': 'অ্যাকাউন্ট মুছে ফেলুন (Delete Account)', 'English': 'Delete Account'},
    'আপনার সমস্ত ডাটা চিরতরে ডিলিট করুন': {'বাংলা': 'আপনার সমস্ত ডাটা চিরতরে ডিলিট করুন', 'English': 'Permanently delete all your records'},
    'সহায়তা ও তথ্য': {'বাংলা': 'সহায়তা ও তথ্য', 'English': 'Help & Support'},
    'গোপনীয়তা নীতিমালা (Privacy Policy)': {'বাংলা': 'গোপনীয়তা নীতিমালা (Privacy Policy)', 'English': 'Privacy Policy'},
    'আমাদের ডাটা ব্যবহার নির্দেশিকা পড়ুন': {'বাংলা': 'আমাদের ডাটা ব্যবহার নির্দেশিকা পড়ুন', 'English': 'Read our data usage policy'},
    'সচরাচর জিজ্ঞাসিত প্রশ্ন (FAQ)': {'বাংলা': 'সচরাচর জিজ্ঞাসিত প্রশ্ন (FAQ)', 'English': 'Frequently Asked Questions (FAQ)'},
    'অ্যাপ ব্যবহারে সাধারণ জিজ্ঞাসাসমূহ': {'বাংলা': 'অ্যাপ ব্যবহারে সাধারণ জিজ্ঞাসাসমূহ', 'English': 'Common questions about using the app'},
    
    // Popup Actions
    'বাতিল': {'বাংলা': 'বাতিল', 'English': 'Cancel'},
    'বাতিল করুন': {'বাংলা': 'বাতিল করুন', 'English': 'Cancel'},
    'আপডেট করুন': {'বাংলা': 'আপডেট করুন', 'English': 'Update'},
    'অফলাইন ব্যাকআপ ও সিঙ্ক': {'বাংলা': 'অফলাইন ব্যাকআপ ও সিঙ্ক', 'English': 'Offline Backup & Sync'},
    'ডাটা ব্যাকআপ ও সিঙ্ক করা হচ্ছে...': {'বাংলা': 'ডাটা ব্যাকআপ ও সিঙ্ক করা হচ্ছে...', 'English': 'Data is backing up and syncing...'},
    'অনুগ্রহ করে অপেক্ষা করুন, সংযোগ বিচ্ছিন্ন করবেন না।': {'বাংলা': 'অনুগ্রহ করে অপেক্ষা করুন, সংযোগ বিচ্ছিন্ন করবেন না।', 'English': 'Please wait, do not disconnect.'},
    'আপনার গর্ভাবস্থা ও শিশুর ডাটা সফলভাবে অফলাইন সিঙ্ক হয়েছে!': {'বাংলা': 'আপনার গর্ভাবস্থা ও শিশুর ডাটা সফলভাবে অফলাইন সিঙ্ক হয়েছে!', 'English': 'Your pregnancy and baby data has been successfully synced!'},
    'পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে!': {'বাংলা': 'পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে!', 'English': 'Password successfully changed!'},
    'নতুন পাসওয়ার্ড': {'বাংলা': 'নতুন পাসওয়ার্ড', 'English': 'New Password'},
    'বর্তমান পাসওয়ার্ড': {'বাংলা': 'বর্তমান পাসওয়ার্ড', 'English': 'Current Password'},
    'নতুন পাসওয়ার্ড নিশ্চিত করুন': {'বাংলা': 'নতুন পাসওয়ার্ড নিশ্চিত করুন', 'English': 'Confirm New Password'},
    'নতুন পাসওয়ার্ড দুইটি মেলেনি!': {'বাংলা': 'নতুন পাসওয়ার্ড দুইটি মেলেনি!', 'English': 'The two new passwords do not match!'},
    'অ্যাকাউন্ট মুছে ফেলবেন?': {'বাংলা': 'অ্যাকাউন্ট মুছে ফেলবেন?', 'English': 'Delete Account?'},
    'আপনি কি নিশ্চিত যে আপনার MHRIS অ্যাকাউন্টটি স্থায়ীভাবে ডিলিট করতে চান? আপনার পূর্ববর্তী সমস্ত গর্ভাবস্থা ও ভ্যাকসিনের মেডিকেল রেকর্ড ডাটা স্থায়ীভাবে মুছে যাবে!': {
      'বাংলা': 'আপনি কি নিশ্চিত যে আপনার MHRIS অ্যাকাউন্টটি স্থায়ীভাবে ডিলিট করতে চান? আপনার পূর্ববর্তী সমস্ত গর্ভাবস্থা ও ভ্যাকসিনের মেডিকেল রেকর্ড ডাটা স্থায়ীভাবে মুছে যাবে!',
      'English': 'Are you sure you want to permanently delete your MHRIS account? All your previous pregnancy and vaccine medical records will be deleted forever!'
    },
    'হ্যাঁ, ডিলিট করুন': {'বাংলা': 'হ্যাঁ, ডিলিট করুন', 'English': 'Yes, Delete'},
    'অ্যাকাউন্ট নিষ্ক্রিয়করণের অনুরোধ জমা হয়েছে।': {'বাংলা': 'অ্যাকাউন্ট নিষ্ক্রিয়করণের অনুরোধ জমা হয়েছে।', 'English': 'Account deletion request has been submitted.'},
    'গোপনীয়তা নীতিমালা ফাইল ওপেন করা হচ্ছে...': {'বাংলা': 'গোপনীয়তা নীতিমালা ফাইল ওপেন করা হচ্ছে...', 'English': 'Opening Privacy Policy...'},
    'এফএকিউ পেজ লোড হচ্ছে...': {'বাংলা': 'এফএকিউ পেজ লোড হচ্ছে...', 'English': 'Loading FAQ page...'},
    'হ্যালো, ': {'বাংলা': 'হ্যালো, ', 'English': 'Hello, '},
    'আজ আপনি দারুণ করছেন। চলুন আজকের আপডেটগুলো দেখে নিই।': {
      'বাংলা': 'আজ আপনি দারুণ করছেন। চলুন আজকের আপডেটগুলো দেখে নিই।',
      'English': 'You are doing great today. Let\'s see today\'s updates.'
    },
    ' সপ্তাহ': {'বাংলা': ' সপ্তাহ', 'English': ' Weeks'},
    '১ম ট্রাইমেস্টার চলছে': {'বাংলা': '১ম ট্রাইমেস্টার চলছে', 'English': '1st Trimester Ongoing'},
    '২য় ট্রাইমেস্টার চলছে': {'বাংলা': '২য় ট্রাইমেস্টার চলছে', 'English': '2nd Trimester Ongoing'},
    '৩য় ট্রাইমেস্টার চলছে': {'বাংলা': '৩য় ট্রাইমেস্টার চলছে', 'English': '3rd Trimester Ongoing'},
    'গর্ভাবস্থা ট্র্যাকার সমূহ': {'বাংলা': 'গর্ভাবস্থা ট্র্যাকার সমূহ', 'English': 'Pregnancy Trackers'},
    'শিশুর জন্য সেবা সমূহ': {'বাংলা': 'শিশুর জন্য সেবা সমূহ', 'English': 'Baby Services'},
    'শিশুর পুষ্টি ও যত্ন': {'বাংলা': 'শিশুর পুষ্টি ও যত্ন', 'English': 'Baby Nutrition & Care'},
    'আপনার মডিউল সমূহ': {'বাংলা': 'আপনার মডিউল সমূহ', 'English': 'Your Modules'},
    'মাতৃত্ব প্যানেল': {'বাংলা': 'মাতৃত্ব প্যানেল', 'English': 'Maternal Panel'},
    'প্রোফাইল দেখুন': {'বাংলা': 'প্রোফাইল দেখুন', 'English': 'View Profile'},
    // Auth
    'গর্ভতী আয়না': {'বাংলা': 'গর্ভবতী আয়না', 'English': 'Pregnancy Mirror'},
    'মোবাইল নম্বর': {'বাংলা': 'মোবাইল নম্বর', 'English': 'Mobile Number'},
  };

  static String translate(BuildContext context, String value) {
    try {
      final String currentLang = BlocProvider.of<LanguageCubit>(context).state;
      // Exact Match
      if (_dict.containsKey(value)) {
        return _dict[value]![currentLang] ?? value;
      }
      // Value Match Fallback
      for (final entry in _dict.values) {
        if (entry['বাংলা'] == value) {
          return entry[currentLang] ?? value;
        }
        if (entry['English'] == value) {
          return entry[currentLang] ?? value;
        }
      }
    } catch (_) {}
    return value;
  }
}

extension LocalizationExtension on String {
  String tr(BuildContext context) {
    return AppTranslations.translate(context, this);
  }
}
