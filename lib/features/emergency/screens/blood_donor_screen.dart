import '../../../core/localization/language_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_translations.dart';
import '../widgets/mock_dialer_widget.dart';

class BloodDonorScreen extends StatefulWidget {
  const BloodDonorScreen({super.key});

  @override
  State<BloodDonorScreen> createState() => _BloodDonorScreenState();
}

class _BloodDonorScreenState extends State<BloodDonorScreen> {
  String _selectedBloodGroup = 'সব গ্রুপ';
  String _selectedDistrict = 'সব জেলা';

  final List<String> _bloodGroups = ['সব গ্রুপ', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final List<String> _districts = ['সব জেলা', 'ঢাকা', 'চট্টগ্রাম', 'রাজশাহী', 'খুলনা', 'সিলেট', 'বরিশাল', 'রংপুর', 'ময়মনসিংহ'];

  // Stateful Donors List
  final List<Map<String, dynamic>> _donors = [
    {'name': 'সাকিব আল হাসান', 'group': 'O+', 'district': 'ঢাকা', 'area': 'মিরপুর', 'phone': '01711223344', 'lastDonation': '৩ মাস আগে', 'suitable': true},
    {'name': 'নুসরাত জাহান মিম', 'group': 'A+', 'district': 'ঢাকা', 'area': 'উত্তরা', 'phone': '01911334455', 'lastDonation': '৫ মাস আগে', 'suitable': true},
    {'name': 'শরিফুল ইসলাম', 'group': 'B+', 'district': 'চট্টগ্রাম', 'area': 'হালিশহর', 'phone': '01811445566', 'lastDonation': '১ মাস আগে', 'suitable': false},
    {'name': 'তাসনিম আক্তার', 'group': 'AB+', 'district': 'রাজশাহী', 'area': 'বোয়ালিয়া', 'phone': '01511556677', 'lastDonation': '৪ মাস আগে', 'suitable': true},
    {'name': 'আরিফুর রহমান', 'group': 'O-', 'district': 'খুলনা', 'area': 'খালিশপুর', 'phone': '01611667788', 'lastDonation': '৬ মাস আগে', 'suitable': true},
    {'name': 'ফারিহা সুলতানা', 'group': 'A-', 'district': 'সিলেট', 'area': 'জিন্দাবাজার', 'phone': '01711778899', 'lastDonation': '২ মাস আগে', 'suitable': true},
  ];

  // Stateful Urgent Blood Requests
  final List<Map<String, dynamic>> _requests = [
    {
      'patient': 'মোসাঃ মরিয়ম বেগম',
      'group': 'A+',
      'amount': '২ ব্যাগ',
      'hospital': 'ঢাকা মেডিকেল কলেজ হাসপাতাল',
      'reason': 'গর্ভকালীন জটিলতা ও সিজারিয়ান',
      'date': 'আজকে (জরুরি)',
      'contact': 'স্বামী (হাসান)',
      'phone': '01712987654'
    },
    {
      'patient': 'ফাতেমা আক্তার',
      'group': 'O-',
      'amount': '১ ব্যাগ',
      'hospital': 'আজিমপুর মাতৃসদন ও শিশু স্বাস্থ্য হাসপাতাল',
      'reason': 'অতিরিক্ত রক্তক্ষরণ (প্রসব পরবর্তী)',
      'date': 'আগামীকাল সকাল ১০টা',
      'contact': 'ভাই (কামরুল)',
      'phone': '01912987654'
    }
  ];

  void _triggerCall(String name, String phone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MockDialerWidget(name: name, phone: phone),
    );
  }

