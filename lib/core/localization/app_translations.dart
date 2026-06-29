import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_cubit.dart';

class AppTranslations {
  static const Map<String, Map<String, String>> _dict = {
    // Nav / Tabs
    'Home': {'বাংলা': 'হোম', 'English': 'Home'},
    'হোম': {'বাংলা': 'হোম', 'English': 'Home'},
    'পরামর্শ': {'বাংলা': 'পরামর্শ', 'English': 'Consult'},
    'ট্র্যাকার': {'বাংলা': 'ট্র্যাকার', 'English': 'Tracker'},
    'হাসপাতাল': {'বাংলা': 'হাসপাতাল', 'English': 'Hospital'},
    // Pregnancy progress card
    'সম্ভাব্য ডেলিভারি:': {'বাংলা': 'সম্ভাব্য ডেলিভারি:', 'English': 'Expected Delivery:'},
    'সপ্তাহ বাকি': {'বাংলা': 'সপ্তাহ বাকি', 'English': 'Weeks Left'},
    'গর্ভাবস্থার অগ্রগতি': {'বাংলা': 'গর্ভাবস্থার অগ্রগতি', 'English': 'Pregnancy Progress'},
    '১ম ত্রৈমাসিক': {'বাংলা': '১ম ত্রৈমাসিক', 'English': '1st Trimester'},
    '২য় ত্রৈমাসিক': {'বাংলা': '২য় ত্রৈমাসিক', 'English': '2nd Trimester'},
    '৩য় ত্রৈমাসিক': {'বাংলা': '৩য় ত্রৈমাসিক', 'English': '3rd Trimester'},
    'তম সপ্তাহ চলছে': {'বাংলা': 'তম সপ্তাহ চলছে', 'English': 'th Week Ongoing'},

    // Months
    'জানুয়ারি': {'বাংলা': 'জানুয়ারি', 'English': 'January'},
    'ফেব্রুয়ারি': {'বাংলা': 'ফেব্রুয়ারি', 'English': 'February'},
    'মার্চ': {'বাংলা': 'মার্চ', 'English': 'March'},
    'এপ্রিল': {'বাংলা': 'এপ্রিল', 'English': 'April'},
    'মে': {'বাংলা': 'মে', 'English': 'May'},
    'জুন': {'বাংলা': 'জুন', 'English': 'June'},
    'জুলাই': {'বাংলা': 'জুলাই', 'English': 'July'},
    'আগস্ট': {'বাংলা': 'আগস্ট', 'English': 'August'},
    'সেপ্টেম্বর': {'বাংলা': 'সেপ্টেম্বর', 'English': 'September'},
    'অক্টোবর': {'বাংলা': 'অক্টোবর', 'English': 'October'},
    'নভেম্বর': {'বাংলা': 'নভেম্বর', 'English': 'November'},
    'ডিসেম্বর': {'বাংলা': 'ডিসেম্বর', 'English': 'December'},

    // Banner
    '"নিরাপদ হোক প্রতিটি প্রসব, যত্নে থাকুক মা ও নবজাতক"': {'বাংলা': '"নিরাপদ হোক প্রতিটি প্রসব, যত্নে থাকুক মা ও নবজাতক"', 'English': '"Safe every delivery, caring for mother & newborn"'},
    'একনজরে দেখুন →': {'বাংলা': 'একনজরে দেখুন →', 'English': 'Quick Overview →'},

    // Profile sheet & menu
    'অ্যাপ সম্পর্কে': {'বাংলা': 'অ্যাপ সম্পর্কে', 'English': 'About App'},

    // Tracker sheet
    'সকল ট্র্যাকার সমূহ': {'বাংলা': 'সকল ট্র্যাকার সমূহ', 'English': 'All Trackers'},
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
    'week_gestation': {'বাংলা': 'সপ্তাহের গর্ভাবস্থা', 'English': 'Weeks Gestation'},
    'days_left': {'বাংলা': 'দিন বাকি', 'English': 'Days Left'},
    'baby_size': {'বাংলা': 'শিশুর সম্ভাব্য আকার:', 'English': 'Estimated Baby Size:'},
    'weight': {'বাংলা': 'ওজন:', 'English': 'Weight:'},
    'তাসনিয়া রহমান': {'বাংলা': 'তাসনিয়া রহমান', 'English': 'Tasnia Rahman'},

    // Dashboard Section Titles
    'শিশু ও মায়ের তথ্য': {'বাংলা': 'শিশু ও মায়ের তথ্য', 'English': 'Baby & Mother Info'},
    'গর্ভবতী সেবা': {'বাংলা': 'গর্ভবতী সেবা', 'English': 'Pregnancy Care'},
    'স্বাস্থ্য ও জটিলতা': {'বাংলা': 'স্বাস্থ্য ও জটিলতা', 'English': 'Health & Complications'},
    'ANC ও PNC সেবা': {'বাংলা': 'ANC ও PNC সেবা', 'English': 'ANC & PNC Care'},
    'জরুরি সেবা': {'বাংলা': 'জরুরি সেবা', 'English': 'Emergency Services'},
    'নবজাতকের সেবা': {'বাংলা': 'নবজাতকের সেবা', 'English': 'Newborn Care'},
    'স্বাস্থ্য টুলস': {'বাংলা': 'স্বাস্থ্য টুলস', 'English': 'Health Tools'},

    // Dashboard Card Titles
    'প্রতিদিনের টিপস': {'বাংলা': 'প্রতিদিনের টিপস', 'English': 'Daily Tips'},
    'দৈনিক স্বাস্থ্য টিপস ও পরামর্শ': {'বাংলা': 'দৈনিক স্বাস্থ্য টিপস ও পরামর্শ', 'English': 'Daily health tips & advice'},
    'গর্ভের শিশুর অবস্থা': {'বাংলা': 'গর্ভের শিশুর অবস্থা', 'English': 'Fetal Status'},
    'শিশু 3D ছবি, দৈর্ঘ্য, ওজন, ধাপ': {'বাংলা': 'শিশু 3D ছবি, দৈর্ঘ্য, ওজন, ধাপ', 'English': 'Baby 3D image, length, weight, stage'},
    'মায়ের স্বাস্থ্য': {'বাংলা': 'মায়ের স্বাস্থ্য', 'English': "Mother's Health"},
    'মায়ের বিস্তারিত অবস্থা ও সমস্যা': {'বাংলা': 'মায়ের বিস্তারিত অবস্থা ও সমস্যা', 'English': "Mother's detailed condition & issues"},
    'বাবার করণীয়': {'বাংলা': 'বাবার করণীয়', 'English': "Father's Duties"},
    'বাবার দায়িত্ব ও কর্তব্য': {'বাংলা': 'বাবার দায়িত্ব ও কর্তব্য', 'English': "Father's responsibilities"},
    'গর্ভবতী নিবন্ধন': {'বাংলা': 'গর্ভবতী নিবন্ধন', 'English': 'Pregnancy Registration'},
    'সেবা কার্ড ও নিবন্ধন': {'বাংলা': 'সেবা কার্ড ও নিবন্ধন', 'English': 'Care card & registration'},
    'খাদ্য তালিকা ও পুষ্টি': {'বাংলা': 'খাদ্য তালিকা ও পুষ্টি', 'English': 'Diet & Nutrition'},
    'পুষ্টিকর খাদ্য পরিকল্পনা': {'বাংলা': 'পুষ্টিকর খাদ্য পরিকল্পনা', 'English': 'Nutritious diet plan'},
    'গর্ভকালীন স্বাস্থ্য সমস্যা ও সমাধান': {'বাংলা': 'গর্ভকালীন স্বাস্থ্য সমস্যা ও সমাধান', 'English': 'Pregnancy Health Issues & Solutions'},
    'সকল গর্ভকালীন জটিলতা ও পরামর্শ': {'বাংলা': 'সকল গর্ভকালীন জটিলতা ও পরামর্শ', 'English': 'All pregnancy complications & advice'},
    'সাধারণ সমস্যা ও সমাধান': {'বাংলা': 'সাধারণ সমস্যা ও সমাধান', 'English': 'Common Problems & Solutions'},
    'জরুরি স্বাস্থ্য তথ্য': {'বাংলা': 'জরুরি স্বাস্থ্য তথ্য', 'English': 'Emergency health info'},
    'গর্ভকালীন জটিলতা ও করণীয়': {'বাংলা': 'গর্ভকালীন জটিলতা ও করণীয়', 'English': 'Pregnancy Complications & Actions'},
    'জরুরি পদক্ষেপ': {'বাংলা': 'জরুরি পদক্ষেপ', 'English': 'Emergency steps'},
    'ওষুধ, চিকিৎসা ও পরীক্ষা': {'বাংলা': 'ওষুধ, চিকিৎসা ও পরীক্ষা', 'English': 'Medicine, Treatment & Tests'},
    'ল্যাব রিপোর্ট ও পরীক্ষার ফলাফল বিশ্লেষণ': {'বাংলা': 'ল্যাব রিপোর্ট ও পরীক্ষার ফলাফল বিশ্লেষণ', 'English': 'Lab reports & test result analysis'},
    'প্রসবপূর্ব (ANC) সেবা আপডেট': {'বাংলা': 'প্রসবপূর্ব (ANC) সেবা আপডেট', 'English': 'Antenatal (ANC) Care Update'},
    'গর্ভকালীন সেবা ও করণীয়': {'বাংলা': 'গর্ভকালীন সেবা ও করণীয়', 'English': 'Pregnancy Care & Duties'},
    'প্রসব পরবর্তী (PNC) সেবা আপডেট': {'বাংলা': 'প্রসব পরবর্তী (PNC) সেবা আপডেট', 'English': 'Postnatal (PNC) Care Update'},
    'রক্তদাতা': {'বাংলা': 'রক্তদাতা', 'English': 'Blood Donor'},
    'জরুরি যোগাযোগ নম্বর': {'বাংলা': 'জরুরি যোগাযোগ নম্বর', 'English': 'Emergency Contact Numbers'},
    'স্বাস্থ্যকেন্দ্র/হাসপাতাল': {'বাংলা': 'স্বাস্থ্যকেন্দ্র/হাসপাতাল', 'English': 'Health Center/Hospital'},
    'নবজাতকের যত্ন ও পুষ্টি': {'বাংলা': 'নবজাতকের যত্ন ও পুষ্টি', 'English': 'Newborn Care & Nutrition'},
    'টিকা': {'বাংলা': 'টিকা', 'English': 'Vaccination'},
    'শিশুর খাদ্য তালিকা': {'বাংলা': 'শিশুর খাদ্য তালিকা', 'English': 'Baby Diet Chart'},
    'গর্ভের শিশুর নড়াচড়া': {'বাংলা': 'গর্ভের শিশুর নড়াচড়া', 'English': 'Fetal Movement'},
    'Kegel ব্যায়াম': {'বাংলা': 'Kegel ব্যায়াম', 'English': 'Kegel Exercises'},
    'BMI Calculator': {'বাংলা': 'BMI Calculator', 'English': 'BMI Calculator'},
    'GMP চার্ট': {'বাংলা': 'GMP চার্ট', 'English': 'GMP Chart'},
    'শিশুর বৃদ্ধির মনিটরিং চার্ট (Growth Monitoring Programme)': {'বাংলা': 'শিশুর বৃদ্ধির মনিটরিং চার্ট (Growth Monitoring Programme)', 'English': 'Baby Growth Monitoring Chart (GMP)'},

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
      'English': "Track your baby's movement and keep daily health updates."
    },
    'description_doctor': {
      'বাংলা': 'বিশেষজ্ঞ গাইনী ডাক্তারের সাথে অনলাইনে পরামর্শ ও অ্যাপয়েন্টমেন্ট নিন।',
      'English': 'Consult online & book appointments with expert gynecologists.'
    },
    'description_nutrition': {
      'বাংলা': 'গর্ভাবস্থার সঠিক খাদ্য তালিকা, রেসিপি এবং পানি পান ট্র্যাকিং।',
      'English': 'Pregnancy meal plans, recipes, and water intake tracker.'
    },
    'description_weeklyUpdate': {
      'বাংলা': 'আপনার শিশুর আকার, ওজন এবং প্রতি সপ্তাহের নতুন পরিবর্তন জানুন।',
      'English': "Learn your baby's size, weight, and changes week-by-week."
    },
    'description_reminders': {
      'বাংলা': 'শিশুর সকল সরকারি ও বেসরকারি টিকার সঠিক সময়সূচি ও বিবরণ।',
      'English': 'Accurate schedules & details of government & private child vaccines.'
    },
    'description_deliveryPrep': {
      'বাংলা': 'হাসপাতাল চেকলিস্ট, লেবার পেইন ট্র্যাকার ও দরকারি নির্দেশিকা।',
      'English': 'Hospital checklist, labor contraction tracker, & guides.'
    },

