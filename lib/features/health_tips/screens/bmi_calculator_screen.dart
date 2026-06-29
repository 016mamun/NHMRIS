import '../../../core/localization/language_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_translations.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  double? _bmi;
  String _category = '';
  Color _categoryColor = Colors.grey;
  bool _isPregnant = false;

  void _calculate() {
    final h = double.tryParse(_heightCtrl.text);
    final w = double.tryParse(_weightCtrl.text);
    if (h == null || w == null || h <= 0 || w <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('সঠিক তথ্য দিন'.tr(context), style: TextStyle(fontFamily: 'Hind_Siliguri')),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    final hm = h / 100;
    final bmi = w / (hm * hm);
    String cat;
    Color color;
    if (bmi < 18.5) {
      cat = 'কম ওজন';
      color = const Color(0xFF1E88E5);
    } else if (bmi < 25) {
      cat = 'স্বাভাবিক';
      color = const Color(0xFF43A047);
    } else if (bmi < 30) {
      cat = 'অতিরিক্ত ওজন';
      color = const Color(0xFFFF8F00);
    } else {
      cat = 'স্থূলতা';
      color = const Color(0xFFE53935);
    }
    setState(() {
      _bmi = bmi;
      _category = cat;
      _categoryColor = color;
    });
  }

  @override
  void dispose() {
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                children: [
                  _buildToggle(),
                  SizedBox(height: 20),
                  _buildInputCard(),
                  SizedBox(height: 20),
                  if (_bmi != null) ...[
                    _buildResultCard(),
                    SizedBox(height: 20),
                  ],
                  _buildBmiChart(),
                  SizedBox(height: 20),
                  if (_isPregnant) _buildPregnancyNote(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('BMI Calculator'.tr(context), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                      Text('শরীরের ভর সূচক নির্ণয়'.tr(context), style: TextStyle(fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isPregnant = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !_isPregnant ? const Color(0xFF1E88E5) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('সাধারণ BMI'.tr(context), textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: !_isPregnant ? Colors.white : Colors.grey.shade600)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isPregnant = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _isPregnant ? const Color(0xFFEC407A) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('গর্ভকালীন BMI'.tr(context), textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _isPregnant ? Colors.white : Colors.grey.shade600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          _buildInput('উচ্চতা (সেমি)', 'যেমন: 158', _heightCtrl, Icons.height_rounded),
          SizedBox(height: 16),
          _buildInput(_isPregnant ? 'বর্তমান ওজন (কেজি)' : 'ওজন (কেজি)', 'যেমন: 55', _weightCtrl, Icons.monitor_weight_rounded),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('BMI হিসাব করুন'.tr(context), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, String hint, TextEditingController ctrl, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        SizedBox(height: 8),
        TextField(
          controller: ctrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            prefixIcon: Icon(icon, color: const Color(0xFF1E88E5), size: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 1.5)),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _categoryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _categoryColor.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            _bmi!.toStringAsFixed(1),
            style: TextStyle(fontSize: 52, fontWeight: FontWeight.w900, color: _categoryColor),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(color: _categoryColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
            child: Text(_category, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _categoryColor)),
          ),
          SizedBox(height: 8),
          Text('আপনার BMI স্কোর'.tr(context), style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildBmiChart() {
    final ranges = [
      {'label': 'কম ওজন', 'range': '< ১৮.৫', 'color': const Color(0xFF1E88E5)},
      {'label': 'স্বাভাবিক', 'range': '১৮.৫ – ২৪.৯', 'color': const Color(0xFF43A047)},
      {'label': 'অতিরিক্ত ওজন', 'range': '২৫ – ২৯.৯', 'color': const Color(0xFFFF8F00)},
      {'label': 'স্থূলতা', 'range': '≥ ৩০', 'color': const Color(0xFFE53935)},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BMI রেফারেন্স চার্ট'.tr(context), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          SizedBox(height: 12),
          ...ranges.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(width: 12, height: 12, decoration: BoxDecoration(color: r['color'] as Color, shape: BoxShape.circle)),
                SizedBox(width: 10),
                Expanded(child: Text(r['label'] as String, style: TextStyle(fontSize: 13, color: AppColors.textPrimary))),
                Text(r['range'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: r['color'] as Color)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPregnancyNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEC407A).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('🤰'.tr(context), style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text('গর্ভাবস্থায় ওজন বৃদ্ধির গাইড'.tr(context), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD1457))),
            ],
          ),
          SizedBox(height: 10),
          Text('• স্বাভাবিক BMI থাকলে: ১১.৫–১৬ কেজি বাড়া উচিত\n• কম ওজন থাকলে: ১২.৫–১৮ কেজি বাড়া উচিত\n• অতিরিক্ত ওজন থাকলে: ৭–১১.৫ কেজি বাড়া উচিত\n\nসঠিক ওজন ব্যবস্থাপনার জন্য ডাক্তারের পরামর্শ নিন।'.tr(context),
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.6),
          ),
        ],
      ),
    );
  }
}
