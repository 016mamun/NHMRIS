import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/app_colors.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  int _selectedTab = 0; // 0 for government (EPI), 1 for private/optional
  final ScrollController _scrollControllerEpi = ScrollController();
  final ScrollController _scrollControllerPrivate = ScrollController();

  @override
  void dispose() {
    _scrollControllerEpi.dispose();
    _scrollControllerPrivate.dispose();
    super.dispose();
  }

  // EPI Government Vaccines Data
  final List<Map<String, dynamic>> _epiVaccines = [
    {
      'age': 'জন্ম সময়',
      'ageDetail': 'জন্মের ২৪ ঘণ্টার মধ্যে',
      'name': 'বিসিজি (BCG) ও হেপাটাইটিস বি (জন্ম ডোজ)',
      'protection': 'যক্ষ্মা, হেপাটাইটিস বি',
      'status': 'দেওয়া হয়েছে',
      'date': '১০ জানুয়ারি, ২০২৪',
      'color': 0xFFEC407A,
      'isIcon': true,
    },
    {
      'age': '৬ সপ্তাহ',
      'ageDetail': '৬ সপ্তাহ',
      'name': 'পেন্টাভ্যালেন্ট-১ (ডিপিটি + হেপ বি + হিব) ও পোলিও (ওপিভি)-১ ও পিসিভি-১ ও রোটাভাইরাস-১',
      'protection': 'ডিপথেরিয়া, হুপিংকাশি, টিটেনাস, হেপাটাইটিস বি, হিমোফিলাস ইনফ্লুয়েঞ্জা টাইপ বি পোলিও, নিউমোনিয়া, রোটাভাইরাস ডায়রিয়া',
      'status': 'দেওয়া হয়েছে',
      'date': '২১ ফেব্রুয়ারি, ২০২৪',
      'color': 0xFF4CAF50,
      'isIcon': false,
    },
    {
      'age': '১০ সপ্তাহ',
      'ageDetail': '১০ সপ্তাহ',
      'name': 'পেন্টাভ্যালেন্ট-২ ও পোলিও (ওপিভি)-২ ও পিসিভি-২ ও রোটাভাইরাস-২',
      'protection': 'ডিপথেরিয়া, হুপিংকাশি, টিটেনাস, হেপাটাইটিস বি, হিমোফিলাস ইনফ্লুয়েঞ্জা টাইপ বি পোলিও, নিউমোনিয়া, রোটাভাইরাস ডায়রিয়া',
      'status': 'আসবে',
      'date': '২১ মার্চ, ২০২৪',
      'color': 0xFF2196F3,
      'isIcon': false,
    },
    {
      'age': '১৪ সপ্তাহ',
      'ageDetail': '১৪ সপ্তাহ',
      'name': 'পেন্টাভ্যালেন্ট-৩ ও পোলিও (ওপিভি)-৩ ও আইপিভি-১ ও পিসিভি-৩ ও রোটাভাইরাস-৩',
      'protection': 'ডিপথেরিয়া, হুপিংকাশি, টিটেনাস, হেপাটাইটিস বি, হিমোফিলাস ইনফ্লুয়েঞ্জা টাইপ বি পোলিও, নিউমোনিয়া, রোটাভাইরাস ডায়রিয়া',
      'status': 'আসবে',
      'date': '১৮ এপ্রিল, ২০২৪',
      'color': 0xFFFF9800,
      'isIcon': false,
    },
    {
      'age': '৯ মাস',
      'ageDetail': '৯ মাস',
      'name': 'এমআর (হাম-রুবেলা)-১ ও ভিটামিন \'এ\' (১ম ডোজ)',
      'protection': 'হাম, রুবেলা ভিটামিন \'এ\' ঘাটতি',
      'status': 'আসবে',
      'date': '১০ অক্টোবর, ২০২৪',
      'color': 0xFFE91E63,
      'isIcon': false,
    },
    {
      'age': '১৫ মাস',
      'ageDetail': '১৫ মাস',
      'name': 'এমআর (হাম-রুবেলা)-২ ও ভিটামিন \'এ\' (২য় ডোজ)',
      'protection': 'হাম, রুবেলা ভিটামিন \'এ\' ঘাটতি',
      'status': 'আসবে',
      'date': '১০ এপ্রিল, ২০২৫',
      'color': 0xFF9C27B0,
      'isIcon': false,
    },
    {
      'age': '৪-৫ বছর',
      'ageDetail': '৪-৫ বছর',
      'name': 'ডিপিটি বুস্টার ও পোলিও (ওপিভি) বুস্টার ও ভিটামিন \'এ\' (অর্ধবার্ষিক)',
      'protection': 'ডিপথেরিয়া, হুপিংকাশি, টিটেনাস পোলিও, ভিটামিন \'এ\' ঘাটতি',
      'status': 'আসবে',
      'date': '১০ জানুয়ারি, ২০২৯',
      'color': 0xFF4CAF50,
      'isIcon': false,
    },
  ];

  // Private/Additional Vaccines Data
  final List<Map<String, dynamic>> _privateVaccines = [
    {
      'age': '৬ সপ্তাহ থেকে',
      'name': 'হেপাটাইটিস বি (অতিরিক্ত ডোজ)',
      'protection': 'হেপাটাইটিস বি',
      'dose': '৩ ডোজ',
      'schedule': '০, ১ ও ৬ মাস',
    },
    {
      'age': '২ মাস থেকে',
      'name': 'ইনফ্লুয়েঞ্জা (ফ্লু) টিকা',
      'protection': 'ইনফ্লুয়েঞ্জা',
      'dose': 'সাল প্রতি ১ ডোজ',
      'schedule': 'প্রতি বছর (শরৎ/শীতকাল)',
    },
    {
      'age': '৯ মাস থেকে',
      'name': 'টাইফয়েড (কনজুগেট ভ্যাকসিন)',
      'protection': 'টাইফয়েড জ্বর',
      'dose': '১ বা ২ ডোজ',
      'schedule': 'চিকিৎসকের পরামর্শ অনুযায়ী',
    },
    {
      'age': '১ বছর থেকে',
      'name': 'ভ্যারিসেলা (চিকেনপক্স) টিকা',
      'protection': 'চিকেনপক্স',
      'dose': '২ ডোজ',
      'schedule': '১-২ বছর ব্যবধানে',
    },
    {
      'age': '৯-১৪ বছর',
      'name': 'এইচপিভি (HPV) টিকা',
      'protection': 'জরায়ু মুখের ক্যান্সারসহ কিছু ক্যান্সার',
      'dose': '২ বা ৩ ডোজ',
      'schedule': 'চিকিৎসকের পরামর্শ অনুযায়ী',
    },
  ];

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabs(),
          _buildInfoBanner(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  _buildVaccineList(),
                  _buildWarningBanner(),
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
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF1F2F8), // soft lilac blue
            Color(0xFFFDFBFD), // soft light pink
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Icon(Icons.arrow_back, color: Color(0xFF1E1B4B)),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Icon(Icons.notifications_none_rounded, color: Color(0xFF1E1B4B)),
                  ),
                ],
              ),
            ),
            
            // Header Content (Title + Baby Image)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'শিশুর টিকা সূচি'.tr(context),
                          style: TextStyle(
                            
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E1B4B),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'সময়মতো টিকা দিন, শিশু থাকবে সুরক্ষিত'.tr(context),
                          style: TextStyle(
                            
                            fontSize: 13,
                            color: Colors.black.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Cute Baby Image
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.withValues(alpha: 0.1),
                                blurRadius: 12,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/baby_vaccine.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Floating hearts decorations
                        Positioned(
                          left: -10,
                          top: 15,
                          child: Icon(Icons.favorite, color: Colors.pink.withValues(alpha: 0.4), size: 12),
                        ),
                        Positioned(
                          right: -5,
                          bottom: 25,
                          child: Icon(Icons.favorite, color: Colors.pink.withValues(alpha: 0.3), size: 16),
                        ),
                        // Shield badge
                        Positioned(
                          bottom: -5,
                          left: -5,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                )
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xFF9E8EFF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.shield_rounded, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 0 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _selectedTab == 0
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'সরকারি টিকা (EPI)'.tr(context),
                    style: TextStyle(
                      
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _selectedTab == 0 ? const Color(0xFFEC407A) : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 1 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _selectedTab == 1
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'বেসরকারি/অতিরিক্ত টিকা'.tr(context),
                    style: TextStyle(
                      
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _selectedTab == 1 ? const Color(0xFFEC407A) : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E7FF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFF5C6BC0),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'i'.tr(context),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'জাতীয় টিকাদান কর্মসূচি (EPI) অনুযায়ী সরকারি টিকা বিনামূল্যে দেওয়া হয়। বেসরকারি টিকা ঐচ্ছিক, তবে অতিরিক্ত সুরক্ষার জন্য প্রয়োজন হতে পারে।'.tr(context),
              style: TextStyle(
                
                fontSize: 12.5,
                height: 1.4,
                color: Color(0xFF283593),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableHeaderRow(List<String> headers, List<TextAlign> alignments) {
    return TableRow(
      decoration: BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      children: List.generate(headers.length, (index) {
        return TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Text(
              headers[index],
              style: TextStyle(
                
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475569),
              ),
              textAlign: alignments[index],
            ),
          ),
        );
      }),
    );
  }

  TableRow _buildEPITableRow(Map<String, dynamic> row, int index) {
    Widget ageWidget;
    if (row['isIcon'] as bool) {
      ageWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(row['color'] as int).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.child_care_rounded, color: Color(row['color'] as int), size: 18),
          ),
          SizedBox(height: 4),
          Text(
            row['age'] as String,
            style: TextStyle(
              
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      final textParts = (row['age'] as String).split(' ');
      final mainText = textParts.isNotEmpty ? textParts[0] : '';
      final subText = textParts.length > 1 ? textParts[1] : '';

      ageWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Color(row['color'] as int), width: 2),
            ),
            child: Center(
              child: Text(
                mainText,
                style: TextStyle(
                  
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: Color(row['color'] as int),
                ),
              ),
            ),
          ),
          if (subText.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              subText,
              style: TextStyle(
                
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(row['color'] as int),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      );
    }

    final isDone = row['status'] == 'দেওয়া হয়েছে';
    Widget statusWidget = InkWell(
      onTap: () {
        setState(() {
          if (isDone) {
            row['status'] = 'আসবে';
          } else {
            row['status'] = 'দেওয়া হয়েছে';
          }
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFFE8F5E9) : const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDone ? const Color(0xFF81C784) : const Color(0xFF9FA8DA),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isDone ? Icons.check_circle_rounded : Icons.access_time_filled_rounded,
                    color: isDone ? const Color(0xFF2E7D32) : const Color(0xFF3F51B5),
                    size: 11,
                  ),
                  SizedBox(width: 4),
                  Text(
                    row['status'] as String,
                    style: TextStyle(
                      
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: isDone ? const Color(0xFF2E7D32) : const Color(0xFF3F51B5),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Text(
              row['date'] as String,
              style: TextStyle(
                
                fontSize: 9.5,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Center(child: ageWidget),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Center(
              child: Text(
                row['ageDetail'] as String,
                style: TextStyle(
                  
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Text(
              row['name'] as String,
              style: TextStyle(
                
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Text(
              row['protection'] as String,
              style: TextStyle(
                
                fontSize: 11,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Center(child: statusWidget),
          ),
        ),
      ],
    );
  }

  TableRow _buildPrivateTableRow(Map<String, dynamic> row, int index) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Center(
              child: Text(
                row['age'] as String,
                style: TextStyle(
                  
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Text(
              row['name'] as String,
              style: TextStyle(
                
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Text(
              row['protection'] as String,
              style: TextStyle(
                
                fontSize: 11.5,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Center(
              child: Text(
                row['dose'] as String,
                style: TextStyle(
                  
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Center(
              child: Text(
                row['schedule'] as String,
                style: TextStyle(
                  
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVaccineList() {
    if (_selectedTab == 0) {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Title (Fixed)
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.account_balance_rounded, color: Color(0xFF5C6BC0), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'সরকারি টিকা (EPI)'.tr(context),
                    style: TextStyle(
                      
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF283593),
                    ),
                  ),
                ],
              ),
            ),
            
            // Horizontally Scrollable Table
            Scrollbar(
              controller: _scrollControllerEpi,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollControllerEpi,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 860, // Exact and safe total width of all columns: 80 + 100 + 270 + 270 + 120 + 20 (padding)
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(80),
                        1: FixedColumnWidth(100),
                        2: FixedColumnWidth(270),
                        3: FixedColumnWidth(270),
                        4: FixedColumnWidth(120),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        _buildTableHeaderRow(
                          ['বয়স', 'সময়', 'টিকার নাম', 'রোগের বিরুদ্ধে সুরক্ষা', 'অবস্থা'],
                          [TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center],
                        ),
                        ..._epiVaccines.asMap().entries.map((entry) {
                          return _buildEPITableRow(entry.value, entry.key);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Title (Fixed)
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.security_rounded, color: Color(0xFF5C6BC0), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'বেসরকারি / অতিরিক্ত টিকা (ঐচ্ছিক)'.tr(context),
                    style: TextStyle(
                      
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF283593),
                    ),
                  ),
                ],
              ),
            ),
            
            // Horizontally Scrollable Table
            Scrollbar(
              controller: _scrollControllerPrivate,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollControllerPrivate,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 880, // Total columns width: 120 + 230 + 230 + 100 + 160 + 20 (padding)
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(120),
                        1: FixedColumnWidth(230),
                        2: FixedColumnWidth(230),
                        3: FixedColumnWidth(100),
                        4: FixedColumnWidth(160),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        _buildTableHeaderRow(
                          ['বয়স', 'টিকার নাম', 'রোগের বিরুদ্ধে সুরক্ষা', 'ডোজ', 'নির্ধারিত সময়'],
                          [TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center],
                        ),
                        ..._privateVaccines.asMap().entries.map((entry) {
                          return _buildPrivateTableRow(entry.value, entry.key);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildWarningBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFE4E6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, color: Color(0xFFE11D48), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'দ্রষ্টব্য: সময়মতো সব টিকা দিন এবং টিকাদান কার্ড সাথে রাখুন। যে কোনো প্রশ্নে আপনার নিকটস্থ স্বাস্থ্যকেন্দ্রে যোগাযোগ করুন।'.tr(context),
              style: TextStyle(
                
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF9F1239),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