    // Baby Food Screen
    'সঠিক পুষ্টি শিশুর মস্তিষ্ক ও শরীরের বিকাশ নিশ্চিত করে। বয়স অনুযায়ী সঠিক খাবার দিন।': {
      'বাংলা': 'সঠিক পুষ্টি শিশুর মস্তিষ্ক ও শরীরের বিকাশ নিশ্চিত করে। বয়স অনুযায়ী সঠিক খাবার দিন।',
      'English': 'Proper nutrition ensures brain and physical development. Give age-appropriate food.'
    },
    '০–৬ মাস': {'বাংলা': '০–৬ মাস', 'English': '0–6 Months'},
    'শুধুমাত্র বুকের দুধ': {'বাংলা': 'শুধুমাত্র বুকের দুধ', 'English': 'Only Breast Milk'},
    'শুধু বুকের দুধ': {'বাংলা': 'শুধু বুকের দুধ', 'English': 'Only breast milk'},
    'কোনো পানি বা অন্য খাবার নয়': {'বাংলা': 'কোনো পানি বা অন্য খাবার নয়', 'English': 'No water or other foods'},
    'চাহিদামতো দুধ দিন': {'বাংলা': 'চাহিদামতো দুধ দিন', 'English': 'Feed milk on demand'},
    '১ ঘণ্টার মধ্যে বুকের দুধ শুরু করুন।': {'বাংলা': '১ ঘণ্টার মধ্যে বুকের দুধ শুরু করুন।', 'English': 'Start breast milk within 1 hour.'},
    
    '৬–৮ মাস': {'বাংলা': '৬–৮ মাস', 'English': '6–8 Months'},
    'পরিপূরক খাবার শুরু': {'বাংলা': 'পরিপূরক খাবার শুরু', 'English': 'Start Complementary Foods'},
    'নরম খিচুড়ি (চাল+ডাল+সবজি+তেল)': {'বাংলা': 'নরম খিচুড়ি (চাল+ডাল+সবজি+তেল)', 'English': 'Soft khichuri (rice+dal+veg+oil)'},
    'কলা, পেঁপে, আম': {'বাংলা': 'কলা, পেঁপে, আম', 'English': 'Banana, papaya, mango'},
    'নরম সুজি বা চালের পায়েস': {'বাংলা': 'নরম সুজি বা চালের পায়েস', 'English': 'Soft semolina or rice pudding'},
    'বুকের দুধ চালু রাখুন': {'বাংলা': 'বুকের দুধ চালু রাখুন', 'English': 'Continue breast milk'},
    'প্রথমে ২ চামচ দিয়ে শুরু করুন, ধীরে ধীরে বাড়ান।': {'বাংলা': 'প্রথমে ২ চামচ দিয়ে শুরু করুন, ধীরে ধীরে বাড়ান।', 'English': 'Start with 2 spoons, gradually increase.'},
    
    '৯–১১ মাস': {'বাংলা': '৯–১১ মাস', 'English': '9–11 Months'},
    'বৈচিত্র্যময় খাবার': {'বাংলা': 'বৈচিত্র্যময় খাবার', 'English': 'Diverse Foods'},
    'ভাত + ডাল + মাছ/মুরগি': {'বাংলা': 'ভাত + ডাল + মাছ/মুরগি', 'English': 'Rice + dal + fish/chicken'},
    'নরম আলু, গাজর, কুমড়া': {'বাংলা': 'নরম আলু, গাজর, কুমড়া', 'English': 'Soft potato, carrot, pumpkin'},
    'দই, পনির': {'বাংলা': 'দই, পনির', 'English': 'Yogurt, cheese'},
    'ছোট ছোট করে কাটা ফল': {'বাংলা': 'ছোট ছোট করে কাটা ফল', 'English': 'Finely chopped fruits'},
    'দিনে ৩ বেলা + ২ বার স্ন্যাকস।': {'বাংলা': 'দিনে ৩ বেলা + ২ বার স্ন্যাকস।', 'English': '3 meals a day + 2 snacks.'},
    
    '১২–২৪ মাস': {'বাংলা': '১২–২৪ মাস', 'English': '12–24 Months'},
    'পারিবারিক খাবার': {'বাংলা': 'পারিবারিক খাবার', 'English': 'Family Food'},
    'পরিবারের মতো খাবার (কম মশলা)': {'বাংলা': 'পরিবারের মতো খাবার (কম মশলা)', 'English': 'Family food (less spicy)'},
    'দুধ চালু রাখুন': {'বাংলা': 'দুধ চালু রাখুন', 'English': 'Continue milk'},
    'সব ধরনের সবজি ও ফল': {'বাংলা': 'সব ধরনের সবজি ও ফল', 'English': 'All types of veg and fruits'},
    'ডিম, মাছ, মুরগি নিয়মিত': {'বাংলা': 'ডিম, মাছ, মুরগি নিয়মিত', 'English': 'Egg, fish, chicken regularly'},
    'দিনে ৩ বেলা খাবার + ২–৩ বার স্ন্যাকস।': {'বাংলা': 'দিনে ৩ বেলা খাবার + ২–৩ বার স্ন্যাকস।', 'English': '3 meals a day + 2-3 snacks.'},
    
    '✅ সুষম পুষ্টির ৫টি নিয়ম': {'বাংলা': '✅ সুষম পুষ্টির ৫টি নিয়ম', 'English': '✅ 5 Rules of Balanced Nutrition'},
    'প্রতিবেলা শক্তি (ভাত/রুটি) + প্রোটিন (মাছ/ডাল) + সবজি দিন': {'বাংলা': 'প্রতিবেলা শক্তি (ভাত/রুটি) + প্রোটিন (মাছ/ডাল) + সবজি দিন', 'English': 'Energy (rice/roti) + Protein (fish/dal) + Veg in every meal'},
    'রঙিন সবজি ও ফল নিয়মিত দিন': {'বাংলা': 'রঙিন সবজি ও ফল নিয়মিত দিন', 'English': 'Give colorful veg & fruits regularly'},
    'পর্যাপ্ত পানি ও তরল খাবার দিন': {'বাংলা': 'পর্যাপ্ত পানি ও তরল খাবার দিন', 'English': 'Give adequate water & liquid food'},
    'বাজারের প্যাকেট খাবার এড়িয়ে চলুন': {'বাংলা': 'বাজারের প্যাকেট খাবার এড়িয়ে চলুন', 'English': 'Avoid packaged foods from market'},
    'খাবার সময় জোর করবেন না — শিশুর ক্ষুধার সংকেত দেখুন': {'বাংলা': 'খাবার সময় জোর করবেন না — শিশুর ক্ষুধার সংকেত দেখুন', 'English': 'Don\'t force feed — watch for baby\'s hunger cues'},

    // ANC Screen
    'আপনার গর্ভকালীন স্বাস্থ্যের ৪টি গুরুত্বপূর্ণ ধাপ': {
      'বাংলা': 'আপনার গর্ভকালীন স্বাস্থ্যের ৪টি গুরুত্বপূর্ণ ধাপ',
      'English': '4 Important steps of your maternal health'
    },
    'আপনার গর্ভাবস্থার যত্নের ৪টি গুরুত্বপূর্ণ ধাপ': {
      'বাংলা': 'আপনার গর্ভাবস্থার যত্নের ৪টি গুরুত্বপূর্ণ ধাপ',
      'English': '4 Important steps of your pregnancy care'
    },
    'ঠিক আছে': {'বাংলা': 'ঠিক আছে', 'English': 'OK'},
    'পরবর্তী ধাপ': {'বাংলা': 'পরবর্তী ধাপ', 'English': 'Next Step'},
    'প্রথম ভিজিট': {'বাংলা': 'প্রথম ভিজিট', 'English': 'First Visit'},
    '১২ সপ্তাহ বা তার আগে': {'বাংলা': '১২ সপ্তাহ বা তার আগে', 'English': '12 weeks or before'},
    'প্রথম ত্রৈমাসিক': {'বাংলা': 'প্রথম ত্রৈমাসিক', 'English': 'First Trimester'},
    'গর্ভাবস্থা নিশ্চিত করা, প্রসবের সম্ভাব্য তারিখ নির্ধারণ এবং আপনার স্বাস্থ্যের প্রাথমিক মূল্যায়ন।': {
      'বাংলা': 'গর্ভাবস্থা নিশ্চিত করা, প্রসবের সম্ভাব্য তারিখ নির্ধারণ এবং আপনার স্বাস্থ্যের প্রাথমিক মূল্যায়ন।',
      'English': 'Confirm pregnancy, determine estimated delivery date, and initial health assessment.'
    },
    'শারীরিক পরীক্ষা': {'বাংলা': 'শারীরিক পরীক্ষা', 'English': 'Physical Examination'},
    'রক্তচাপ পরিমাপ': {'বাংলা': 'রক্তচাপ পরিমাপ', 'English': 'Blood Pressure Check'},
    'রক্ত ও প্রস্রাব পরীক্ষা (যেমন: রক্তের গ্রুপ, অ্যানিমিয়া, এইচআইভি এবং সংক্রমণ)': {
      'বাংলা': 'রক্ত ও প্রস্রাব পরীক্ষা (যেমন: রক্তের গ্রুপ, অ্যানিমিয়া, এইচআইভি এবং সংক্রমণ)',
      'English': 'Blood & urine test (e.g. Blood Group, Anemia, HIV and infections)'
    },
    
