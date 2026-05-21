import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/pregnancy_registration_model.dart';

class PregnancyRegistrationScreen extends StatefulWidget {
  const PregnancyRegistrationScreen({super.key});

  @override
  State<PregnancyRegistrationScreen> createState() =>
      _PregnancyRegistrationScreenState();
}

class _PregnancyRegistrationScreenState
    extends State<PregnancyRegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 6;
  final PregnancyRegistrationModel _formData = PregnancyRegistrationModel();

  // Obstetric history rows (up to 5 rows)
  final List<Map<String, TextEditingController>> _obstetricRows = [];

  // Postpartum controllers
  final Map<String, List<TextEditingController>> _postpartumControllers = {};

  // Medical checkboxes state
  bool _shortBreath = false, _cough4w = false, _fever4w = false;
  bool _fatigued = false, _palpitation = false, _edema = false, _highBP = false;
  bool _breastPain = false, _breastLump = false;
  bool _freqUrination = false, _bloodUrine = false, _lowerAbdom = false;

  // Delivery Place checkboxes
  bool _delDistHosp = false, _delUpazila = false, _delUHFWC = false;
  bool _delMCWC = false, _delHome = false, _delOther = false;

  // Delivery Attendant
  bool _attDoctor = false, _attNurse = false, _attFWV = false;
  bool _attFamilyWelfare = false, _attCSBA = false, _attHealth = false;
  bool _attRelative = false, _attOther = false;

  // Delivery Method
  bool _methNormal = false, _methCSection = false, _methOther = false;

  // Delivery Outcome
  bool _outLive = false, _outStillbirth = false, _outMacerated = false;

  final List<String> _stepTitles = [
    'গর্ভবতীর প্রাথমিক তথ্য',
    'স্বামীর তথ্য ও ঠিকানা',
    'গর্ভাবস্থা ও পরিকল্পনা',
    'গর্ভকালীন সেবা কার্ড',
    'প্রসবের তথ্যাবলী',
    'প্রসবোত্তর পরীক্ষা ও রেফারেল',
  ];

  final List<String> _professions = [
    'গৃহিণী', 'সরকারি চাকরি', 'বেসরকারি চাকরি', 'শিক্ষকতা', 'সমাজকর্মী',
    'চিকিৎসক', 'উদ্যোক্তা', 'শ্রমিক', 'গার্মেন্টস কর্মী', 'ক্ষুদ্র ব্যবসা',
    'মাছ/মাংস ব্যবসা', 'দিন মজুর', 'কৃষি', 'প্রবাসী', 'রিক্সা/ভ্যান চালক',
    'অটো/সিএনজি চালক', 'ড্রাইভার', 'ইমাম', 'ব্যাংকার', 'কর্মচারী', 'বেকার', 'অন্যান্য'
  ];
  final List<String> _educations = [
    'নিরক্ষর', 'অক্ষরজ্ঞান সম্পন্ন', 'পঞ্চম শ্রেণী', 'অষ্টম শ্রেণী',
    'এসএসসি', 'এইচএসসি', 'স্নাতক', 'স্নাতকোত্তর'
  ];
  final List<String> _deliveryPlaceOpts = [
    'বাড়ি', 'UHFWC', 'MCWC', 'UHC', 'জেলা হাসপাতাল',
    'বিশেষায়িত হাসপাতাল', 'প্রাইভেট ক্লিনিক', 'অন্যান্য'
  ];
  final List<String> _familyPlanningOpts = [
    'খাবার বড়ি', 'কনডম', 'ইনজেকটেবল', 'আইইউডি', 'ইমপ্ল্যান্ট',
    'এনএসভি', 'টিউবেকটমি', 'অন্যান্য'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize 3 obstetric history rows
    for (int i = 0; i < 3; i++) {
      _addObstetricRow();
    }
    // Initialize postpartum checkup fields
    final rows = [
      'তাপমাত্রা/নাড়ীর গতি', 'রক্তচাপ', 'হিমোগ্লোবিন', 'প্রস্রাব',
      'অতিরিক্ত রক্তক্ষরণ', 'স্রাব/দুর্গন্ধযুক্ত স্রাব',
      'জরায়ুর আকার ও স্পর্শতার', 'পেরিনিয়াল টিয়ার', 'স্তনের সমস্যা'
    ];
    for (final row in rows) {
      _postpartumControllers[row] = List.generate(5, (_) => TextEditingController());
    }
  }

  void _addObstetricRow() {
    _obstetricRows.add({
      'yearsAgo': TextEditingController(),
      'type': TextEditingController(),
      'boys': TextEditingController(),
      'girls': TextEditingController(),
      'living': TextEditingController(),
      'dead': TextEditingController(),
      'problem': TextEditingController(),
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final row in _obstetricRows) {
      for (final c in row.values) {
        c.dispose();
      }
    }
    for (final list in _postpartumControllers.values) {
      for (final c in list) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _showSuccessDialog();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 48),
            ),
            const SizedBox(height: 24),
            Text('সফলভাবে সংরক্ষিত হয়েছে!', style: AppTextStyles.headingMedium, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            const Text(
              'গর্ভবতীর সম্পূর্ণ তথ্য, সেবা কার্ড ও প্রসবোত্তর তথ্য সফলভাবে যুক্ত হয়েছে।',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Hind_Siliguri', color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); Navigator.pop(context); },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('ঠিক আছে', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) => setState(() => _currentStep = i),
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
                _buildStep5(),
                _buildStep6(),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('গর্ভবতীর তথ্য ফরম ও সেবা কার্ড', style: AppTextStyles.onPrimaryHeading),
                        Text(_stepTitles[_currentStep], style: AppTextStyles.onPrimaryBody),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                    child: Text('${_currentStep + 1}/$_totalSteps',
                        style: const TextStyle(color: Colors.white, fontFamily: 'Hind_Siliguri', fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: List.generate(_totalSteps, (i) {
                  final done = i < _currentStep;
                  final active = i == _currentStep;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 6,
                      decoration: BoxDecoration(
                        color: (done || active) ? Colors.white : Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Bottom Nav ───────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: AppColors.shadow.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _prevStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text('পূর্ববর্তী', style: TextStyle(fontFamily: 'Hind_Siliguri', color: AppColors.primary, fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  _currentStep == _totalSteps - 1 ? 'সংরক্ষণ করুন' : 'পরবর্তী ধাপ',
                  style: const TextStyle(fontFamily: 'Hind_Siliguri', color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helper Widgets ────────────────────────────────────────────────────────

  Widget _sectionTitle(String title, IconData icon, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (color ?? AppColors.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color ?? AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: AppTextStyles.headingMedium)),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
  );

  InputDecoration _inputDeco(String hint, {IconData? icon}) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontFamily: 'Hind_Siliguri', color: AppColors.textSecondary, fontSize: 13),
    prefixIcon: icon != null ? Icon(icon, color: AppColors.primary.withValues(alpha: 0.45), size: 20) : null,
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.4))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.4))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
  );

  Widget _inputField(String label, String hint, {IconData? icon, TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          TextFormField(
            keyboardType: type,
            style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 14),
            decoration: _inputDeco(hint, icon: icon),
          ),
        ],
      ),
    );
  }

  Widget _dropdownField(String label, String hint, List<String> items, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          DropdownButtonFormField<String>(
            decoration: _inputDeco(hint, icon: icon),
            isExpanded: true,
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 13)))).toList(),
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }

  Widget _checkboxTile(String label, bool value, ValueChanged<bool?> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: value ? AppColors.primarySurface : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: value ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border.withValues(alpha: 0.4)),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: (v) { setState(() => onChanged(v)); },
        title: Text(label, style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 13, color: AppColors.textPrimary)),
        activeColor: AppColors.primary,
        checkColor: Colors.white,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget _subHeading(String text) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Text(text, style: const TextStyle(
      fontFamily: 'Hind_Siliguri', fontWeight: FontWeight.w700,
      fontSize: 13, color: AppColors.primary,
    )),
  );

  Widget _inlineRow(List<Widget> children) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children.map((c) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: c))).toList(),
  );

  // ─── STEP 1: গর্ভবতীর প্রাথমিক তথ্য ────────────────────────────────────
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('গর্ভবতীর প্রাথমিক তথ্য', Icons.pregnant_woman_rounded),

          // Photo placeholder
          Center(
            child: Container(
              width: 100, height: 120,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined, color: AppColors.primary.withValues(alpha: 0.5), size: 36),
                  const SizedBox(height: 6),
                  const Text('ছবি', style: TextStyle(fontFamily: 'Hind_Siliguri', color: AppColors.primary, fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          _inputField('০১. গর্ভবতীর নাম', 'পুরো নাম লিখুন', icon: Icons.person_outline),
          _inlineRow([
            _inputField('০২. দম্পতি নং', 'নম্বর', icon: Icons.group_outlined, type: TextInputType.number),
            _inputField('০৪. MC ID নং', 'ID নম্বর', icon: Icons.badge_outlined),
          ]),
          _inputField('০৩. NID / জন্ম নিবন্ধন নং', 'নম্বর লিখুন', icon: Icons.credit_card_outlined, type: TextInputType.number),
          _dropdownField('০৫. গর্ভবতীর পেশা', 'পেশা নির্বাচন করুন', _professions, icon: Icons.work_outline),
          _dropdownField('০৬. শিক্ষাগত যোগ্যতা', 'যোগ্যতা নির্বাচন করুন', _educations, icon: Icons.school_outlined),
          _inputField('০৭. গর্ভবতীর মোবাইল নম্বর', '০১৭xxxxxxxx', icon: Icons.phone_outlined, type: TextInputType.phone),
          _inlineRow([
            _inputField('০৮. বয়স (বছর)', 'বছর', icon: Icons.cake_outlined, type: TextInputType.number),
            _inputField('০৯. উচ্চতা (ইঞ্চি)', 'ইঞ্চি', icon: Icons.height, type: TextInputType.number),
          ]),
          _inlineRow([
            _inputField('১০. ওজন (কেজি)', 'কেজি', icon: Icons.monitor_weight_outlined, type: TextInputType.number),
            _inputField('১১. রক্তের গ্রুপ', 'যেমন: A+', icon: Icons.bloodtype_outlined),
          ]),
        ],
      ),
    );
  }

  // ─── STEP 2: স্বামীর তথ্য ও ঠিকানা ────────────────────────────────────
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('স্বামীর তথ্য', Icons.person_rounded),
          _inputField('১৩. স্বামীর নাম', 'পুরো নাম লিখুন', icon: Icons.person_outline),
          _inlineRow([
            _inputField('১৪. স্বামীর বয়স', 'বছর', icon: Icons.cake_outlined, type: TextInputType.number),
            _inputField('১২. স্বামীর রক্তের গ্রুপ', 'যেমন: B+', icon: Icons.bloodtype_outlined),
          ]),
          _dropdownField('১৫. স্বামীর পেশা', 'পেশা নির্বাচন করুন', _professions, icon: Icons.work_outline),
          _dropdownField('১৬. স্বামীর শিক্ষাগত যোগ্যতা', 'যোগ্যতা নির্বাচন করুন', _educations, icon: Icons.school_outlined),
          _inlineRow([
            _inputField('১৭. মাসিক আয়', 'টাকা', icon: Icons.attach_money_outlined, type: TextInputType.number),
            _inputField('১৮. মোবাইল নম্বর', '০১৭xxxxxxxx', icon: Icons.phone_outlined, type: TextInputType.phone),
          ]),
          const Divider(height: 28),
          _sectionTitle('বর্তমান ঠিকানা', Icons.location_on_outlined),
          _inputField('১৯. গ্রাম / রাস্তা', 'গ্রামের নাম লিখুন', icon: Icons.home_outlined),
          _inlineRow([
            _inputField('২০. ওয়ার্ড', 'ওয়ার্ড নং', icon: Icons.map_outlined),
            _inputField('২১. ইউনিট', 'ইউনিট', icon: Icons.domain_outlined),
          ]),
          _inlineRow([
            _inputField('২২. ইউনিয়ন', 'ইউনিয়ন', icon: Icons.location_city_outlined),
            _inputField('২৩. উপজেলা/থানা', 'উপজেলা', icon: Icons.map_rounded),
          ]),
          _inputField('২৪. জেলা', 'জেলার নাম', icon: Icons.location_on_rounded),
        ],
      ),
    );
  }

  // ─── STEP 3: গর্ভাবস্থা ও পরিকল্পনা ─────────────────────────────────
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('গর্ভাবস্থা ও প্রসব ইতিহাস', Icons.history_rounded),
          _inlineRow([
            _inputField('২৫. কততম গর্ভ', 'সংখ্যা', icon: Icons.pregnant_woman_outlined, type: TextInputType.number),
            _inputField('২৬. জীবিত সন্তান', 'সংখ্যা', icon: Icons.family_restroom_outlined, type: TextInputType.number),
          ]),
          _inputField('২৭. শেষ সন্তানের বয়স', 'বছর', icon: Icons.child_care_outlined, type: TextInputType.number),
          _inlineRow([
            _inputField('২৮. পূর্বে সিজার', 'সংখ্যা', icon: Icons.local_hospital_outlined, type: TextInputType.number),
            _inputField('২৯. নরমাল ডেলিভারী', 'সংখ্যা', icon: Icons.check_circle_outline, type: TextInputType.number),
          ]),
          _inlineRow([
            _inputField('৩০. শেষ মাসিক (LMP)', 'দিন/মাস/বছর', icon: Icons.calendar_today_outlined),
            _inputField('৩১. সম্ভাব্য প্রসব (EDD)', 'দিন/মাস/বছর', icon: Icons.event_available_outlined),
          ]),

          _subHeading('ANC পরিদর্শনের তারিখ'),
          _inlineRow([
            _inputField('পরিদর্শন-১ (৪ মাস)', 'তারিখ', icon: Icons.calendar_month_outlined),
            _inputField('পরিদর্শন-২ (৬ মাস)', 'তারিখ', icon: Icons.calendar_month_outlined),
          ]),
          _inlineRow([
            _inputField('পরিদর্শন-৩ (৮ মাস)', 'তারিখ', icon: Icons.calendar_month_outlined),
            _inputField('পরিদর্শন-৪ (৯ মাস)', 'তারিখ', icon: Icons.calendar_month_outlined),
          ]),

          const Divider(height: 28),
          _sectionTitle('পরিকল্পনা', Icons.assignment_outlined),
          _checkboxTile('৩২. গর্ভবতী ভাতা পাওয়ার যোগ্য', _formData.isEligibleForAllowance ?? false, (v) => _formData.isEligibleForAllowance = v),
          _dropdownField('৩৩. ডেলিভারী কোথায় করাতে ইচ্ছুক', 'স্থান নির্বাচন করুন', _deliveryPlaceOpts, icon: Icons.local_hospital_rounded),
          _dropdownField('৩৪. পরিবার পরিকল্পনা পদ্ধতি', 'পদ্ধতি নির্বাচন করুন', _familyPlanningOpts, icon: Icons.family_restroom_rounded),

          const Divider(height: 28),
          _sectionTitle('তথ্য সংগ্রহকারী', Icons.assignment_ind_outlined),
          _inlineRow([
            _inputField('৩৫. নাম', 'সংগ্রহকারীর নাম', icon: Icons.person_outline),
            _inputField('৩৬. পদবী', 'পদবী', icon: Icons.work_outline),
          ]),
          _inputField('৩৭. মোবাইল নম্বর', 'নম্বর', icon: Icons.phone_outlined, type: TextInputType.phone),
          _inputField('৩৮. মন্তব্য', 'অতিরিক্ত মন্তব্য...', icon: Icons.comment_outlined),
        ],
      ),
    );
  }

  // ─── STEP 4: গর্ভকালীন সেবা কার্ড (Medical History + Obstetric Table) ──
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('গর্ভকালীন সেবা কার্ড', Icons.credit_card_rounded, color: const Color(0xFFD32F2F)),
          _inlineRow([
            _inputField('ক্রমিক নম্বর', 'নম্বর', icon: Icons.format_list_numbered_outlined),
            _inputField('তারিখ', 'দিন/মাস/বছর', icon: Icons.calendar_today),
          ]),
          _inputField('সেবা কেন্দ্রের নাম', 'নাম লিখুন', icon: Icons.local_hospital_outlined),

          const Divider(height: 24),
          _subHeading('গর্ভ, প্রসব ও গর্ভপাত সংক্রান্ত ইতিহাস'),
          _buildObstetricTable(),
          TextButton.icon(
            onPressed: () => setState(() => _addObstetricRow()),
            icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
            label: const Text('নতুন সারি যুক্ত করুন', style: TextStyle(fontFamily: 'Hind_Siliguri', color: AppColors.primary)),
          ),

          const Divider(height: 24),
          _sectionTitle('মেডিকেল ইতিহাস', Icons.health_and_safety_outlined),

          _subHeading('শ্বাসতন্ত্র সম্পর্কিত:'),
          _checkboxTile('শ্বাসকষ্ট আছে কিনা', _shortBreath, (v) => _shortBreath = v ?? false),
          _checkboxTile('কাশি (৪ সপ্তাহের বেশি)', _cough4w, (v) => _cough4w = v ?? false),
          _checkboxTile('জ্বর (৪ সপ্তাহের বেশি)', _fever4w, (v) => _fever4w = v ?? false),

          _subHeading('কার্ডিও ভাসকুলার সম্পর্কিত:'),
          _checkboxTile('অল্পতেই হাঁপিয়ে উঠেন', _fatigued, (v) => _fatigued = v ?? false),
          _checkboxTile('বুক ধড়ফড় করে', _palpitation, (v) => _palpitation = v ?? false),
          _checkboxTile('শরীরের নিম্নাংশে পানি এসেছে', _edema, (v) => _edema = v ?? false),
          _checkboxTile('উচ্চ রক্তচাপ আছে', _highBP, (v) => _highBP = v ?? false),

          _subHeading('স্তন সম্পর্কিত:'),
          _checkboxTile('স্তনে ব্যথা আছে', _breastPain, (v) => _breastPain = v ?? false),
          _checkboxTile('স্তনে চাকা আছে', _breastLump, (v) => _breastLump = v ?? false),

          _subHeading('মূত্রতন্ত্র সম্পর্কিত:'),
          _checkboxTile('ঘন ঘন প্রস্রাব / প্রস্রাবে জ্বালা পোড়া আছে', _freqUrination, (v) => _freqUrination = v ?? false),
          _checkboxTile('প্রস্রাবে রক্ত যায়', _bloodUrine, (v) => _bloodUrine = v ?? false),
          _checkboxTile('তলপেটে (রেনাল এঙ্গেল) ব্যথা আছে', _lowerAbdom, (v) => _lowerAbdom = v ?? false),

          _dropdownField('মাসিকের ইতিহাস', 'চক্র নির্বাচন করুন', ['নিয়মিত', 'অনিয়মিত'], icon: Icons.water_drop_outlined),
          _inputField('অন্য কোনো শারীরিক সমস্যা (যদি থাকে)', 'বিস্তারিত লিখুন...', icon: Icons.sick_outlined),

          const Divider(height: 24),
          _sectionTitle('প্রতিষেধক টিকা (টিটেনাস)', Icons.vaccines_outlined),
          _inlineRow([
            _inputField('১ম ডোজের তারিখ', 'দিন/মাস/বছর', icon: Icons.calendar_month),
            _inputField('২য় ডোজের তারিখ', 'দিন/মাস/বছর', icon: Icons.calendar_month),
          ]),
          _inlineRow([
            _inputField('৩য় ডোজের তারিখ', 'দিন/মাস/বছর', icon: Icons.calendar_month),
            _inputField('৪র্থ ডোজের তারিখ', 'দিন/মাস/বছর', icon: Icons.calendar_month),
          ]),
          _inputField('৫ম ডোজের তারিখ', 'দিন/মাস/বছর', icon: Icons.calendar_month),
        ],
      ),
    );
  }

  // ─── STEP 5: প্রসবের তথ্যাবলী ──────────────────────────────────────────
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('প্রসবের তথ্যাবলী', Icons.baby_changing_station_rounded, color: const Color(0xFFD32F2F)),
          _inlineRow([
            _inputField('প্রসবের তারিখ', 'দিন/মাস/বছর', icon: Icons.calendar_today),
            _inputField('সময়', '০০:০০', icon: Icons.access_time_outlined),
          ]),
          _inputField('ওজন (কেজি)', 'কেজি', icon: Icons.monitor_weight_outlined, type: TextInputType.number),

          _subHeading('প্রসবের স্থান:'),
          _checkboxTile('জেলা হাসপাতাল', _delDistHosp, (v) => _delDistHosp = v ?? false),
          _checkboxTile('উপজেলা স্বাস্থ্য কমপ্লেক্স', _delUpazila, (v) => _delUpazila = v ?? false),
          _checkboxTile('ইউএইচ এন্ড এফডব্লিউসি', _delUHFWC, (v) => _delUHFWC = v ?? false),
          _checkboxTile('এমসিডব্লিউসি', _delMCWC, (v) => _delMCWC = v ?? false),
          _checkboxTile('বাড়ি', _delHome, (v) => _delHome = v ?? false),
          _checkboxTile('অন্যান্য', _delOther, (v) => _delOther = v ?? false),

          _subHeading('প্রসবে সহায়তাকারী:'),
          _checkboxTile('ডাক্তার', _attDoctor, (v) => _attDoctor = v ?? false),
          _checkboxTile('নার্স', _attNurse, (v) => _attNurse = v ?? false),
          _checkboxTile('এফডব্লিউভি', _attFWV, (v) => _attFWV = v ?? false),
          _checkboxTile('পরিবার কল্যাণ সহকারী', _attFamilyWelfare, (v) => _attFamilyWelfare = v ?? false),
          _checkboxTile('সিএসবিএ/মিডওয়াইফ', _attCSBA, (v) => _attCSBA = v ?? false),
          _checkboxTile('স্বাস্থ্য সহকারী', _attHealth, (v) => _attHealth = v ?? false),
          _checkboxTile('আত্মীয়', _attRelative, (v) => _attRelative = v ?? false),
          _checkboxTile('অন্যান্য', _attOther, (v) => _attOther = v ?? false),

          _subHeading('প্রসবের পদ্ধতি:'),
          _checkboxTile('স্বাভাবিক', _methNormal, (v) => _methNormal = v ?? false),
          _checkboxTile('সিজারিয়ান', _methCSection, (v) => _methCSection = v ?? false),
          _checkboxTile('অন্যান্য (উল্লেখ করুন)', _methOther, (v) => _methOther = v ?? false),

          _subHeading('প্রসবের ফলাফল:'),
          _checkboxTile('জীবিত', _outLive, (v) => _outLive = v ?? false),
          _checkboxTile('সদ্যমৃত', _outStillbirth, (v) => _outStillbirth = v ?? false),
          _checkboxTile('গলিত মৃত শিশু', _outMacerated, (v) => _outMacerated = v ?? false),

          _dropdownField('মিসোপ্রাস্টল ট্যাবলেট খেয়েছেন কি না?', 'নির্বাচন করুন', ['হ্যাঁ', 'না'], icon: Icons.medication_outlined),
        ],
      ),
    );
  }

  // ─── STEP 6: প্রসবোত্তর পরীক্ষা ও রেফারেল ───────────────────────────
  Widget _buildStep6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('প্রসবোত্তর পরীক্ষা', Icons.medical_services_outlined, color: const Color(0xFFD32F2F)),
          _buildPostpartumTable(),

          const Divider(height: 24),
          _inputField('অন্যান্য চিকিৎসা ও উপদেশ:', 'বিস্তারিত লিখুন...', icon: Icons.comment_outlined),

          _subHeading('কোন সমস্যা হলে রেফার করতে হবে:'),
          Row(
            children: [
              Expanded(
                child: _checkboxTile('ইউইউএইচসি', false, (v) {}),
              ),
              Expanded(
                child: _checkboxTile('এমসিডব্লিউসি', false, (v) {}),
              ),
              Expanded(
                child: _checkboxTile('জেলা হাসপাতাল', false, (v) {}),
              ),
            ],
          ),
          _inputField('কোন হাসপাতালে রেফার করা হলো', 'হাসপাতালের নাম', icon: Icons.local_hospital_outlined),
        ],
      ),
    );
  }

  // ─── Obstetric History Table ──────────────────────────────────────────────
  Widget _buildObstetricTable() {
    const headers = ['বছর আগে', 'ধরণ', 'ছেলে', 'মেয়ে', 'জীবিত', 'মৃত', 'সমস্যা'];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F).withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              children: headers.map((h) => Expanded(
                child: Text(h, textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              )).toList(),
            ),
          ),
          const Divider(height: 1),
          // Rows
          ..._obstetricRows.asMap().entries.map((e) => _obstetricRow(e.value, e.key)),
        ],
      ),
    );
  }

  Widget _obstetricRow(Map<String, TextEditingController> row, int idx) {
    final keys = ['yearsAgo', 'type', 'boys', 'girls', 'living', 'dead', 'problem'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
        color: idx.isEven ? Colors.transparent : AppColors.background,
      ),
      child: Row(
        children: keys.map((k) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: TextFormField(
              controller: row[k],
              style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 11),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.4))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.4))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  // ─── Postpartum Table ─────────────────────────────────────────────────────
  Widget _buildPostpartumTable() {
    final rowKeys = _postpartumControllers.keys.toList();
    final headers = ['পরীক্ষার ধরণ', '১ম চেকআপ\n(২৪ ঘণ্টা)', '২য় চেকআপ\n(২-৩ দিন)', '৩য় চেকআপ\n(৭-১৪ দিন)', '৪র্থ চেকআপ\n(৪২-৪৫ দিন)', 'মন্তব্য'];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F).withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              children: headers.asMap().entries.map((e) => Expanded(
                flex: e.key == 0 ? 2 : 1,
                child: Text(e.value, textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              )).toList(),
            ),
          ),
          const Divider(height: 1),
          // Rows
          ...rowKeys.asMap().entries.map((entry) {
            final label = entry.value;
            final controllers = _postpartumControllers[label]!;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
                color: entry.key.isEven ? Colors.transparent : AppColors.background,
              ),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(label, style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  )),
                  ...List.generate(5, (i) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: TextFormField(
                        controller: controllers[i],
                        style: const TextStyle(fontFamily: 'Hind_Siliguri', fontSize: 10),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.4))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.4))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
