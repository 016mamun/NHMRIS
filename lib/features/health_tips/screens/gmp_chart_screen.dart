import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class GmpChartScreen extends StatefulWidget {
  const GmpChartScreen({super.key});

  @override
  State<GmpChartScreen> createState() => _GmpChartScreenState();
}

class _GmpChartScreenState extends State<GmpChartScreen> {
  final _weightCtrl = TextEditingController();
  int _ageMonths = 0;
  String _gender = 'female';
  String? _status;
  Color _statusColor = Colors.grey;
  String? _statusEmoji;
  List<Map<String, dynamic>> _entries = [];

  // WHO weight-for-age medians (kg) for girls (0–24 months)
  static const _girlRef = [3.2, 4.2, 5.1, 5.8, 6.4, 6.9, 7.3, 7.6, 7.9, 8.2, 8.5, 8.7, 8.9, 9.2, 9.4, 9.6, 9.8, 10.0, 10.2, 10.4, 10.6, 10.9, 11.1, 11.3, 11.5];
  static const _boyRef  = [3.3, 4.5, 5.6, 6.4, 7.0, 7.5, 7.9, 8.3, 8.6, 8.9, 9.2, 9.4, 9.6, 9.9, 10.1, 10.3, 10.5, 10.7, 10.9, 11.1, 11.3, 11.5, 11.8, 12.0, 12.2];

  String _monthLabel(int m) => 'মাস $m';

  void _addEntry() {
    final w = double.tryParse(_weightCtrl.text);
    if (w == null || w <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('সঠিক ওজন দিন', style: TextStyle(fontFamily: 'Hind_Siliguri')),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    final ref = _gender == 'female' ? _girlRef : _boyRef;
    final expected = ref[_ageMonths];
    final ratio = w / expected;
    String st; Color sc; String se;
    if (ratio >= 0.9) {
      st = 'স্বাভাবিক বৃদ্ধি';
      sc = const Color(0xFF43A047);
      se = '✅';
    } else if (ratio >= 0.8) {
      st = 'মাঝারি অপুষ্টি';
      sc = const Color(0xFFFF8F00);
      se = '⚠️';
    } else {
      st = 'মারাত্মক অপুষ্টি';
      sc = const Color(0xFFE53935);
      se = '🚨';
    }
    setState(() {
      _status = st;
      _statusColor = sc;
      _statusEmoji = se;
      _entries.insert(0, {
        'month': _ageMonths,
        'weight': w,
        'expected': expected,
        'status': st,
        'color': sc,
        'emoji': se,
      });
      _weightCtrl.clear();
    });
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _buildGenderToggle(),
                const SizedBox(height: 16),
                _buildInputCard(),
                const SizedBox(height: 16),
                if (_status != null) _buildCurrentResultCard(),
                if (_entries.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildHistoryCard(),
                ],
                const SizedBox(height: 16),
                _buildRefTable(),
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
                    Text('GMP চার্ট', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('Growth Monitoring Programme — শিশুর বৃদ্ধি পর্যবেক্ষণ', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGenderToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(child: _genderBtn('মেয়ে 👧', 'female', const Color(0xFFEC407A))),
          Expanded(child: _genderBtn('ছেলে 👦', 'male', const Color(0xFF1E88E5))),
        ],
      ),
    );
  }

  Widget _genderBtn(String label, String value, Color color) {
    final selected = _gender == value;
    return GestureDetector(
      onTap: () => setState(() { _gender = value; _status = null; }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: selected ? Colors.white : Colors.grey.shade600)),
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('শিশুর বয়স (মাস)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF00897B),
              thumbColor: const Color(0xFF00897B),
              inactiveTrackColor: const Color(0xFFB2DFDB),
              overlayColor: const Color(0xFF00897B).withValues(alpha: 0.15),
            ),
            child: Slider(
              value: _ageMonths.toDouble(),
              min: 0, max: 24, divisions: 24,
              label: '${_ageMonths} মাস',
              onChanged: (v) => setState(() { _ageMonths = v.round(); _status = null; }),
            ),
          ),
          Center(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(10)),
            child: Text('${_ageMonths} মাস', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF00695C))),
          )),
          const SizedBox(height: 16),
          const Text('বর্তমান ওজন (কেজি)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          TextField(
            controller: _weightCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
            decoration: InputDecoration(
              hintText: 'যেমন: 7.5',
              hintStyle: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
              prefixIcon: const Icon(Icons.monitor_weight_rounded, color: Color(0xFF00897B), size: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF00897B), width: 1.5)),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addEntry,
              icon: const Icon(Icons.bar_chart_rounded),
              label: const Text('বৃদ্ধি পর্যবেক্ষণ করুন', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00897B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentResultCard() {
    final ref = _gender == 'female' ? _girlRef : _boyRef;
    final expected = ref[_ageMonths];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _statusColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _statusColor.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Text('$_statusEmoji $_status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: _statusColor)),
          const SizedBox(height: 8),
          Text('প্রত্যাশিত ওজন: ${expected.toStringAsFixed(1)} কেজি', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          if (_status == 'মাঝারি অপুষ্টি' || _status == 'মারাত্মক অপুষ্টি')
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('⚠️ দ্রুত স্বাস্থ্যকর্মীর পরামর্শ নিন।', style: TextStyle(fontSize: 13, color: _statusColor, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('পর্যবেক্ষণের ইতিহাস', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          ..._entries.take(5).map((e) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: (e['color'] as Color).withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(e['emoji'] as String, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${e['month']} মাস — ${(e['weight'] as double).toStringAsFixed(1)} কেজি', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      Text('প্রত্যাশিত: ${(e['expected'] as double).toStringAsFixed(1)} কেজি', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: (e['color'] as Color).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                  child: Text(e['status'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: e['color'] as Color)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRefTable() {
    final ref = _gender == 'female' ? _girlRef : _boyRef;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHO রেফারেন্স চার্ট (${_gender == 'female' ? 'মেয়ে' : 'ছেলে'})',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Table(
            border: TableBorder.all(color: AppColors.border.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8)),
            children: [
              const TableRow(decoration: BoxDecoration(color: Color(0xFFE0F2F1)), children: [
                Padding(padding: EdgeInsets.all(8), child: Text('বয়স (মাস)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF00695C)))),
                Padding(padding: EdgeInsets.all(8), child: Text('গড় ওজন (কেজি)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF00695C)))),
              ]),
              ...List.generate(13, (i) => i * 2).map((m) => TableRow(children: [
                Padding(padding: const EdgeInsets.all(8), child: Text('$m', style: const TextStyle(fontSize: 12, color: AppColors.textPrimary))),
                Padding(padding: const EdgeInsets.all(8), child: Text(ref[m].toStringAsFixed(1), style: const TextStyle(fontSize: 12, color: AppColors.textPrimary))),
              ])),
            ],
          ),
        ],
      ),
    );
  }
}