    'দ্বিতীয় ভিজিট': {'বাংলা': 'দ্বিতীয় ভিজিট', 'English': 'Second Visit'},
    '২০ থেকে ২৪ সপ্তাহ': {'বাংলা': '২০ থেকে ২৪ সপ্তাহ', 'English': '20 to 24 weeks'},
    'দ্বিতীয় ত্রৈমাসিক': {'বাংলা': 'দ্বিতীয় ত্রৈমাসিক', 'English': 'Second Trimester'},
    'গর্ভের শিশুর বৃদ্ধি ও বিকাশ পর্যবেক্ষণ করা।': {
      'বাংলা': 'গর্ভের শিশুর বৃদ্ধি ও বিকাশ পর্যবেক্ষণ করা।',
      'English': 'Monitor growth and development of the fetus.'
    },
    'আল্ট্রাসাউন্ড স্ক্যান (সাধারণত ডিটেইলড অ্যানোমালি স্ক্যান)': {
      'বাংলা': 'আল্ট্রাসাউন্ড স্ক্যান (সাধারণত ডিটেইলড অ্যানোমালি স্ক্যান)',
      'English': 'Ultrasound Scan (usually detailed anomaly scan)'
    },
    'ভ্রূণের হৃদস্পন্দন পরীক্ষা': {'বাংলা': 'ভ্রূণের হৃদস্পন্দন পরীক্ষা', 'English': 'Fetal heart rate check'},
    'ফান্ডাল হাইট মাপা (পেটের উচ্চতা)': {'বাংলা': 'ফান্ডাল হাইট মাপা (পেটের উচ্চতা)', 'English': 'Measure fundal height'},

    'তৃতীয় ভিজিট': {'বাংলা': 'তৃতীয় ভিজিট', 'English': 'Third Visit'},
    '২৮ থেকে ৩২ সপ্তাহ': {'বাংলা': '২৮ থেকে ৩২ সপ্তাহ', 'English': '28 to 32 weeks'},
    'পরবর্তী সময়ের জটিলতা যেমন প্রি-এক্লাম্পসিয়া বা জেস্টেশনাল ডায়াবেটিসের জন্য স্ক্রিনিং করা।': {
      'বাংলা': 'পরবর্তী সময়ের জটিলতা যেমন প্রি-এক্লাম্পসিয়া বা জেস্টেশনাল ডায়াবেটিসের জন্য স্ক্রিনিং করা।',
      'English': 'Screening for late complications like pre-eclampsia or gestational diabetes.'
    },
    'রক্তচাপ পরীক্ষা': {'বাংলা': 'রক্তচাপ পরীক্ষা', 'English': 'Blood Pressure Check'},
    'প্রস্রাব পরীক্ষা': {'বাংলা': 'প্রস্রাব পরীক্ষা', 'English': 'Urine Test'},
    'অ্যানিমিয়ার জন্য পুনরায় রক্ত পরীক্ষা': {'বাংলা': 'অ্যানিমিয়ার জন্য পুনরায় রক্ত পরীক্ষা', 'English': 'Repeat blood test for anemia'},

    'চতুর্থ ভিজিট': {'বাংলা': 'চতুর্থ ভিজিট', 'English': 'Fourth Visit'},
    '৩৬ সপ্তাহ থেকে প্রসব পর্যন্ত': {'বাংলা': '৩৬ সপ্তাহ থেকে প্রসব পর্যন্ত', 'English': '36 weeks till delivery'},
    'প্রসবের জন্য প্রস্তুতি নেওয়া এবং শিশুর অবস্থান (মাথা নিচে) নিশ্চিত করা।': {
      'বাংলা': 'প্রসবের জন্য প্রস্তুতি নেওয়া এবং শিশুর অবস্থান (মাথা নিচে) নিশ্চিত করা।',
      'English': 'Prepare for delivery and ensure baby\'s position (head down).'
    },
    'শিশুর অবস্থান নিশ্চিত করা': {'বাংলা': 'শিশুর অবস্থান নিশ্চিত করা', 'English': 'Ensure baby\'s position'},
    'আপনার প্রসব পরিকল্পনা নিয়ে আলোচনা': {'বাংলা': 'আপনার প্রসব পরিকল্পনা নিয়ে আলোচনা', 'English': 'Discuss your delivery plan'},
    'প্রসবের লক্ষণগুলো সম্পর্কে পর্যালোচনা': {'বাংলা': 'প্রসবের লক্ষণগুলো সম্পর্কে পর্যালোচনা', 'English': 'Review signs of labor'},

    'লক্ষ্য': {'বাংলা': 'লক্ষ্য', 'English': 'Goal'},
    'মূল কার্যক্রম': {'বাংলা': 'মূল কার্যক্রম', 'English': 'Key Activities'},

    // Newborn Care Screen
    'যত্ন': {'বাংলা': 'যত্ন', 'English': 'Care'},
    'পুষ্টি': {'বাংলা': 'পুষ্টি', 'English': 'Nutrition'},
    'বিপদ চিহ্ন': {'বাংলা': 'বিপদ চিহ্ন', 'English': 'Danger Signs'},
    
    'শরীরের তাপমাত্রা রক্ষা': {'বাংলা': 'শরীরের তাপমাত্রা রক্ষা', 'English': 'Maintain Body Temperature'},
    'নবজাতককে সবসময় উষ্ণ রাখুন। ঠান্ডা বাতাস থেকে দূরে রাখুন। কানুরু কেয়ার (মা বা বাবার বুকে রেখে উষ্ণ রাখা) অত্যন্ত কার্যকর।': {
      'বাংলা': 'নবজাতককে সবসময় উষ্ণ রাখুন। ঠান্ডা বাতাস থেকে দূরে রাখুন। কানুরু কেয়ার (মা বা বাবার বুকে রেখে উষ্ণ রাখা) অত্যন্ত কার্যকর।',
      'English': 'Keep newborn warm always. Avoid cold wind. Kangaroo Mother Care is highly effective.'
    },
    'গোসল ও পরিষ্কার': {'বাংলা': 'গোসল ও পরিষ্কার', 'English': 'Bathing & Hygiene'},
    'নাভি পড়ে যাওয়ার আগে ভেজা কাপড় দিয়ে মুছে দিন। গোসল সপ্তাহে ২–৩ বার দিলেই চলে। নাভির গোড়া পরিষ্কার ও শুকনো রাখুন।': {
      'বাংলা': 'নাভি পড়ে যাওয়ার আগে ভেজা কাপড় দিয়ে মুছে দিন। গোসল সপ্তাহে ২–৩ বার দিলেই চলে। নাভির গোড়া পরিষ্কার ও শুকনো রাখুন।',
      'English': 'Sponge bath before umbilical cord falls off. Bathing 2-3 times a week is enough. Keep cord base clean and dry.'
    },
    'ঘুম ও বিশ্রাম': {'বাংলা': 'ঘুম ও বিশ্রাম', 'English': 'Sleep & Rest'},
    'নবজাতক দিনে ১৬–১৮ ঘণ্টা ঘুমায়। শিশুকে চিৎ করে শুয়ে দিন। বালিশ বা নরম কম্বল এড়িয়ে চলুন (SIDS ঝুঁকি)।': {
      'বাংলা': 'নবজাতক দিনে ১৬–১৮ ঘণ্টা ঘুমায়। শিশুকে চিৎ করে শুয়ে দিন। বালিশ বা নরম কম্বল এড়িয়ে চলুন (SIDS ঝুঁকি)।',
      'English': 'Newborn sleeps 16-18 hrs a day. Put baby on their back to sleep. Avoid pillows or soft blankets.'
    },
    'চোখের যত্ন': {'বাংলা': 'চোখের যত্ন', 'English': 'Eye Care'},
    'চোখ পরিষ্কার তুলো বা নরম কাপড় দিয়ে মুছুন। যদি লাল বা পুঁজ হয় তাহলে ডাক্তার দেখান।': {
      'বাংলা': 'চোখ পরিষ্কার তুলো বা নরম কাপড় দিয়ে মুছুন। যদি লাল বা পুঁজ হয় তাহলে ডাক্তার দেখান।',
      'English': 'Wipe eyes with clean cotton or soft cloth. See doctor if red or pus.'
    },
    'শ্রবণ পরীক্ষা': {'বাংলা': 'শ্রবণ পরীক্ষা', 'English': 'Hearing Test'},
    'জন্মের ১ মাসের মধ্যে শিশুর শ্রবণ পরীক্ষা করুন। উচ্চ শব্দে সাড়া না দিলে বিশেষজ্ঞ দেখান।': {
      'বাংলা': 'জন্মের ১ মাসের মধ্যে শিশুর শ্রবণ পরীক্ষা করুন। উচ্চ শব্দে সাড়া না দিলে বিশেষজ্ঞ দেখান।',
      'English': 'Test baby\'s hearing within 1 month of birth. See specialist if no response to loud sounds.'
    },

