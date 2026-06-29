import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/mock_dialer_widget.dart';

class HospitalDirectoryScreen extends StatefulWidget {
  const HospitalDirectoryScreen({super.key});

  @override
  State<HospitalDirectoryScreen> createState() => _HospitalDirectoryScreenState();
}

class _HospitalDirectoryScreenState extends State<HospitalDirectoryScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'সব হাসপাতাল';
  String _selectedDivision = 'সব বিভাগ';

  final List<String> _categories = ['সব হাসপাতাল', 'সরকারি', 'বেসরকারি', 'মা ও শিশু ক্লিনিক'];
  final List<String> _divisions = ['সব বিভাগ', 'ঢাকা', 'চট্টগ্রাম', 'রাজশাহী', 'খুলনা', 'সিলেট'];

  // Static Hospital Directory Database
  final List<Map<String, dynamic>> _hospitals = [
    {
      'name': 'আজিমপুর মাতৃসদন ও শিশু স্বাস্থ্য হাসপাতাল',
      'type': 'মা ও শিশু ক্লিনিক',
      'division': 'ঢাকা',
      'address': 'আজিমপুর, ঢাকা-১২০৫',
      'phone': '02-9662001',
      'hotline': '01712345678',
      'isGovt': true,
      'services': ['২৪/৭ প্রসব সেবা', 'গর্ভকালীন চেকআপ (ANC)', 'এনআইসিইউ (NICU)', 'ল্যাবরেটরি', 'অ্যাম্বুলেন্স'],
      'doctors': 'ডাঃ সুফিয়া বেগম (স্ত্রী রোগ ও প্রসূতি বিশেষজ্ঞ)',
    },
    {
      'name': 'ঢাকা মেডিকেল কলেজ হাসপাতাল (DMCH)',
      'type': 'সরকারি',
      'division': 'ঢাকা',
      'address': 'বখশিবাজার, ঢাকা-১০০০',
      'phone': '02-55165088',
      'hotline': '01911998877',
      'isGovt': true,
      'services': ['জরুরি গর্ভকালীন বিভাগ', 'ব্লাড ব্যাংক', 'এনআইসিইউ (NICU)', 'সিসিইউ (CCU)', '২৪ ঘণ্টা ইমার্জেন্সি'],
      'doctors': 'ডাঃ কামাল উদ্দিন (অধ্যাপক, গাইনি বিভাগ)',
    },
    {
      'name': 'আদ্-দ্বীন উইমেন্স মেডিকেল কলেজ হাসপাতাল',
      'type': 'বেসরকারি',
      'division': 'ঢাকা',
      'address': '২ বড় মগবাজার, ঢাকা-১২১৭',
      'phone': '02-9353391',
      'hotline': '01713488411',
      'isGovt': false,
      'services': ['সাশ্রয়ী প্রসব সেবা', 'নরমাল ডেলিভারি সেন্টার', 'এনআইসিইউ (NICU)', 'শিশু স্বাস্থ্য', '২৪/৭ ইমার্জেন্সি'],
      'doctors': 'ডাঃ ফারহানা আক্তার (প্রসূতি রোগ বিশেষজ্ঞ)',
    },
    {
      'name': 'চট্টগ্রাম মেডিকেল কলেজ হাসপাতাল (CMCH)',
      'type': 'সরকারি',
      'division': 'চট্টগ্রাম',
      'address': 'কে বি ফজলুল কাদের রোড, চট্টগ্রাম',
      'phone': '031-619400',
      'hotline': '01819665544',
      'isGovt': true,
      'services': ['২৪ ঘণ্টা প্রসূতি সেবা', 'ব্লাড ব্যাংক', 'আইসিইউ (ICU)', 'শিশুরোগ বিভাগ', 'অ্যাম্বুলেন্স'],
      'doctors': 'ডাঃ রেহানা আক্তার (গাইনি কনসালটেন্ট)',
    },
    {
      'name': 'সাফাত হাসপাতাল ও মেটারনিটি সেন্টার',
      'type': 'মা ও শিশু ক্লিনিক',
      'division': 'সিলেট',
      'address': 'দরগাহ গেট, সিলেট',
      'phone': '0821-714000',
      'hotline': '01711223399',
      'isGovt': false,
      'services': ['গর্ভকালীন ও প্রসবোত্তর সেবা', 'পেইনলেস নরমাল ডেলিভারি', 'ল্যাব টেষ্ট', 'ফার্মেসী'],
      'doctors': 'ডাঃ আয়েশা সিদ্দিকা (স্ত্রী রোগ বিশেষজ্ঞ)',
    },
    {
      'name': 'খুলনা শিশু হাসপাতাল ও মাতৃসদন',
      'type': 'মা ও শিশু ক্লিনিক',
      'division': 'খুলনা',
      'address': 'সদর হাসপাতাল রোড, খুলনা',
      'phone': '041-721200',
      'hotline': '01912554433',
      'isGovt': false,
      'services': ['শিশু বিশেষজ্ঞ সেবা', 'স্বল্পমূল্যে সিজারিয়ান', 'টিকা কেন্দ্র', 'অ্যাম্বুলেন্স'],
      'doctors': 'ডাঃ মোঃ আব্দুল হাকিম (নবজাতক ও শিশু রোগ)',
    },
  ];

  void _triggerCall(String name, String phone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MockDialerWidget(name: name, phone: phone),
    );
  }

  void _viewDirections(String hospitalName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFF0F172A), // Premium sleek night map look
        title: Row(
          children: [
            const Icon(Icons.navigation_rounded, color: AppColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                hospitalName,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mock map visual layout
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade800),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Abstract map paths
                  CustomPaint(
                    size: const Size(double.infinity, 180),
                    painter: MapPainter(),
                  ),
                  // Current location indicator
                  const Positioned(
                    left: 40,
                    bottom: 40,
                    child: Column(
                      children: [
                        Icon(Icons.my_location, color: Colors.blue, size: 20),
                        Text('আমার অবস্থান', style: TextStyle(color: Colors.white, fontSize: 8)),
                      ],
                    ),
                  ),
                  // Hospital Location indicator
                  const Positioned(
                    right: 40,
                    top: 30,
                    child: Column(
                      children: [
                        Icon(Icons.location_on_rounded, color: AppColors.error, size: 24),
                        Text('হাসপাতাল', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.gps_fixed_rounded, color: AppColors.primary, size: 12),
                        SizedBox(width: 6),
                        Text(
                          'জিপিএস রুট সক্রিয়',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_car_rounded, color: Colors.white70, size: 16),
                    SizedBox(width: 6),
                    Text('দূরত্ব: ৪.৮ কি.মি.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_filled_rounded, color: Colors.white70, size: 16),
                    SizedBox(width: 6),
                    Text('সময়: ১২ মিনিট', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            )
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('বন্ধ করুন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filtered Hospitals
    final filteredHospitals = _hospitals.where((hospital) {
      final matchesSearch = hospital['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hospital['address'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'সব হাসপাতাল' || hospital['type'] == _selectedCategory;
      final matchesDivision = _selectedDivision == 'সব বিভাগ' || hospital['division'] == _selectedDivision;
      return matchesSearch && matchesCategory && matchesDivision;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('নিকটস্থ হাসপাতাল ডিরেক্টরি', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1B4B)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Sticky Top Search and Filters
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                // Search Field
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintText: 'হাসপাতালের নাম অথবা এলাকা খুঁজুন...',
                    hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                    fillColor: const Color(0xFFF1F5F9),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),

                // Category and Division Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          fillColor: const Color(0xFFF8FAFC),
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        ),
                        items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12.5)))).toList(),
                        onChanged: (val) => setState(() => _selectedCategory = val!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedDivision,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          fillColor: const Color(0xFFF8FAFC),
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        ),
                        items: _divisions.map((d) => DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(fontSize: 12.5)))).toList(),
                        onChanged: (val) => setState(() => _selectedDivision = val!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Hospital List View
          Expanded(
            child: filteredHospitals.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_hospital_outlined, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'উক্ত ফিল্টারে কোনো হাসপাতাল খুঁজে পাওয়া যায়নি।',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: filteredHospitals.length,
                    itemBuilder: (context, index) {
                      final hosp = filteredHospitals[index];
                      final isGovt = hosp['isGovt'] as bool;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title & Type Tag
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    hosp['name'] as String,
                                    style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: Color(0xFF0F172A), height: 1.3),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isGovt ? const Color(0xFFEEF2FF) : const Color(0xFFFFF7ED),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    hosp['type'] as String,
                                    style: TextStyle(
                                      
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: isGovt ? const Color(0xFF4F46E5) : const Color(0xFFD97706),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Address Line
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded, color: Colors.grey, size: 14),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    hosp['address'] as String,
                                    style: const TextStyle(fontSize: 11.5, color: Color(0xFF475569)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Specialist Doctor Line
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  const Icon(Icons.medical_services_outlined, color: AppColors.primary, size: 14),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'অন-কল ডাক্তার: ${hosp['doctors']}',
                                      style: const TextStyle(fontSize: 11, color: Color(0xFF334155), fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Services wrap
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: (hosp['services'] as List<String>).map((service) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Text(
                                    service,
                                    style: const TextStyle(fontSize: 9.5, color: Color(0xFF475569), fontWeight: FontWeight.w600),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),

                            // Action buttons
                            Row(
                              children: [
                                // Call hotline button
                                Expanded(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.success,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    onPressed: () => _triggerCall(hosp['name'] as String, hosp['hotline'] as String),
                                    icon: const Icon(Icons.phone, size: 14, color: Colors.white),
                                    label: const Text('জরুরি ফোন', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Map Directions button
                                Expanded(
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.primary,
                                      side: const BorderSide(color: AppColors.primary),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    onPressed: () => _viewDirections(hosp['name'] as String),
                                    icon: const Icon(Icons.map_outlined, size: 14),
                                    label: const Text('দিকনির্দেশনা', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Map Route Simulation Painter ───────────────────────────────────────────────
class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw main roads
    final mainRoad = Path()
      ..moveTo(40, size.height - 40)
      ..cubicTo(80, size.height - 80, 60, size.height / 2, size.width / 2, size.height / 2)
      ..cubicTo(size.width * 0.7, size.height / 2, size.width * 0.6, 30, size.width - 40, 30);

    canvas.drawPath(mainRoad, roadPaint);
    canvas.drawPath(mainRoad, routePaint);

    // Draw side intersections
    final sideRoad = Path()
      ..moveTo(10, size.height / 2 - 20)
      ..lineTo(size.width / 2, size.height / 2)
      ..moveTo(size.width - 10, size.height - 30)
      ..lineTo(size.width * 0.7, size.height / 2 + 10);

    canvas.drawPath(sideRoad, Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
