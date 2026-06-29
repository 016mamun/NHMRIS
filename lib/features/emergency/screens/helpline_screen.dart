import '../../../core/localization/language_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_translations.dart';
import '../widgets/mock_dialer_widget.dart';

class HelplineScreen extends StatefulWidget {
  const HelplineScreen({super.key});

  @override
  State<HelplineScreen> createState() => _HelplineScreenState();
}

class _HelplineScreenState extends State<HelplineScreen> {
  // Static Helpline Database
  final List<Map<String, dynamic>> _nationalHelplines = [
    {
      'number': '৯৯৯',
      'title': 'জাতীয় জরুরি সেবা (National Emergency Service)',
      'desc': 'পুলিশ, ফায়ার সার্ভিস ও অ্যাম্বুলেন্স সেবার জন্য যেকোনো মোবাইল থেকে কল করুন।',
      'hours': '২৪ ঘণ্টা সচল',
      'isFree': true,
      'color': 0xFFE11D48, // Rose/Red
      'icon': Icons.local_police_rounded,
    },
    {
      'number': '১৬২৬৩',
      'title': 'স্বাস্থ্য বাতায়ন (Sashthya Batayon)',
      'desc': 'সরকারি স্বাস্থ্য তথ্য ও চিকিৎসকের জরুরি পরামর্শের নির্ভরযোগ্য হটলাইন।',
      'hours': '২৪ ঘণ্টা সচল',
      'isFree': false,
      'color': 0xFF2563EB, // Blue
      'icon': Icons.health_and_safety_rounded,
    },
    {
      'number': '১০৯',
      'title': 'নারী ও শিশু নির্যাতন প্রতিরোধ সেল',
      'desc': 'যেকোনো ধরণের নির্যাতন বা বাল্যবিবাহ প্রতিরোধের জরুরি সাহায্য কেন্দ্র।',
      'hours': '২৪ ঘণ্টা সচল',
      'isFree': true,
      'color': 0xFF9333EA, // Purple
      'icon': Icons.admin_panel_settings_rounded,
    },
    {
      'number': '৩৩৩',
      'title': 'জাতীয় তথ্য ও সরকারি সেবা',
      'desc': 'সরকারি তথ্য, সামাজিক সাহায্য ও বিশেষজ্ঞ পরামর্শ জানার পোর্টাল।',
      'hours': '২৪ ঘণ্টা সচল',
      'isFree': false,
      'color': 0xFF0D9488, // Teal
      'icon': Icons.info_outline_rounded,
    },
  ];

  final List<Map<String, dynamic>> _maternalHelplines = [
    {
      'number': '০১৮৭৭৭২২২২২',
      'title': 'গর্ভকালীন ও মাতৃত্ব পরামর্শ লাইন',
      'desc': 'বিশেষজ্ঞ ধাত্রী এবং চিকিৎসকের দ্বারা গর্ভকালীন যেকোনো জটিলতার জরুরি পরামর্শ কেন্দ্র।',
      'hours': 'সকাল ৮টা - রাত ১০টা',
      'isFree': false,
      'color': 0xFFDB2777, // Pink
      'icon': Icons.pregnant_woman_rounded,
    },
    {
      'number': '০১৭১১২২৩৩৪৪',
      'title': 'শিশু মনস্তত্ত্ব ও মানসিক স্বাস্থ্য',
      'desc': 'প্রসব পরবর্তী ডিপ্রেশন, মানসিক অবসাদ এবং শিশুর প্রাথমিক আচরণের সাপোর্ট ডেস্ক।',
      'hours': 'সকাল ৯টা - বিকেল ৫টা',
      'isFree': false,
      'color': 0xFFEA580C, // Orange
      'icon': Icons.psychology_rounded,
    },
    {
      'number': '০১৯৯৯৮৮৭৭৬৬',
      'title': 'দুগ্ধদান ও নবজাতকের পুষ্টি সহায়তা',
      'desc': 'ব্রেস্টফিডিং কৌশল, ল্যাকটেশন সাপোর্ট এবং নবজাতকের সঠিক পুষ্টি পরিকল্পনা ডেস্ক।',
      'hours': '২৪ ঘণ্টা সচল',
      'isFree': false,
      'color': 0xFF16A34A, // Green
      'icon': Icons.child_care_rounded,
    },
  ];

  void _triggerCall(String title, String phone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MockDialerWidget(name: title, phone: phone),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('জরুরি যোগাযোগ ও হেল্পলাইন'.tr(context), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            Text(
              'গর্ভকালীন বা অন্য যেকোনো জরুরি মুহূর্তে নিচের টোল-ফ্রি বা বিশেষজ্ঞ হেল্পলাইনগুলোতে তাৎক্ষণিক পরামর্শ ও সহায়তার জন্য কল করুন।'.tr(context),
              style: TextStyle(fontSize: 13, height: 1.4, color: Colors.black54, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),

            // Section 1: National Services
            Row(
              children: [
                Icon(Icons.stars_rounded, color: AppColors.primary, size: 20),
                SizedBox(width: 6),
                Text(
                  'জাতীয় জরুরি নম্বরসমূহ'.tr(context),
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
                ),
              ],
            ),
            SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _nationalHelplines.length,
              itemBuilder: (ctx, index) {
                final line = _nationalHelplines[index];
                return _buildHelplineCard(ctx, line);
              },
            ),
            SizedBox(height: 24),

            // Section 2: Maternal Services
            Row(
              children: [
                Icon(Icons.child_friendly_rounded, color: Color(0xFFDB2777), size: 20),
                SizedBox(width: 6),
                Text(
                  'মাতৃত্ব ও প্রসূতি বিশেষজ্ঞ লাইনসমূহ'.tr(context),
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
                ),
              ],
            ),
            SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _maternalHelplines.length,
              itemBuilder: (ctx, index) {
                final line = _maternalHelplines[index];
                return _buildHelplineCard(ctx, line);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelplineCard(BuildContext context, Map<String, dynamic> line) {
    final isFree = line['isFree'] as bool;
    final color = Color(line['color'] as int);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(line['icon'] as IconData, color: color, size: 22),
            ),
          ),
          SizedBox(width: 14),

          // Details Expanded
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      line['number'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isFree ? const Color(0xFFE8F5E9) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isFree ? 'টোল ফ্রি' : 'সাধারণ রেট',
                        style: TextStyle(
                          
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: isFree ? const Color(0xFF2E7D32) : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  line['title'] as String,
                  style: TextStyle(
                    
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  line['desc'] as String,
                  style: TextStyle(
                    
                    fontSize: 11.5,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 12),

                // Lower Info row (Hours + Call Button)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, color: Colors.grey, size: 12),
                        SizedBox(width: 4),
                        Text(
                          line['hours'] as String,
                          style: TextStyle(
                            
                            fontSize: 10.5,
                            color: Color(0xFF475569),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        minimumSize: Size.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () => _triggerCall(line['title'] as String, line['number'] as String),
                      icon: Icon(Icons.phone, size: 12, color: Colors.white),
                      label: Text(
                        'কল করুন'.tr(context),
                        style: TextStyle(
                          
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