    '🤱 প্রথম ৬ মাস': {'বাংলা': '🤱 প্রথম ৬ মাস', 'English': '🤱 First 6 Months'},
    'শুধুমাত্র বুকের দুধ\n\nবুকের দুধ শিশুর সকল পুষ্টির চাহিদা পূরণ করে — পানি, ভিটামিন, মিনারেল সবকিছু। কোনো অতিরিক্ত পানি বা খাবার দেবেন না।': {
      'বাংলা': 'শুধুমাত্র বুকের দুধ\n\nবুকের দুধ শিশুর সকল পুষ্টির চাহিদা পূরণ করে — পানি, ভিটামিন, মিনারেল সবকিছু। কোনো অতিরিক্ত পানি বা খাবার দেবেন না।',
      'English': 'Only Breast Milk\n\nBreast milk fulfills all nutritional needs — water, vitamins, minerals. Do not give extra water or food.'
    },
    '🥣 ৬ মাস পর থেকে': {'বাংলা': '🥣 ৬ মাস পর থেকে', 'English': '🥣 After 6 Months'},
    'বুকের দুধের পাশাপাশি পরিপূরক খাবার\n\n• খিচুড়ি (চাল + ডাল + সবজি + তেল)\n• নরম ভাত\n• ফল: কলা, পেঁপে, আম\n• দিনে ২–৩ বার ছোট ছোট পরিমাণে': {
      'বাংলা': 'বুকের দুধের পাশাপাশি পরিপূরক খাবার\n\n• খিচুড়ি (চাল + ডাল + সবজি + তেল)\n• নরম ভাত\n• ফল: কলা, পেঁপে, আম\n• দিনে ২–৩ বার ছোট ছোট পরিমাণে',
      'English': 'Complementary food along with breast milk\n\n• Khichuri (rice + dal + veg + oil)\n• Soft rice\n• Fruits: banana, papaya, mango\n• Small amounts 2-3 times a day'
    },
    '⚠️ কী এড়াবেন': {'বাংলা': '⚠️ কী এড়াবেন', 'English': '⚠️ What to Avoid'},
    '• ১ বছরের আগে গরুর দুধ নয়\n• মধু নয় (botulism ঝুঁকি)\n• বাজারের প্যাকেট খাবার এড়িয়ে চলুন\n• অতিরিক্ত লবণ ও চিনি নয়': {
      'বাংলা': '• ১ বছরের আগে গরুর দুধ নয়\n• মধু নয় (botulism ঝুঁকি)\n• বাজারের প্যাকেট খাবার এড়িয়ে চলুন\n• অতিরিক্ত লবণ ও চিনি নয়',
      'English': '• No cow\'s milk before 1 year\n• No honey (botulism risk)\n• Avoid packaged food\n• No extra salt & sugar'
    },

    'এই লক্ষণগুলো দেখলে তাৎক্ষণিক হাসপাতালে যান': {'বাংলা': 'এই লক্ষণগুলো দেখলে তাৎক্ষণিক হাসপাতালে যান', 'English': 'Go to hospital immediately if you see these signs'},
    'শ্বাস-প্রশ্বাস দ্রুত বা কঠিন হওয়া': {'বাংলা': 'শ্বাস-প্রশ্বাস দ্রুত বা কঠিন হওয়া', 'English': 'Fast or difficult breathing'},
    'শরীর হলুদ হয়ে যাওয়া (জন্ডিস) — জন্মের ২৪ ঘণ্টার মধ্যে': {'বাংলা': 'শরীর হলুদ হয়ে যাওয়া (জন্ডিস) — জন্মের ২৪ ঘণ্টার মধ্যে', 'English': 'Body turning yellow (Jaundice) — within 24 hours of birth'},
    'নাভি থেকে পুঁজ বা দুর্গন্ধ': {'বাংলা': 'নাভি থেকে পুঁজ বা দুর্গন্ধ', 'English': 'Pus or bad smell from umbilical cord'},
    'খাওয়া একদম বন্ধ করে দেওয়া': {'বাংলা': 'খাওয়া একদম বন্ধ করে দেওয়া', 'English': 'Stopped feeding completely'},
    'শরীর ঠান্ডা বা অস্বাভাবিক নীল হওয়া': {'বাংলা': 'শরীর ঠান্ডা বা অস্বাভাবিক নীল হওয়া', 'English': 'Body cold or abnormally blue'},
    'খিঁচুনি': {'বাংলা': 'খিঁচুনি', 'English': 'Convulsion'},
    '৩৮°C-এর বেশি জ্বর': {'বাংলা': '৩৮°C-এর বেশি জ্বর', 'English': 'Fever above 38°C'},
    'ডায়রিয়া বা বমি বারবার হওয়া': {'বাংলা': 'ডায়রিয়া বা বমি বারবার হওয়া', 'English': 'Repeated diarrhea or vomiting'},
    'অস্বাভাবিক কান্না বা একদম চুপ থাকা': {'বাংলা': 'অস্বাভাবিক কান্না বা একদম চুপ থাকা', 'English': 'Abnormal crying or completely quiet'},
    '📞 জরুরি হেল্পলাইন: ১৬০০০': {'বাংলা': '📞 জরুরি হেল্পলাইন: ১৬০০০', 'English': '📞 Emergency Helpline: 16000'},

    // Mayer Shastho Screen
    'বডি ট্র্যাকার': {'বাংলা': 'বডি ট্র্যাকার', 'English': 'Body Tracker'},
    'মুড ট্র্যাকার': {'বাংলা': 'মুড ট্র্যাকার', 'English': 'Mood Tracker'},
    'ভাইটালস': {'বাংলা': 'ভাইটালস', 'English': 'Vitals'},
    'ওষুধ': {'বাংলা': 'ওষুধ', 'English': 'Medication'},
    'মাসিক ওজন ট্র্যাকার': {'বাংলা': 'মাসিক ওজন ট্র্যাকার', 'English': 'Monthly Weight Tracker'},
    '১ম মাস': {'বাংলা': '১ম মাস', 'English': '1st Month'},
    '২য় মাস': {'বাংলা': '২য় মাস', 'English': '2nd Month'},
    '৩য় মাস': {'বাংলা': '৩য় মাস', 'English': '3rd Month'},
    '৪র্থ মাস': {'বাংলা': '৪র্থ মাস', 'English': '4th Month'},
    '৫ম মাস': {'বাংলা': '৫ম মাস', 'English': '5th Month'},
    '৫৫ কেজি': {'বাংলা': '৫৫ কেজি', 'English': '55 kg'},
    '৫৬.৫ কেজি': {'বাংলা': '৫৬.৫ কেজি', 'English': '56.5 kg'},
    '৫৮ কেজি': {'বাংলা': '৫৮ কেজি', 'English': '58 kg'},
    '৬০ কেজি': {'বাংলা': '৬০ কেজি', 'English': '60 kg'},
    '৬২.৫ কেজি': {'বাংলা': '৬২.৫ কেজি', 'English': '62.5 kg'},
    '+০': {'বাংলা': '+০', 'English': '+0'},
    '+১.৫': {'বাংলা': '+১.৫', 'English': '+1.5'},
    '+২': {'বাংলা': '+২', 'English': '+2'},
    '+২.৫': {'বাংলা': '+২.৫', 'English': '+2.5'},
    ' কেজি': {'বাংলা': ' কেজি', 'English': ' kg'},
    'আজকের ওজন যোগ করুন': {'বাংলা': 'আজকের ওজন যোগ করুন', 'English': 'Add Today\'s Weight'},
    'শরীরের পরিবর্তনসমূহ': {'বাংলা': 'শরীরের পরিবর্তনসমূহ', 'English': 'Body Changes'},
    'বমি বমি ভাব, ক্লান্তি, স্তন কোমলতা': {'বাংলা': 'বমি বমি ভাব, ক্লান্তি, স্তন কোমলতা', 'English': 'Nausea, fatigue, breast tenderness'},
    'পেট বড় হওয়া, শিশুর নড়াচড়া অনুভব': {'বাংলা': 'পেট বড় হওয়া, শিশুর নড়াচড়া অনুভব', 'English': 'Belly grows, feeling baby moves'},
    'পিঠে ব্যথা, ঘন ঘন প্রস্রাব, পা ফোলা': {'বাংলা': 'পিঠে ব্যথা, ঘন ঘন প্রস্রাব, পা ফোলা', 'English': 'Back pain, frequent urination, swollen feet'},
    'আজকের মানসিক অবস্থা': {'বাংলা': 'আজকের মানসিক অবস্থা', 'English': 'Today\'s Mood'},
    'ভালো': {'বাংলা': 'ভালো', 'English': 'Good'},
    'মোটামুটি': {'বাংলা': 'মোটামুটি', 'English': 'Okay'},
    'খারাপ': {'বাংলা': 'খারাপ', 'English': 'Bad'},
    'কান্না': {'বাংলা': 'কান্না', 'English': 'Crying'},
    'রাগী': {'বাংলা': 'রাগী', 'English': 'Angry'},
    'আপনার অনুভূতি রেকর্ড হয়েছে। মনে রাখবেন, আপনি একা নন।': {'বাংলা': 'আপনার অনুভূতি রেকর্ড হয়েছে। মনে রাখবেন, আপনি একা নন।', 'English': 'Your mood is recorded. Remember, you are not alone.'},
    'মন ভালো করার টিপস': {'বাংলা': 'মন ভালো করার টিপস', 'English': 'Tips to improve mood'},
    'গভীর শ্বাস-প্রশ্বাসের ব্যায়াম করুন — ৫ মিনিটেই মন শান্ত হবে': {'বাংলা': 'গভীর শ্বাস-প্রশ্বাসের ব্যায়াম করুন — ৫ মিনিটেই মন শান্ত হবে', 'English': 'Deep breathing exercise — calms mind in 5 mins'},
    'প্রিয় গান শুনুন বা হালকা মেডিটেশন সঙ্গীত ব্যবহার করুন': {'বাংলা': 'প্রিয় গান শুনুন বা হালকা মেডিটেশন সঙ্গীত ব্যবহার করুন', 'English': 'Listen to favorite songs or light meditation music'},
    'বাইরে হালকা হাঁটুন এবং তাজা বাতাস নিন': {'বাংলা': 'বাইরে হালকা হাঁটুন এবং তাজা বাতাস নিন', 'English': 'Walk outside lightly and get fresh air'},
    'পরিবার বা বন্ধুর সাথে মন খুলে কথা বলুন': {'বাংলা': 'পরিবার বা বন্ধুর সাথে মন খুলে কথা বলুন', 'English': 'Talk openly with family or friends'},
    'ডায়েরিতে আপনার অনুভূতি লিখে রাখুন': {'বাংলা': 'ডায়েরিতে আপনার অনুভূতি লিখে রাখুন', 'English': 'Write your feelings in a diary'},
    'পোস্টপার্টাম ডিপ্রেশন সম্পর্কে জানুন': {'বাংলা': 'পোস্টপার্টাম ডিপ্রেশন সম্পর্কে জানুন', 'English': 'Know about postpartum depression'},
    'সন্তান জন্মের পর বিষণ্নতা খুবই স্বাভাবিক। ২ সপ্তাহের বেশি কষ্ট থাকলে দ্রুত ডাক্তারের পরামর্শ নিন।': {'বাংলা': 'সন্তান জন্মের পর বিষণ্নতা খুবই স্বাভাবিক। ২ সপ্তাহের বেশি কষ্ট থাকলে দ্রুত ডাক্তারের পরামর্শ নিন।', 'English': 'Depression after childbirth is very normal. Consult doctor if lasts more than 2 weeks.'},
    'রক্তচাপ': {'বাংলা': 'রক্তচাপ', 'English': 'Blood Pressure'},
    'ব্লাড সুগার': {'বাংলা': 'ব্লাড সুগার', 'English': 'Blood Sugar'},
    'পালস রেট': {'বাংলা': 'পালস রেট', 'English': 'Pulse Rate'},
    'তাপমাত্রা': {'বাংলা': 'তাপমাত্রা', 'English': 'Temperature'},
    'ভাইটালস লগ ইতিহাস': {'বাংলা': 'ভাইটালস লগ ইতিহাস', 'English': 'Vitals Log History'},
    'আজ সকাল': {'বাংলা': 'আজ সকাল', 'English': 'Today Morning'},
    'গতকাল': {'বাংলা': 'গতকাল', 'English': 'Yesterday'},
    '২ দিন আগে': {'বাংলা': '২ দিন আগে', 'English': '2 Days Ago'},
    'নতুন রিডিং যোগ করুন': {'বাংলা': 'নতুন রিডিং যোগ করুন', 'English': 'Add New Reading'},
    'সতর্কতা': {'বাংলা': 'সতর্কতা', 'English': 'Warning'},
    'রক্তচাপ ১৪০/৯০ এর বেশি হলে অবিলম্বে ডাক্তারের সাথে যোগাযোগ করুন।': {'বাংলা': 'রক্তচাপ ১৪০/৯০ এর বেশি হলে অবিলম্বে ডাক্তারের সাথে যোগাযোগ করুন।', 'English': 'Contact doctor immediately if BP is above 140/90.'},
    'আজকের ওষুধের তালিকা': {'বাংলা': 'আজকের ওষুধের তালিকা', 'English': 'Today\'s Medicine List'},
    'আয়রন ট্যাবলেট': {'বাংলা': 'আয়রন ট্যাবলেট', 'English': 'Iron Tablet'},
    'ক্যালসিয়াম ট্যাবলেট': {'বাংলা': 'ক্যালসিয়াম ট্যাবলেট', 'English': 'Calcium Tablet'},
    'ফলিক অ্যাসিড': {'বাংলা': 'ফলিক অ্যাসিড', 'English': 'Folic Acid'},
    '১টি': {'বাংলা': '১টি', 'English': '1 piece'},
    'রাতে': {'বাংলা': 'রাতে', 'English': 'Night'},
    'দুপুরে': {'বাংলা': 'দুপুরে', 'English': 'Noon'},
    'সকালে': {'বাংলা': 'সকালে', 'English': 'Morning'},
    'নতুন ওষুধ যোগ করুন': {'বাংলা': 'নতুন ওষুধ যোগ করুন', 'English': 'Add New Medicine'},
    'রিমাইন্ডার সেটিংস': {'বাংলা': 'রিমাইন্ডার সেটিংস', 'English': 'Reminder Settings'},
    'সকাল ৮:০০': {'বাংলা': 'সকাল ৮:০০', 'English': 'Morning 8:00'},
    'দুপুর ২:০০': {'বাংলা': 'দুপুর ২:০০', 'English': 'Noon 2:00'},
    'রাত ১০:০০': {'বাংলা': 'রাত ১০:০০', 'English': 'Night 10:00'},
    'মনে রাখবেন': {'বাংলা': 'মনে রাখবেন', 'English': 'Remember'},
    'ডাক্তারের পরামর্শ ছাড়া কোনো ওষুধ বন্ধ করবেন না বা নতুন ওষুধ শুরু করবেন না।': {'বাংলা': 'ডাক্তারের পরামর্শ ছাড়া কোনো ওষুধ বন্ধ করবেন না বা নতুন ওষুধ শুরু করবেন না।', 'English': 'Don\'t stop or start any medicine without doctor\'s advice.'},
    'সম্পন্ন': {'বাংলা': 'সম্পন্ন', 'English': 'Done'},
    'বাকি': {'বাংলা': 'বাকি', 'English': 'Pending'},
    'ওজন যোগ করুন': {'বাংলা': 'ওজন যোগ করুন', 'English': 'Add Weight'},
    'কেজি': {'বাংলা': 'কেজি', 'English': 'Kg'},
    'বাতিল': {'বাংলা': 'বাতিল', 'English': 'Cancel'},
    'সংরক্ষণ': {'বাংলা': 'সংরক্ষণ', 'English': 'Save'},

