import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GorvokalinShasthoSomosshaScreen extends StatefulWidget {
  const GorvokalinShasthoSomosshaScreen({super.key});

  @override
  State<GorvokalinShasthoSomosshaScreen> createState() => _GorvokalinShasthoSomosshaScreenState();
}

class _GorvokalinShasthoSomosshaScreenState extends State<GorvokalinShasthoSomosshaScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedSymptom;

  final List<Map<String, dynamic>> _symptoms = [
    {'label': 'বমি বমি ভাব', 'emoji': '🤢', 'severity': 'স্বাভাবিক', 'color': const Color(0xFF43A047)},
    {'label': 'মাথাব্যথা', 'emoji': '🤕', 'severity': 'পর্যবেক্ষণ করুন', 'color': const Color(0xFFFB8C00)},
    {'label': 'পা ফোলা', 'emoji': '🦵', 'severity': 'পর্যবেক্ষণ করুন', 'color': const Color(0xFFFB8C00)},
    {'label': 'অতিরিক্ত বমি', 'emoji': '😷', 'severity': 'ডাক্তার দেখান', 'color': const Color(0xFFE53935)},
    {'label': 'তীব্র পেট ব্যথা', 'emoji': '😣', 'severity': 'জরুরি সেবা নিন', 'color': const Color(0xFFB71C1C)},
    {'label': 'রক্তস্রাব', 'emoji': '🚨', 'severity': 'জরুরি সেবা নিন', 'color': const Color(0xFFB71C1C)},
    {'label': 'শ্বাসকষ্ট', 'emoji': '😮', 'severity': 'ডাক্তার দেখান', 'color': const Color(0xFFE53935)},
    {'label': 'দৃষ্টি সমস্যা', 'emoji': '👁️', 'severity': 'ডাক্তার দেখান', 'color': const Color(0xFFE53935)},
  ];

  final List<Map<String, dynamic>> _warningSigns = [
    {'sign': 'অস্বাভাবিক রক্তস্রাব', 'detail': 'যেকোনো সময় রক্তস্রাব হলে দ্রুত হাসপাতালে যান।', 'urgency': 'অতি জরুরি'},
    {'sign': 'তীব্র পেট ব্যথা', 'detail': 'হঠাৎ তীব্র বা ক্রমাগত পেট ব্যথা গুরুতর জটিলতার লক্ষণ হতে পারে।', 'urgency': 'অতি জরুরি'},
    {'sign': 'প্রচণ্ড মাথাব্যথা', 'detail': 'বিশেষত উচ্চ রক্তচাপের সাথে মাথাব্যথা Preeclampsia হতে পারে।', 'urgency': 'অতি জরুরি'},
    {'sign': 'শিশুর নড়াচড়া কমে যাওয়া', 'detail': '২৮ সপ্তাহের পর ১২ ঘণ্টায় ১০টির কম নড়াচড়া হলে পরীক্ষা করান।', 'urgency': 'দ্রুত যান'},
    {'sign': 'দৃষ্টি ঝাপসা', 'detail': 'চোখে ঝলকানি বা ঝাপসা দেখা উচ্চ রক্তচাপের লক্ষণ।', 'urgency': 'দ্রুত যান'},
    {'sign': 'পানি ভাঙা', 'detail': 'সময়ের আগে অ্যামনিয়াটিক ফ্লুইড বের হলে দ্রুত হাসপাতালে যান।', 'urgency': 'অতি জরুরি'},
  ];

  final List<Map<String, dynamic>> _faqs = [
    {
      'q': 'গর্ভাবস্থায় বমি স্বাভাবিক কি?',
      'a': 'হ্যাঁ, বিশেষত ১ম ত্রৈমাসিকে সকালে বমি বা বমিভাব স্বাভাবিক। তবে অতিরিক্ত বমিতে চিকিৎসা নেওয়া উচিত।',
      'open': false,
    },
    {
      'q': 'পা ফোলা কখন বিপজ্জনক?',
      'a': 'হঠাৎ বা তীব্র পা ফোলা, বিশেষত উচ্চ রক্তচাপ বা মাথাব্যথার সাথে, Preeclampsia-র লক্ষণ হতে পারে।',
      'open': false,
    },
    {
      'q': 'গর্ভাবস্থায় জ্বর হলে কী করবেন?',
      'a': 'প্যারাসিটামল সেফ। তবে ১০২°F বা বেশি জ্বর হলে দ্রুত ডাক্তারের পরামর্শ নিন।',
      'open': false,
    },
    {
      'q': 'কতটুকু ওজন বাড়া স্বাভাবিক?',
      'a': 'পুরো গর্ভাবস্থায় ১১-১৬ কেজি পর্যন্ত ওজন বাড়া স্বাভাবিক। ডাক্তার আপনার BMI অনুযায়ী পরামর্শ দেবেন।',
      'open': false,
    },
    {
      'q': 'গর্ভাবস্থায় কোন ওষুধ নিরাপদ?',
      'a': 'সব ওষুধ গ্রহণের আগে ডাক্তারের পরামর্শ নিন। প্যারাসিটামল সাধারণত নিরাপদ।',
      'open': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSymptomChecker(),
                _buildWarningSignsTab(),
                _buildFaqTab(),
                _buildDoctorCallTab(),
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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
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
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('গর্ভকালীন স্বাস্থ্য সমস্যা', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('সমস্যা চিহ্নিত করুন ও সমাধান পান', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              const Text('🩺', style: TextStyle(fontSize: 28)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.grey.shade500,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        tabs: const [
          Tab(text: 'লক্ষণ চেকার'),
          Tab(text: 'বিপদের লক্ষণ'),
          Tab(text: 'FAQ'),
          Tab(text: 'ডাক্তার কল'),
        ],
      ),
    );
  }

  Widget _buildSymptomChecker() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard('আপনার বর্তমান সমস্যাটি বেছে নিন', const Color(0xFF7C3AED)),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.2),
          itemCount: _symptoms.length,
          itemBuilder: (_, i) {
            final s = _symptoms[i];
            final selected = _selectedSymptom == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedSymptom = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? (s['color'] as Color).withOpacity(0.12) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: selected ? s['color'] as Color : AppColors.border.withOpacity(0.4), width: selected ? 2 : 1),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    Text(s['emoji'] as String, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(s['label'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: selected ? s['color'] as Color : AppColors.textPrimary))),
                  ],
                ),
              ),
            );
          },
        ),
        if (_selectedSymptom != null) ...[
          const SizedBox(height: 16),
          _resultCard(_symptoms[_selectedSymptom!]),
        ],
      ],
    );
  }

  Widget _resultCard(Map<String, dynamic> symptom) {
    final color = symptom['color'] as Color;
    final isUrgent = (symptom['urgency'] ?? symptom['severity']) == 'জরুরি সেবা নিন';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(18), border: Border.all(color: color.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(symptom['emoji'] as String, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(symptom['label'] as String, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                      child: Text(symptom['severity'] as String, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isUrgent) ...[
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: color, minimumSize: const Size(double.infinity, 44), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              icon: const Icon(Icons.call_rounded, color: Colors.white, size: 18),
              label: const Text('এখনই ডাক্তারকে কল করুন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWarningSignsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard('এই লক্ষণগুলো দেখা দিলে দেরি না করে হাসপাতালে যান।', const Color(0xFFE53935)),
        const SizedBox(height: 14),
        ..._warningSigns.map((sign) => _warningCard(sign)).toList(),
      ],
    );
  }

  Widget _warningCard(Map<String, dynamic> sign) {
    final isVeryUrgent = sign['urgency'] == 'অতি জরুরি';
    final color = isVeryUrgent ? const Color(0xFFE53935) : const Color(0xFFFB8C00);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(isVeryUrgent ? Icons.warning_rounded : Icons.info_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(sign['sign'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                      child: Text(sign['urgency'] as String, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(sign['detail'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ..._faqs.asMap().entries.map((e) {
          final idx = e.key;
          final faq = e.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                leading: Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text('Q${idx + 1}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary))),
                ),
                title: Text(faq['q'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                children: [
                  Text(faq['a'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDoctorCallTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF7C4FC4), Color(0xFF5B2D9A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text('🆘', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 12),
              const Text('জরুরি সেবা দরকার?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 6),
              const Text('যেকোনো জরুরি অবস্থায় নিচের নম্বরে কল করুন', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white70)),
              const SizedBox(height: 20),
              _callButton('জাতীয় স্বাস্থ্য সেবা হেল্পলাইন', '16000', Icons.call_rounded, Colors.white),
              const SizedBox(height: 10),
              _callButton('জরুরি এ্যাম্বুলেন্স', '999', Icons.local_hospital_rounded, Colors.white),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _contactCard('নিকটস্থ স্বাস্থ্য কেন্দ্র', 'আপনার এলাকার UHC বা UHFWC', Icons.location_on_rounded, const Color(0xFF00897B)),
        const SizedBox(height: 10),
        _contactCard('গাইনোকোলজিস্ট পরামর্শ', 'ডাক্তারের সাথে অনলাইন পরামর্শ', Icons.video_call_rounded, const Color(0xFF1E88E5)),
      ],
    );
  }

  Widget _callButton(String label, String number, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color))),
            Text(number, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16),
        ],
      ),
    );
  }

  Widget _infoCard(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.25))),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4))),
        ],
      ),
    );
  }
}