  final Map<String, Map<String, List<String>>> _bdLocations = {
    'ঢাকা': {
      'ঢাকা': ['মিরপুর', 'উত্তরা', 'গুলশান', 'ধানমন্ডি', 'মোহাম্মদপুর', 'সদর'],
      'গাজীপুর': ['টঙ্গী', 'কালিয়াকৈর', 'শ্রীপুর', 'কাপাসিয়া'],
      'নারায়ণগঞ্জ': ['ফতুল্লা', 'সিদ্ধিরগঞ্জ', 'রূপগঞ্জ'],
      'টাঙ্গাইল': ['সদর', 'মির্জাপুর', 'ঘাটাইল'],
    },
    'চট্টগ্রাম': {
      'চট্টগ্রাম': ['হালিশহর', 'পতেঙ্গা', 'পাহাড়তলী', 'চান্দগাঁও'],
      'কক্সবাজার': ['উখিয়া', 'টেকনাফ', 'চকোরিয়া'],
      'কুমিল্লা': ['লাকসাম', 'দাউদকান্দি', 'চৌদ্দগ্রাম'],
      'নোয়াখালী': ['সদর', 'বেগমগঞ্জ', 'চাটখিল'],
    },
    'রাজশাহী': {
      'রাজশাহী': ['বোয়ালিয়া', 'মতিহার', 'রাজপাড়া'],
      'বগুড়া': ['শিবগঞ্জ', 'শেরপুর', 'কাহালু'],
      'পাবনা': ['সদর', 'ঈশ্বরদী', 'চাটমোহর'],
    },
    'খুলনা': {
      'খুলনা': ['খালিশপুর', 'সোনাডাঙ্গা', 'দৌলতপুর'],
      'যশোর': ['অভয়নগর', 'ঝিকরগাছা', 'শার্শা'],
      'কুষ্টিয়া': ['সদর', 'কুমারখালী', 'ভেড়ামারা'],
    },
    'সিলেট': {
      'সিলেট': ['কোতোয়ালী', 'জালালাবাদ', 'দক্ষিণ সুরমা'],
      'মৌলভীবাজার': ['শ্রীমঙ্গল', 'কমলগঞ্জ', 'কুলাউড়া'],
      'সুনামগঞ্জ': ['সদর', 'ছাতক', 'জগন্নাথপুর'],
    },
    'বরিশাল': {
      'বরিশাল': ['কোতোয়ালী', 'বাবুগঞ্জ', 'উজিরপুর'],
      'পটুয়াখালী': ['বাউফল', 'গলাচিপা', 'দশমিনা'],
      'ভোলা': ['সদর', 'বোরহানউদ্দিন', 'লালমোহন'],
    },
    'রংপুর': {
      'রংপুর': ['কোতোয়ালী', 'বদরগঞ্জ', 'পীরগঞ্জ'],
      'দিনাজপুর': ['পার্বতীপুর', 'নবাবগঞ্জ', 'বীরগঞ্জ'],
      'গাইবান্ধা': ['সদর', 'গোবিন্দগঞ্জ', 'পলাশবাড়ী'],
    },
    'ময়মনসিংহ': {
      'ময়মনসিংহ': ['কোতোয়ালী', 'মুক্তাগাছা', 'ত্রিশাল'],
      'জামালপুর': ['মাদারগঞ্জ', 'মেলান্দহ', 'সরিষাবাড়ী'],
      'শেরপুর': ['সদর', 'নকলা', 'শ্রীবরদী'],
    }
  };

  void _registerDonor() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final lastDonationController = TextEditingController();
    
    String tempGroup = 'A+';
    
    TextEditingController? divCtrl;
    TextEditingController? distCtrl;
    TextEditingController? thanaCtrl;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          String currentDiv = divCtrl?.text ?? '';
          String currentDist = distCtrl?.text ?? '';

          List<String> divisions = _bdLocations.keys.toList();
          List<String> districts = _bdLocations.containsKey(currentDiv) ? _bdLocations[currentDiv]!.keys.toList() : [];
          List<String> thanas = _bdLocations.containsKey(currentDiv) && _bdLocations[currentDiv]!.containsKey(currentDist) 
              ? _bdLocations[currentDiv]![currentDist]! : [];