    // Nutrition Screen
    'পুষ্টি ও যত্ন গাইড': {'বাংলা': 'পুষ্টি ও যত্ন গাইড', 'English': 'Nutrition & Care Guide'},
    'সুস্থ মা ও শিশুর পুষ্টিকর খাদ্যাভ্যাস': {'বাংলা': 'সুস্থ মা ও শিশুর পুষ্টিকর খাদ্যাভ্যাস', 'English': 'Nutritious diet for healthy mother & baby'},
    'আজকের': {'বাংলা': 'আজকের', 'English': 'Today\'s'},
    'পুষ্টি পরামর্শ': {'বাংলা': 'পুষ্টি পরামর্শ', 'English': 'Nutrition Advice'},
    'প্রতিদিনের খাদ্যতালিকায় সবুজ শাকসবজি, ফল ও ডাল রাখুন।': {'বাংলা': 'প্রতিদিনের খাদ্যতালিকায় সবুজ শাকসবজি, ফল ও ডাল রাখুন।', 'English': 'Keep green vegetables, fruits, and lentils in daily diet.'},
    'গর্ভবতীর\nডায়েট': {'বাংলা': 'গর্ভবতীর\nডায়েট', 'English': 'Pregnancy\nDiet'},
    'পানি\nরিমাইন্ডার': {'বাংলা': 'পানি\nরিমাইন্ডার', 'English': 'Water\nReminder'},
    'ব্যায়াম': {'বাংলা': 'ব্যায়াম', 'English': 'Exercise'},
    'ভিটামিন ও\nসাপ্লিমেন্ট': {'বাংলা': 'ভিটামিন ও\nসাপ্লিমেন্ট', 'English': 'Vitamin &\nSupplement'},
    'আজকের খাবারের পরিকল্পনা': {'বাংলা': 'আজকের খাবারের পরিকল্পনা', 'English': 'Today\'s Meal Plan'},
    'সকালের নাস্তা': {'বাংলা': 'সকালের নাস্তা', 'English': 'Breakfast'},
    'ওটস + ফল + দুধ': {'বাংলা': 'ওটস + ফল + দুধ', 'English': 'Oats + Fruits + Milk'},
    'দুপুরের খাবার': {'বাংলা': 'দুপুরের খাবার', 'English': 'Lunch'},
    'ভাত + ডাল + সবজি + সালাদ': {'বাংলা': 'ভাত + ডাল + সবজি + সালাদ', 'English': 'Rice + Lentils + Veg + Salad'},
    'দুপুর ১:৩০': {'বাংলা': 'দুপুর ১:৩০', 'English': 'Noon 1:30'},
    'রাতের খাবার': {'বাংলা': 'রাতের খাবার', 'English': 'Dinner'},
    'সুপ + সবজি + রুটি': {'বাংলা': 'সুপ + সবজি + রুটি', 'English': 'Soup + Veg + Roti'},
    'রাত ৮:৩০': {'বাংলা': 'রাত ৮:৩০', 'English': 'Night 8:30'},
    'পানি রিমাইন্ডার': {'বাংলা': 'পানি রিমাইন্ডার', 'English': 'Water Reminder'},
    ' / ৮ গ্লাস': {'বাংলা': ' / ৮ গ্লাস', 'English': ' / 8 Glasses'},
    'প্রতিটি গ্লাসে ট্যাপ করে আপনার আজকের পানি পানের হিসাব রাখুন': {'বাংলা': 'প্রতিটি গ্লাসে ট্যাপ করে আপনার আজকের পানি পানের হিসাব রাখুন', 'English': 'Tap each glass to keep track of your water intake today'},
    'গর্ভবতীর ডায়েট গাইড': {'বাংলা': 'গর্ভবতীর ডায়েট গাইড', 'English': 'Pregnancy Diet Guide'},
    '🥬 শাকসবজি ও ফলমূল': {'বাংলা': '🥬 শাকসবজি ও ফলমূল', 'English': '🥬 Vegetables & Fruits'},
    'আয়রন, ফলিক অ্যাসিড ও কোষ্ঠকাঠিন্য দূর করতে ফাইবার প্রদান করে।': {'বাংলা': 'আয়রন, ফলিক অ্যাসিড ও কোষ্ঠকাঠিন্য দূর করতে ফাইবার প্রদান করে।', 'English': 'Provides iron, folic acid, and fiber to relieve constipation.'},
    '🥛 দুধ ও ক্যালসিয়াম সমৃদ্ধ খাবার': {'বাংলা': '🥛 দুধ ও ক্যালসিয়াম সমৃদ্ধ খাবার', 'English': '🥛 Milk & Calcium-rich foods'},
    'শিশুর হাড় ও দাঁতের গঠন মজবুত করতে দিনে অন্তত ২ গ্লাস দুধ পান করুন।': {'বাংলা': 'শিশুর হাড় ও দাঁতের গঠন মজবুত করতে দিনে অন্তত ২ গ্লাস দুধ পান করুন।', 'English': 'Drink at least 2 glasses of milk daily to strengthen baby\'s bones and teeth.'},
    '🥚 ডিম ও মাছ/মাংস': {'বাংলা': '🥚 ডিম ও মাছ/মাংস', 'English': '🥚 Egg & Fish/Meat'},
    'উচ্চমানের প্রোটিন শিশুর পেশী গঠনে মুখ্য ভূমিকা রাখে।': {'বাংলা': 'উচ্চমানের প্রোটিন শিশুর পেশী গঠনে মুখ্য ভূমিকা রাখে।', 'English': 'High-quality protein plays a key role in baby\'s muscle formation.'},
    '🫘 ডাল ও লাল চাল': {'বাংলা': '🫘 ডাল ও লাল চাল', 'English': '🫘 Lentils & Red Rice'},
    'প্রয়োজনীয় কার্বোহাইড্রেট ও শক্তি সরবরাহ করে।': {'বাংলা': 'প্রয়োজনীয় কার্বোহাইড্রেট ও শক্তি সরবরাহ করে।', 'English': 'Provides necessary carbohydrates and energy.'},
    'পানি পান নির্দেশিকা': {'বাংলা': 'পানি পান নির্দেশিকা', 'English': 'Water Intake Guide'},
    '💧 কেন পানি প্রয়োজন?': {'বাংলা': '💧 কেন পানি প্রয়োজন?', 'English': '💧 Why is water needed?'},
    'গর্ভে পর্যাপ্ত অ্যামনিয়াটিক তরল বজায় রাখতে এবং ইউরিনারি ইনফেকশন (UTI) প্রতিরোধ করতে দিনে অন্তত ৮-১০ গ্লাস পানি আবশ্যক।': {'বাংলা': 'গর্ভে পর্যাপ্ত অ্যামনিয়াটিক তরল বজায় রাখতে এবং ইউরিনারি ইনফেকশন (UTI) প্রতিরোধ করতে দিনে অন্তত ৮-১০ গ্লাস পানি আবশ্যক।', 'English': 'At least 8-10 glasses of water daily are required to maintain amniotic fluid and prevent UTI.'},
    '🥤 ফলের রস ও ডাবের পানি': {'বাংলা': '🥤 ফলের রস ও ডাবের পানি', 'English': '🥤 Fruit juice & Coconut water'},
    'খাবার পানির পাশাপাশি ডাবের পানি বা তাজা ফলের রস গর্ভবতী মায়ের ক্লান্তি দূর করতে সহায়ক।': {'বাংলা': 'খাবার পানির পাশাপাশি ডাবের পানি বা তাজা ফলের রস গর্ভবতী মায়ের ক্লান্তি দূর করতে সহায়ক।', 'English': 'Along with drinking water, coconut water or fresh fruit juice helps relieve mother\'s fatigue.'},
    'গর্ভাবস্থায় নিরাপদ ব্যায়াম': {'বাংলা': 'গর্ভাবস্থায় নিরাপদ ব্যায়াম', 'English': 'Safe Exercise During Pregnancy'},
    '🚶‍♀️ হালকা হাঁটা': {'বাংলা': '🚶‍♀️ হালকা হাঁটা', 'English': '🚶‍♀️ Light walking'},
    'প্রতিদিন সকালে বা বিকেলে ১৫-২০ মিনিট ধীর গতিতে হাঁটা রক্ত সঞ্চালন স্বাভাবিক রাখে।': {'বাংলা': 'প্রতিদিন সকালে বা বিকেলে ১৫-২০ মিনিট ধীর গতিতে হাঁটা রক্ত সঞ্চালন স্বাভাবিক রাখে।', 'English': 'Walking slowly for 15-20 minutes daily keeps blood circulation normal.'},
    '🧘‍♀️ প্রেগন্যান্সি যোগব্যায়াম': {'বাংলা': '🧘‍♀️ প্রেগন্যান্সি যোগব্যায়াম', 'English': '🧘‍♀️ Pregnancy Yoga'},
    'পেশী শিথিল করতে ও প্রসববেদনা সহজ করতে নিরাপদ যোগাসন করুন।': {'বাংলা': 'পেশী শিথিল করতে ও প্রসববেদনা সহজ করতে নিরাপদ যোগাসন করুন।', 'English': 'Do safe yoga poses to relax muscles and ease labor pain.'},
    '💪 কেগেল ব্যায়াম': {'বাংলা': '💪 কেগেল ব্যায়াম', 'English': '💪 Kegel exercise'},
    'শ্রোণিদেশের পেশী মজবুত করতে অত্যন্ত সহায়ক।': {'বাংলা': 'শ্রোণিদেশের পেশী মজবুত করতে অত্যন্ত সহায়ক।', 'English': 'Very helpful for strengthening pelvic floor muscles.'},
    'ভিটামিন ও সাপ্লিমেন্ট': {'বাংলা': 'ভিটামিন ও সাপ্লিমেন্ট', 'English': 'Vitamins & Supplements'},
    '💊 ফলিক অ্যাসিড': {'বাংলা': '💊 ফলিক অ্যাসিড', 'English': '💊 Folic Acid'},
    'গর্ভাবস্থার প্রথম ১২ সপ্তাহ শিশুর মেরুদণ্ড ও মস্তিষ্কের ত্রুটি প্রতিরোধে অত্যন্ত জরুরি।': {'বাংলা': 'গর্ভাবস্থার প্রথম ১২ সপ্তাহ শিশুর মেরুদণ্ড ও মস্তিষ্কের ত্রুটি প্রতিরোধে অত্যন্ত জরুরি।', 'English': 'Very important in first 12 weeks to prevent spinal and brain defects.'},
    '🩸 আয়রন ও ফলিক ট্যাবলেট': {'বাংলা': '🩸 আয়রন ও ফলিক ট্যাবলেট', 'English': '🩸 Iron & Folic tablet'},
    'রক্তশূন্যতা দূর করতে প্রতিদিন চিকিৎসকের পরামর্শে আয়রন ক্যাপসুল গ্রহণ করুন।': {'বাংলা': 'রক্তশূন্যতা দূর করতে প্রতিদিন চিকিৎসকের পরামর্শে আয়রন ক্যাপসুল গ্রহণ করুন।', 'English': 'Take iron capsule daily with doctor\'s advice to prevent anemia.'},
    '🦴 ক্যালসিয়াম ও ভিটামিন ডি': {'বাংলা': '🦴 ক্যালসিয়াম ও ভিটামিন ডি', 'English': '🦴 Calcium & Vitamin D'},
    'দুগ্ধজাত খাবারের পাশাপাশি ক্যালসিয়াম সাপ্লিমেন্ট হাড়ের ক্ষয় রোধে আবশ্যক।': {'বাংলা': 'দুগ্ধজাত খাবারের পাশাপাশি ক্যালসিয়াম সাপ্লিমেন্ট হাড়ের ক্ষয় রোধে আবশ্যক।', 'English': 'Along with dairy foods, calcium supplement is essential to prevent bone loss.'},

