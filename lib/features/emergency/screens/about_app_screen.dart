import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final List<String> _feedbacks = [];
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    if (_feedbackController.text.isNotEmpty) {
      setState(() {
        _feedbacks.insert(0, _feedbackController.text);
        _feedbackController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('আপনার মূল্যবান মতামত সফলভাবে পাঠানো হয়েছে!', style: TextStyle(fontFamily: 'Hind_Siliguri')),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('অ্যাপ সম্পর্কে জানুন', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1E1B4B)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // App Branding Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFEEF2FF), Color(0xFFFFF1F2)],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                    ),
                    child: Center(
                      child: Icon(Icons.favorite_rounded, color: AppColors.primary, size: 36),
                    ),
                  ),
                  SizedBox(height: 16),
                  const Text(
                    'MHRIS',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF1E1B4B), letterSpacing: 1.2),
                  ),
                  SizedBox(height: 4),
                  const Text(
                    'মাতৃ ও শিশু স্বাস্থ্য রেকর্ড তথ্য ব্যবস্থা',
                    style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      'সংস্করণ: ১.২.০ (পাবলিক বেটা)',
                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Our Mission
            _buildSectionHeader('আমাদের লক্ষ্য ও উদ্দেশ্য', Icons.emoji_objects_outlined, AppColors.primary),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Text(
                'বাংলাদেশ সরকারের জাতীয় মাতৃ ও শিশু স্বাস্থ্য সুরক্ষা লক্ষ্যকে সামনে রেখে MHRIS অ্যাপটি তৈরি করা হয়েছে। আমাদের লক্ষ্য হলো গর্ভকালীন জটিলতা দূরীকরণ, সঠিক সময়ে স্বাস্থ্যসেবা নিশ্চিতকরণ, শিশু জন্মের পর টিকাদানের সময়সূচি ট্র্যাকিং এবং জরুরি রক্তের প্রয়োজনে দ্রুত দাতা খুঁজে দেওয়ার মাধ্যমে নিরাপদ মাতৃত্ব ও সুস্থ শিশু বিকাশকে এক ক্লিকে সহজসাধ্য করা।',
                style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF475569)),
              ),
            ),
            SizedBox(height: 24),

            // Key Modules
            _buildSectionHeader('মূল ড্যাশবোর্ড মডিউলসমূহ', Icons.widgets_outlined, const Color(0xFF0D9488)),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.2,
              children: [
                _buildModuleItem(Icons.pregnant_woman, 'গর্ভকালীন ট্র্যাকার (ANC)'),
                _buildModuleItem(Icons.vaccines_rounded, 'শিশুর টিকা সূচি (EPI)'),
                _buildModuleItem(Icons.ads_click_rounded, 'গর্ভের কিক কাউন্টার'),
                _buildModuleItem(Icons.rice_bowl_rounded, 'গর্ভকালীন পুষ্টি গাইড'),
                _buildModuleItem(Icons.bloodtype_rounded, 'জরুরি রক্তের গ্রুপ'),
                _buildModuleItem(Icons.local_hospital_rounded, 'হাসপাতাল ডিরেক্টরি'),
              ],
            ),
            SizedBox(height: 24),

            // Partnership Badges
            _buildSectionHeader('সহযোগিতা ও পার্টনারশিপ', Icons.handshake_outlined, const Color(0xFF4F46E5)),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPartnerBadge(Icons.health_and_safety_rounded, 'স্বাস্থ্য ও পরিবার কল্যাণ মন্ত্রনালয়', const Color(0xFF16A34A)),
                  Container(width: 1, height: 40, color: Colors.grey.shade200),
                  _buildPartnerBadge(Icons.child_friendly_rounded, 'জাতিসংঘ শিশু তহবিল (UNICEF)', const Color(0xFF2563EB)),
                  Container(width: 1, height: 40, color: Colors.grey.shade200),
                  _buildPartnerBadge(Icons.public_rounded, 'বিশ্ব স্বাস্থ্য সংস্থা (WHO)', const Color(0xFF0D9488)),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Developers Credit
            _buildSectionHeader('ডেভেলপার ক্রেডিট ও সহায়তা', Icons.code_rounded, Colors.black87),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MHRIS টেকনিক্যাল টিম',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'বাংলাদেশ হেলথ আইটি ডেভেলপমেন্ট টিম দ্বারা পরিকল্পিত ও সফটওয়্যার ডিজাইন করা হয়েছে।',
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade400, height: 1.4),
                  ),
                  SizedBox(height: 12),
                  const Divider(color: Colors.white24),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'সহায়তা হটলাইন: support@mhris.org',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade300, letterSpacing: 0.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('ইমেইল ক্লায়েন্ট খোলা হচ্ছে...', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                              backgroundColor: AppColors.primary,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
                          child: const Text('মেইল করুন', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Feedback Portal
            _buildSectionHeader('আপনার মতামত জানান', Icons.rate_review_outlined, AppColors.primary),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _feedbackController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: 'অ্যাপের উন্নয়ন বা যেকোনো সুনির্দিষ্ট ফিডব্যাক এখানে লিখুন...',
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      border: InputBorder.none,
                      fillColor: Color(0xFFF8FAFC),
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: _submitFeedback,
                        child: const Text('পাঠিয়ে দিন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      )
                    ],
                  ),

                  // Stateful Feedbacks Feed
                  if (_feedbacks.isNotEmpty) ...[
                    SizedBox(height: 16),
                    const Divider(),
                    SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('আমার পাঠানো মতামতসমূহ:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _feedbacks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            _feedbacks[index],
                            style: TextStyle(fontSize: 11.5, color: Colors.black87),
                          ),
                        );
                      },
                    )
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
        ),
      ],
    );
  }

  Widget _buildModuleItem(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPartnerBadge(IconData icon, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(fontSize: 8.5, color: Color(0xFF475569), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