          Widget buildAutoComplete(
            String label, 
            List<String> options, 
            void Function(TextEditingController) onInit,
            VoidCallback onChanged
          ) {
            return Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) return options;
                return options.where((String option) => 
                  option.toLowerCase().contains(textEditingValue.text.toLowerCase())
                );
              },
              onSelected: (String selection) {
                onChanged();
              },
              optionsMaxHeight: 200,
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                onInit(textEditingController);
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (v) => onChanged(),
                  decoration: InputDecoration(
                    labelText: label,
                    hintText: 'লিখুন বা তালিকা থেকে নির্বাচন করুন',
                    labelStyle: TextStyle(fontSize: 13),
                    hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                    suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ),
                );
              },
            );
          }

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Icon(Icons.volunteer_activism_rounded, color: AppColors.error),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'রক্তদাতা হিসেবে যুক্ত হোন'.tr(context),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'আপনার নাম', labelStyle: TextStyle(fontSize: 13)),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'মোবাইল নম্বর', labelStyle: TextStyle(fontSize: 13)),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: tempGroup,
                    decoration: const InputDecoration(labelText: 'রক্তের গ্রুপ', labelStyle: TextStyle(fontSize: 13)),
                    items: _bloodGroups.where((g) => g != 'সব গ্রুপ').map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (val) => setDialogState(() => tempGroup = val!),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: lastDonationController,
                    decoration: const InputDecoration(
                      labelText: 'সর্বশেষ কবে রক্ত দিয়েছেন?', 
                      hintText: 'যেমন: ৩ মাস আগে / কখনো দিইনি',
                      labelStyle: TextStyle(fontSize: 13),
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 12),
                  buildAutoComplete('বিভাগ', divisions, (c) => divCtrl = c, () {
                    setDialogState(() {
                      distCtrl?.clear();
                      thanaCtrl?.clear();
                    });
                  }),
                  SizedBox(height: 12),
                  buildAutoComplete('জেলা', districts, (c) => distCtrl = c, () {
                    setDialogState(() {
                      thanaCtrl?.clear();
                    });
                  }),
                  SizedBox(height: 12),
                  buildAutoComplete('থানা / এলাকা', thanas, (c) => thanaCtrl = c, () {
                    setDialogState(() {});
                  }),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('বাতিল'.tr(context), style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  String finalDist = (distCtrl?.text ?? '').trim();
                  String finalThana = (thanaCtrl?.text ?? '').trim();

                  if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty && finalDist.isNotEmpty && finalThana.isNotEmpty) {
                    setState(() {
                      _donors.insert(0, {
                        'name': nameController.text,
                        'group': tempGroup,
                        'district': finalDist,
                        'area': finalThana,
                        'phone': phoneController.text,
                        'lastDonation': lastDonationController.text.isNotEmpty ? lastDonationController.text : 'জানা নেই',
                        'suitable': true
                      });
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('রক্তদাতা হিসেবে সফলভাবে নিবন্ধন সম্পন্ন হয়েছে!'.tr(context), style: TextStyle(fontFamily: 'Hind_Siliguri')),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('দয়া করে সব তথ্য সঠিকভাবে পূরণ করুন।'.tr(context), style: TextStyle(fontFamily: 'Hind_Siliguri')),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                child: Text('নিবন্ধন করুন'.tr(context), style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _requestBlood() {
    final patientController = TextEditingController();
    final hospitalController = TextEditingController();
    final reasonController = TextEditingController();
    final dateController = TextEditingController();
    final contactController = TextEditingController();
    final phoneController = TextEditingController();
    String tempGroup = 'A+';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.add_alert_rounded, color: AppColors.error),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'রক্তের জরুরি অনুরোধ তৈরি করুন'.tr(context),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: patientController,
                decoration: const InputDecoration(labelText: 'রোগীর নাম', labelStyle: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: tempGroup,
                decoration: const InputDecoration(labelText: 'প্রয়োজনীয় রক্তের গ্রুপ', labelStyle: TextStyle(fontSize: 13)),
                items: _bloodGroups.where((g) => g != 'সব গ্রুপ').map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => tempGroup = val!,
              ),
              SizedBox(height: 8),
              TextField(
                controller: hospitalController,
                decoration: const InputDecoration(labelText: 'হাসপাতালের নাম', labelStyle: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(labelText: 'অসুখের কারণ/বিবরণ', labelStyle: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'কবে ও কখন রক্ত লাগবে', 
                  hintText: 'যেমন: আগামীকাল সকাল ১০টা', 
                  labelStyle: TextStyle(fontSize: 13), 
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey)
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(labelText: 'যোগাযোগের ব্যক্তি (সম্পর্ক)', labelStyle: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'মোবাইল নম্বর', labelStyle: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('বাতিল'.tr(context), style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              if (patientController.text.isNotEmpty && phoneController.text.isNotEmpty && hospitalController.text.isNotEmpty) {
                setState(() {
                  _requests.insert(0, {
                    'patient': patientController.text,
                    'group': tempGroup,
                    'amount': '১ ব্যাগ',
                    'hospital': hospitalController.text,
                    'reason': reasonController.text.isNotEmpty ? reasonController.text : 'জরুরি অবস্থা',
                    'date': dateController.text.isNotEmpty ? dateController.text : 'আজকে (জরুরি)',
                    'contact': contactController.text.isNotEmpty ? contactController.text : 'আত্মীয়',
                    'phone': phoneController.text
                  });
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('রক্তের জরুরি অনুরোধটি সফলভাবে পোস্ট করা হয়েছে!'.tr(context), style: TextStyle(fontFamily: 'Hind_Siliguri')),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Text('অনুরোধ করুন'.tr(context), style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    // Filtered Donors
    final filteredDonors = _donors.where((donor) {
      final matchesGroup = _selectedBloodGroup == 'সব গ্রুপ' || donor['group'] == _selectedBloodGroup;
      final matchesDistrict = _selectedDistrict == 'সব জেলা' || donor['district'] == _selectedDistrict;
      return matchesGroup && matchesDistrict;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('জরুরি রক্তের গ্রুপ ও দাতা'.tr(context), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1E1B4B)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.volunteer_activism_rounded, color: AppColors.error),
            tooltip: 'রক্তদাতা নিবন্ধন',
            onPressed: _registerDonor,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Urgent Requests Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.add_alert_rounded, color: AppColors.error, size: 22),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'জরুরি রক্তের অনুরোধ'.tr(context),
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: _requestBlood,
                  icon: Icon(Icons.add, size: 16, color: AppColors.error),
                  label: Text('নতুন অনুরোধ'.tr(context), style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.error, fontSize: 13)),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Requests Carousel/List
            SizedBox(
              height: 155,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final req = _requests[index];
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 12, bottom: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFE4E6)),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                                  child: Text(
                                    req['group'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  req['patient'] as String,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF9F1239)),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                req['date'] as String,
                                style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppColors.error),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          'হাসপাতাল: ${req['hospital']}',
                          style: TextStyle(fontSize: 11.5, color: Color(0xFF475569), fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'কারণ: ${req['reason']} (${req['amount']})',
                          style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'যোগাযোগ: ${req['contact']}',
                              style: TextStyle(fontSize: 10.5, color: Colors.black54, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.error,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                minimumSize: Size.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () => _triggerCall(req['contact'] as String, req['phone'] as String),
                              icon: Icon(Icons.phone, size: 12, color: Colors.white),
                              label: Text('কল দিন'.tr(context), style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // Search Panel
            Text(
              'রক্তদাতা খুঁজুন'.tr(context),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
            ),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedBloodGroup,
                      decoration: const InputDecoration(
                        labelText: 'গ্রুপ',
                        labelStyle: TextStyle(fontSize: 11),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: InputBorder.none,
                      ),
                      items: _bloodGroups.map((group) => DropdownMenuItem(value: group, child: Text(group, style: TextStyle(fontSize: 13)))).toList(),
                      onChanged: (val) => setState(() => _selectedBloodGroup = val!),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(width: 1, height: 40, color: Colors.grey.shade300),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDistrict,
                      decoration: const InputDecoration(
                        labelText: 'জেলা',
                        labelStyle: TextStyle(fontSize: 11),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: InputBorder.none,
                      ),
                      items: _districts.map((district) => DropdownMenuItem(value: district, child: Text(district, style: TextStyle(fontSize: 13)))).toList(),
                      onChanged: (val) => setState(() => _selectedDistrict = val!),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Donors List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'উপযুক্ত রক্তদাতাগণ (${filteredDonors.length} জন)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                ),
                GestureDetector(
                  onTap: _registerDonor,
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 14, color: AppColors.error),
                      Text('রক্তদাতা হন'.tr(context), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.error)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8),

            if (filteredDonors.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Icon(Icons.search_off_rounded, size: 48, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'উক্ত গ্রুপ বা জেলায় কোনো রক্তদাতা খুঁজে পাওয়া যায়নি।'.tr(context),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredDonors.length,
                itemBuilder: (context, index) {
                  final donor = filteredDonors[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 4)],
                    ),
                    child: Row(
                      children: [
                        // Blood Drop group container
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(Icons.water_drop_rounded, color: AppColors.error, size: 38),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    donor['group'] as String,
                                    style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                donor['name'] as String,
                                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on_rounded, color: Colors.grey, size: 12),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      '${donor['area']}, ${donor['district']}',
                                      style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.history_rounded, color: Colors.grey, size: 12),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      'সর্বশেষ দান: ${donor['lastDonation']}',
                                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  if (donor['suitable'] as bool)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
                                      child: Text('উপযুক্ত'.tr(context), style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(8)),
                                      child: Text('অনুপযুক্ত'.tr(context), style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Color(0xFFC62828))),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.success.withValues(alpha: 0.1),
                            shape: const CircleBorder(),
                          ),
                          icon: Icon(Icons.phone, color: AppColors.success, size: 20),
                          onPressed: () => _triggerCall(donor['name'] as String, donor['phone'] as String),
                        )
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