    // Delivery Prep Screen
    'সময়মতো প্রস্তুত থাকুন': {'বাংলা': 'সময়মতো প্রস্তুত থাকুন', 'English': 'Be ready on time'},
    'চেকলিস্ট': {'বাংলা': 'চেকলিস্ট', 'English': 'Checklist'},
    'লেবার সাইন': {'বাংলা': 'লেবার সাইন', 'English': 'Labor Signs'},
    'প্রস্তুতির অগ্রগতি': {'বাংলা': 'প্রস্তুতির অগ্রগতি', 'English': 'Preparation Progress'},
    'মায়ের জামাকাপড় (৩-৪ সেট)': {'বাংলা': 'মায়ের জামাকাপড় (৩-৪ সেট)', 'English': 'Mother\'s clothes (3-4 sets)'},
    'হাসপাতালের কাগজপত্র ও রিপোর্ট': {'বাংলা': 'হাসপাতালের কাগজপত্র ও রিপোর্ট', 'English': 'Hospital documents & reports'},
    'জাতীয় পরিচয়পত্র / জন্ম সনদ': {'বাংলা': 'জাতীয় পরিচয়পত্র / জন্ম সনদ', 'English': 'NID / Birth certificate'},
    'নবজাতকের জামাকাপড় (৫-৬ সেট)': {'বাংলা': 'নবজাতকের জামাকাপড় (৫-৬ সেট)', 'English': 'Newborn clothes (5-6 sets)'},
    'ডায়াপার (১ প্যাকেট)': {'বাংলা': 'ডায়াপার (১ প্যাকেট)', 'English': 'Diapers (1 packet)'},
    'শিশুর কম্বল ও চাদর': {'বাংলা': 'শিশুর কম্বল ও চাদর', 'English': 'Baby blanket & sheet'},
    'ফোন চার্জার ও পাওয়ার ব্যাংক': {'বাংলা': 'ফোন চার্জার ও পাওয়ার ব্যাংক', 'English': 'Phone charger & power bank'},
    'নগদ অর্থ ও বিমা কার্ড': {'বাংলা': 'নগদ অর্থ ও বিমা কার্ড', 'English': 'Cash & insurance card'},
    'স্যানিটারি প্যাড': {'বাংলা': 'স্যানিটারি প্যাড', 'English': 'Sanitary pads'},
    'খাবার পানি ও হালকা স্ন্যাকস': {'বাংলা': 'খাবার পানি ও হালকা স্ন্যাকস', 'English': 'Water & light snacks'},
    'মায়ের জিনিস': {'বাংলা': 'মায়ের জিনিস', 'English': 'Mother\'s items'},
    'কাগজপত্র': {'বাংলা': 'কাগজপত্র', 'English': 'Documents'},
    'শিশুর জিনিস': {'বাংলা': 'শিশুর জিনিস', 'English': 'Baby items'},
    'অন্যান্য': {'বাংলা': 'অন্যান্য', 'English': 'Others'},
    'আর্থিক': {'বাংলা': 'আর্থিক', 'English': 'Financial'},
    'নিয়মিত ব্যথা': {'বাংলা': 'নিয়মিত ব্যথা', 'English': 'Regular pain'},
    'প্রতি ৫-১০ মিনিটে ব্যথা শুরু হয়': {'বাংলা': 'প্রতি ৫-১০ মিনিটে ব্যথা শুরু হয়', 'English': 'Pain starts every 5-10 minutes'},
    'পানি ভেঙে পড়া': {'বাংলা': 'পানি ভেঙে পড়া', 'English': 'Water breaking'},
    'অ্যামনিওটিক ফ্লুইড বের হওয়া - এখনই হাসপাতালে যান': {'বাংলা': 'অ্যামনিওটিক ফ্লুইড বের হওয়া - এখনই হাসপাতালে যান', 'English': 'Amniotic fluid leaking - go to hospital now'},
    'রক্তপাত': {'বাংলা': 'রক্তপাত', 'English': 'Bleeding'},
    'যেকোনো রক্তপাত দেখলে সাথে সাথে ডাক্তার ডাকুন': {'বাংলা': 'যেকোনো রক্তপাত দেখলে সাথে সাথে ডাক্তার ডাকুন', 'English': 'Call doctor immediately for any bleeding'},
    'শিশুর নড়াচড়া কমে যাওয়া': {'বাংলা': 'শিশুর নড়াচড়া কমে যাওয়া', 'English': 'Reduced baby movement'},
    '২ ঘণ্টায় ১০টির কম কিক হলে সতর্ক থাকুন': {'বাংলা': '২ ঘণ্টায় ১০টির কম কিক হলে সতর্ক থাকুন', 'English': 'Be alert if less than 10 kicks in 2 hours'},
    'ঘন ঘন প্রস্রাব': {'বাংলা': 'ঘন ঘন প্রস্রাব', 'English': 'Frequent urination'},
    'শিশু নিচে নামার কারণে চাপ বাড়তে পারে': {'বাংলা': 'শিশু নিচে নামার কারণে চাপ বাড়তে পারে', 'English': 'Pressure may increase as baby drops lower'},
    'জরুরি': {'বাংলা': 'জরুরি', 'English': 'Urgent'},

    // Babar Koronio Screen
    'মায়ের সাপোর্ট': {'বাংলা': 'মায়ের সাপোর্ট', 'English': 'Mother\'s Support'},
    'জরুরি চেকলিস্ট': {'বাংলা': 'জরুরি চেকলিস্ট', 'English': 'Emergency Checklist'},
    'সহানুভূতি': {'বাংলা': 'সহানুভূতি', 'English': 'Empathy'},
    'প্যারেন্টিং': {'বাংলা': 'প্যারেন্টিং', 'English': 'Parenting'},
    'গর্ভাবস্থায় একজন বাবার সক্রিয় সহযোগিতা মায়ের মানসিক সুস্থতায় সবচেয়ে বড় ভূমিকা রাখে।': {'বাংলা': 'গর্ভাবস্থায় একজন বাবার সক্রিয় সহযোগিতা মায়ের মানসিক সুস্থতায় সবচেয়ে বড় ভূমিকা রাখে।', 'English': 'An active father\'s support during pregnancy plays the biggest role in mother\'s mental health.'},
    'বমি বা অস্বস্তিতে পাশে থাকুন': {'বাংলা': 'বমি বা অস্বস্তিতে পাশে থাকুন', 'English': 'Be there during nausea & discomfort'},
    'মায়ের পাশে বসুন, পিঠ আলতো মালিশ করুন। বলুন \"আমি আছি তোমার সাথে\"।': {'বাংলা': 'মায়ের পাশে বসুন, পিঠ আলতো মালিশ করুন। বলুন \"আমি আছি তোমার সাথে\"।', 'English': 'Sit beside her, gently massage her back. Say "I am with you".'},
    'ঘরের কাজে সাহায্য করুন': {'বাংলা': 'ঘরের কাজে সাহায্য করুন', 'English': 'Help with household work'},
    'রান্না, কেনাকাটা ও ঘর পরিষ্কারে সহায়তা করুন। ছোট কাজেই মায়ের অনেক চাপ কমে।': {'বাংলা': 'রান্না, কেনাকাটা ও ঘর পরিষ্কারে সহায়তা করুন। ছোট কাজেই মায়ের অনেক চাপ কমে।', 'English': 'Help with cooking, shopping & cleaning. Small tasks greatly reduce mother\'s stress.'},
    'পুষ্টিকর খাবার নিশ্চিত করুন': {'বাংলা': 'পুষ্টিকর খাবার নিশ্চিত করুন', 'English': 'Ensure nutritious food'},
    'দুধ, ডিম, শাকসবজি ও ফলমূল এনে দিন। মায়ের পুষ্টিই শিশুর পুষ্টি।': {'বাংলা': 'দুধ, ডিম, শাকসবজি ও ফলমূল এনে দিন। মায়ের পুষ্টিই শিশুর পুষ্টি।', 'English': 'Bring milk, eggs, vegetables & fruits. Mother\'s nutrition is baby\'s nutrition.'},
    'চেকআপে সাথে যান': {'বাংলা': 'চেকআপে সাথে যান', 'English': 'Go with her to checkups'},
    'ডাক্তারের কাছে সাথে যাওয়া মায়ের মনোবল বাড়ায় এবং আপনাকেও আপডেট রাখে।': {'বাংলা': 'ডাক্তারের কাছে সাথে যাওয়া মায়ের মনোবল বাড়ায় এবং আপনাকেও আপডেট রাখে।', 'English': 'Going to the doctor together boosts mother\'s morale and keeps you updated.'},
    'জরুরি প্রস্তুতি': {'বাংলা': 'জরুরি প্রস্তুতি', 'English': 'Emergency Preparation'},
    ' টি সম্পন্ন হয়েছে': {'বাংলা': ' টি সম্পন্ন হয়েছে', 'English': ' completed'},
    'হাসপাতালের ব্যাগ গোছানো': {'বাংলা': 'হাসপাতালের ব্যাগ গোছানো', 'English': 'Pack hospital bag'},
    'মায়ের ও শিশুর কাপড়, কাগজপত্র': {'বাংলা': 'মায়ের ও শিশুর কাপড়, কাগজপত্র', 'English': 'Mother\'s & baby\'s clothes, documents'},
    'রক্তদাতার ব্যবস্থা': {'বাংলা': 'রক্তদাতার ব্যবস্থা', 'English': 'Arrange blood donors'},
    'A+, B+, O+ — ২ জন ডোনার ঠিক করুন': {'বাংলা': 'A+, B+, O+ — ২ জন ডোনার ঠিক করুন', 'English': 'A+, B+, O+ — arrange 2 donors'},
    'গাড়ির ব্যবস্থা': {'বাংলা': 'গাড়ির ব্যবস্থা', 'English': 'Arrange transport'},
    'দিনে বা রাতে যোগাযোগ করা যাবে': {'বাংলা': 'দিনে বা রাতে যোগাযোগ করা যাবে', 'English': 'Reachable day or night'},
    'অর্থের প্রস্তুতি': {'বাংলা': 'অর্থের প্রস্তুতি', 'English': 'Financial preparation'},
    'ডেলিভারি খরচ সঞ্চয় করুন': {'বাংলা': 'ডেলিভারি খরচ সঞ্চয় করুন', 'English': 'Save for delivery expenses'},
    'হাসপাতাল চিহ্নিত করুন': {'বাংলা': 'হাসপাতাল চিহ্নিত করুন', 'English': 'Identify hospital'},
    'নিকটস্থ প্রসব কেন্দ্র জানুন': {'বাংলা': 'নিকটস্থ প্রসব কেন্দ্র জানুন', 'English': 'Know nearest delivery center'},
    'ডাক্তারের ফোন নম্বর সংরক্ষণ': {'বাংলা': 'ডাক্তারের ফোন নম্বর সংরক্ষণ', 'English': 'Save doctor\'s phone number'},
    'জরুরি মুহূর্তে দ্রুত যোগাযোগ': {'বাংলা': 'জরুরি মুহূর্তে দ্রুত যোগাযোগ', 'English': 'Quick contact in emergencies'},
    'গর্ভাবস্থায় হরমোন পরিবর্তনে মায়ের আচরণ বদলে যেতে পারে। এটি তার দোষ নয় — বোঝার চেষ্টা করুন।': {'বাংলা': 'গর্ভাবস্থায় হরমোন পরিবর্তনে মায়ের আচরণ বদলে যেতে পারে। এটি তার দোষ নয় — বোঝার চেষ্টা করুন।', 'English': 'Mother\'s behavior may change due to hormones during pregnancy. It\'s not her fault — try to understand.'},
    'মুড সুইং হলে': {'বাংলা': 'মুড সুইং হলে', 'English': 'During mood swings'},
    'রাগ করবেন না। হরমোনের পরিবর্তনে এটি স্বাভাবিক। শান্তভাবে কথা বলুন।': {'বাংলা': 'রাগ করবেন না। হরমোনের পরিবর্তনে এটি স্বাভাবিক। শান্তভাবে কথা বলুন।', 'English': 'Don\'t get angry. It\'s normal due to hormonal changes. Speak calmly.'},
    'অতিরিক্ত ক্লান্তিতে': {'বাংলা': 'অতিরিক্ত ক্লান্তিতে', 'English': 'During extreme tiredness'},
    'বিশ্রামের সুযোগ দিন। ঘরের কাজে বাড়তি চাপ দেবেন না।': {'বাংলা': 'বিশ্রামের সুযোগ দিন। ঘরের কাজে বাড়তি চাপ দেবেন না।', 'English': 'Give her rest. Don\'t add extra pressure with household work.'},
    'কান্নাকাটি করলে': {'বাংলা': 'কান্নাকাটি করলে', 'English': 'When she cries'},
    'পাশে বসুন, কারণ জিজ্ঞেস করুন। শুধু শুনুন — উপদেশ দিতে হবে না।': {'বাংলা': 'পাশে বসুন, কারণ জিজ্ঞেস করুন। শুধু শুনুন — উপদেশ দিতে হবে না।', 'English': 'Sit beside her, ask why. Just listen — no need to give advice.'},
    'খাবার অরুচি হলে': {'বাংলা': 'খাবার অরুচি হলে', 'English': 'When she has no appetite'},
    'পছন্দের খাবার রান্না করুন বা এনে দিন। জোর করবেন না।': {'বাংলা': 'পছন্দের খাবার রান্না করুন বা এনে দিন। জোর করবেন না।', 'English': 'Cook or bring her favorite food. Don\'t force her.'},
    'সন্তানের জীবনের প্রথম দিনগুলোতে বাবার উপস্থিতি শিশুর মানসিক বিকাশে অত্যন্ত গুরুত্বপূর্ণ।': {'বাংলা': 'সন্তানের জীবনের প্রথম দিনগুলোতে বাবার উপস্থিতি শিশুর মানসিক বিকাশে অত্যন্ত গুরুত্বপূর্ণ।', 'English': 'Father\'s presence in the first days of baby\'s life is vital for mental development.'},
    'ডায়াপার পরিবর্তন': {'বাংলা': 'ডায়াপার পরিবর্তন', 'English': 'Diaper changing'},
    'প্রতি ২-৩ ঘণ্টায় বা ভেজা হলে বদলে দিন। পরিষ্কার করার সময় সামনে থেকে পেছনে মুছুন।': {'বাংলা': 'প্রতি ২-৩ ঘণ্টায় বা ভেজা হলে বদলে দিন। পরিষ্কার করার সময় সামনে থেকে পেছনে মুছুন।', 'English': 'Change every 2-3 hours or when wet. Wipe front to back when cleaning.'},
    'শিশুকে কোলে নেওয়া': {'বাংলা': 'শিশুকে কোলে নেওয়া', 'English': 'Holding the baby'},
    'মাথা সবসময় সাপোর্ট দিন। শিশু কাঁদলে আলতো দুলিয়ে শান্ত করুন।': {'বাংলা': 'মাথা সবসময় সাপোর্ট দিন। শিশু কাঁদলে আলতো দুলিয়ে শান্ত করুন।', 'English': 'Always support the head. Gently rock to calm when baby cries.'},
    'মাকে বিশ্রাম দেওয়া': {'বাংলা': 'মাকে বিশ্রাম দেওয়া', 'English': 'Giving mother rest'},
    'রাতের ফিডিং বা ঘুম পাড়ানোর দায়িত্ব মাঝে মাঝে নিজে নিন।': {'বাংলা': 'রাতের ফিডিং বা ঘুম পাড়ানোর দায়িত্ব মাঝে মাঝে নিজে নিন।', 'English': 'Occasionally take responsibility for night feeding or putting baby to sleep.'},
    'শিশুর সাথে কথা বলুন': {'বাংলা': 'শিশুর সাথে কথা বলুন', 'English': 'Talk to your baby'},
    'শিশুরা বাবার কণ্ঠস্বর গর্ভ থেকেই চেনে। জন্মের পর আরো বেশি কথা বলুন।': {'বাংলা': 'শিশুরা বাবার কণ্ঠস্বর গর্ভ থেকেই চেনে। জন্মের পর আরো বেশি কথা বলুন।', 'English': 'Babies recognize father\'s voice from the womb. Talk to them even more after birth.'},

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
    'মা ও শিশুর বিকাশের প্রয়োজনীয় পুষ্টি টিপস': {'বাংলা': 'মা ও শিশুর বিকাশের প্রয়োজনীয় পুষ্টি টিপস', 'English': 'Essential nutrition tips for mother & baby development'},
    'কিক কাউন্টার অনুস্মারক': {'বাংলা': 'কিক কাউন্টার অনুস্মারক', 'English': 'Kick Counter Reminders'},
    'দৈনিক গর্ভের শিশুর কিক গুনতে রিমাইন্ডার': {'বাংলা': 'দৈনিক গর্ভের শিশুর কিক গুনতে রিমাইন্ডার', 'English': "Reminders to count baby's daily kicks"},
    'নিরাপত্তা ও ডাটা পলিসি': {'বাংলা': 'নিরাপত্তা ও ডাটা পলিসি', 'English': 'Security & Data Policy'},
    'অ্যাপ পাসকোড লক': {'বাংলা': 'অ্যাপ পাসকোড লক', 'English': 'App Passcode Lock'},
    'অ্যাপ খোলার সময় পিন লক নিশ্চিত করুন': {'বাংলা': 'অ্যাপ খোলার সময় পিন লক নিশ্চিত করুন', 'English': 'Enable PIN lock when launching the app'},
    'বায়োমেট্রিক আনলক (ফিঙ্গারপ্রিন্ট)': {'বাংলা': 'বায়োমেট্রিক আনলক (ফিঙ্গারপ্রিন্ট)', 'English': 'Biometric Unlock (Fingerprint)'},
    'দ্রুত অ্যাক্সেসের জন্য ফিঙ্গারপ্রিন্ট সেট করুন': {'বাংলা': 'দ্রুত অ্যাক্সেসের জন্য ফিঙ্গারপ্রিন্ট সেট করুন', 'English': 'Set fingerprint for fast secure access'},
    'অ্যাকাউন্ট সেটিংস': {'বাংলা': 'অ্যাকাউন্ট সেটিংস', 'English': 'Account Settings'},
    'পাসওয়ার্ড পরিবর্তন করুন': {'বাংলা': 'পাসওয়ার্ড পরিবর্তন করুন', 'English': 'Change Password'},
    'আপনার গোপনীয় পাসওয়ার্ড পরিবর্তন করুন': {'বাংলা': 'আপনার গোপনীয় পাসওয়ার্ড পরিবর্তন করুন', 'English': 'Change your private password'},
    'অ্যাকাউন্ট মুছে ফেলুন (Delete Account)': {'বাংলা': 'অ্যাকাউন্ট মুছে ফেলুন (Delete Account)', 'English': 'Delete Account'},
    'আপনার সমস্ত ডাটা চিরতরে ডিলিট করুন': {'বাংলা': 'আপনার সমস্ত ডাটা চিরতরে ডিলিট করুন', 'English': 'Permanently delete all your records'},
    'সহায়তা ও তথ্য': {'বাংলা': 'সহায়তা ও তথ্য', 'English': 'Help & Support'},
    'গোপনীয়তা নীতিমালা (Privacy Policy)': {'বাংলা': 'গোপনীয়তা নীতিমালা (Privacy Policy)', 'English': 'Privacy Policy'},
    'আমাদের ডাটা ব্যবহার নির্দেশিকা পড়ুন': {'বাংলা': 'আমাদের ডাটা ব্যবহার নির্দেশিকা পড়ুন', 'English': 'Read our data usage policy'},
    'সচরাচর জিজ্ঞাসিত প্রশ্ন (FAQ)': {'বাংলা': 'সচরাচর জিজ্ঞাসিত প্রশ্ন (FAQ)', 'English': 'Frequently Asked Questions (FAQ)'},
    'অ্যাপ ব্যবহারে সাধারণ জিজ্ঞাসাসমূহ': {'বাংলা': 'অ্যাপ ব্যবহারে সাধারণ জিজ্ঞাসাসমূহ', 'English': 'Common questions about using the app'},

    // Popup Actions
    'বাতিল করুন': {'বাংলা': 'বাতিল করুন', 'English': 'Cancel'},
    'আপডেট করুন': {'বাংলা': 'আপডেট করুন', 'English': 'Update'},
    'অফলাইন ব্যাকআপ ও সিঙ্ক': {'বাংলা': 'অফলাইন ব্যাকআপ ও সিঙ্ক', 'English': 'Offline Backup & Sync'},
    'ডাটা ব্যাকআপ ও সিঙ্ক করা হচ্ছে...': {'বাংলা': 'ডাটা ব্যাকআপ ও সিঙ্ক করা হচ্ছে...', 'English': 'Data is backing up and syncing...'},
    'অনুগ্রহ করে অপেক্ষা করুন, সংযোগ বিচ্ছিন্ন করবেন না।': {'বাংলা': 'অনুগ্রহ করে অপেক্ষা করুন, সংযোগ বিচ্ছিন্ন করবেন না।', 'English': 'Please wait, do not disconnect.'},
    'আপনার গর্ভাবস্থা ও শিশুর ডাটা সফলভাবে অফলাইন সিঙ্ক হয়েছে!': {'বাংলা': 'আপনার গর্ভাবস্থা ও শিশুর ডাটা সফলভাবে অফলাইন সিঙ্ক হয়েছে!', 'English': 'Your pregnancy and baby data has been successfully synced!'},
    'পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে!': {'বাংলা': 'পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে!', 'English': 'Password successfully changed!'},
    'নতুন পাসওয়ার্ড': {'বাংলা': 'নতুন পাসওয়ার্ড', 'English': 'New Password'},
    'বর্তমান পাসওয়ার্ড': {'বাংলা': 'বর্তমান পাসওয়ার্ড', 'English': 'Current Password'},
    'নতুন পাসওয়ার্ড নিশ্চিত করুন': {'বাংলা': 'নতুন পাসওয়ার্ড নিশ্চিত করুন', 'English': 'Confirm New Password'},
    'নতুন পাসওয়ার্ড দুইটি মেলেনি!': {'বাংলা': 'নতুন পাসওয়ার্ড দুইটি মেলেনি!', 'English': 'The two new passwords do not match!'},
    'অ্যাকাউন্ট মুছে ফেলবেন?': {'বাংলা': 'অ্যাকাউন্ট মুছে ফেলবেন?', 'English': 'Delete Account?'},
    'আপনি কি নিশ্চিত যে আপনার MHRIS অ্যাকাউন্টটি স্থায়ীভাবে ডিলিট করতে চান? আপনার পূর্ববর্তী সমস্ত গর্ভাবস্থা ও ভ্যাকসিনের মেডিকেল রেকর্ড ডাটা স্থায়ীভাবে মুছে যাবে!': {
      'বাংলা': 'আপনি কি নিশ্চিত যে আপনার MHRIS অ্যাকাউন্টটি স্থায়ীভাবে ডিলিট করতে চান? আপনার পূর্ববর্তী সমস্ত গর্ভাবস্থা ও ভ্যাকসিনের মেডিকেল রেকর্ড ডাটা স্থায়ীভাবে মুছে যাবে!',
      'English': 'Are you sure you want to permanently delete your MHRIS account? All your previous pregnancy and vaccine medical records will be deleted forever!'
    },
    'হ্যাঁ, ডিলিট করুন': {'বাংলা': 'হ্যাঁ, ডিলিট করুন', 'English': 'Yes, Delete'},
    'অ্যাকাউন্ট নিষ্ক্রিয়করণের অনুরোধ জমা হয়েছে।': {'বাংলা': 'অ্যাকাউন্ট নিষ্ক্রিয়করণের অনুরোধ জমা হয়েছে।', 'English': 'Account deletion request has been submitted.'},
    'গোপনীয়তা নীতিমালা ফাইল ওপেন করা হচ্ছে...': {'বাংলা': 'গোপনীয়তা নীতিমালা ফাইল ওপেন করা হচ্ছে...', 'English': 'Opening Privacy Policy...'},
    'এফএকিউ পেজ লোড হচ্ছে...': {'বাংলা': 'এফএকিউ পেজ লোড হচ্ছে...', 'English': 'Loading FAQ page...'},

    // Dashboard header strings
    'হ্যালো, ': {'বাংলা': 'হ্যালো, ', 'English': 'Hello, '},
    'আজ আপনি দারুণ করছেন। চলুন আজকের আপডেটগুলো দেখে নিই।': {
      'বাংলা': 'আজ আপনি দারুণ করছেন। চলুন আজকের আপডেটগুলো দেখে নিই।',
      'English': "You are doing great today. Let's see today's updates."
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
