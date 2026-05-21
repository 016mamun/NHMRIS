import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/models/user_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 5;

  // Controllers & States for Step 1 (Mother's Profile)
  late TextEditingController _motherNameCtrl;
  String _dob = '';
  String _bloodGroup = '';
  String _motherOccupation = '';
  String _motherProfileImg = '';

  // Controllers for Step 2 (Address)
  late TextEditingController _houseRoadCtrl;
  late TextEditingController _areaCtrl;
  late TextEditingController _postOfficeCtrl;
  late TextEditingController _thanaCtrl;
  late TextEditingController _districtCtrl;
  late TextEditingController _postCodeCtrl;

  // Controllers & States for Step 3 (Husband's Name)
  late TextEditingController _husbandNameCtrl;
  String _husbandOccupation = '';
  String _husbandProfileImg = '';

  // Controllers & States for Step 4 (Location)
  late TextEditingController _currentLocationCtrl;
  String _regularResidence = '';
  bool _isLocating = false;

  // Controllers for Step 5 (Contact)
  late TextEditingController _mobilePhoneCtrl;
  late TextEditingController _alternativePhoneCtrl;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    UserModel? user;
    if (authState is AuthAuthenticated) {
      user = authState.user;
    }

    // Init Step 1
    _motherNameCtrl = TextEditingController(text: user?.name ?? '');
    _dob = user?.dob ?? '১৫ মার্চ ১৯৯৬';
    _bloodGroup = user?.bloodGroup ?? 'O+ (পজিটিভ)';
    _motherOccupation = user?.occupation ?? 'শিক্ষিকা';
    _motherProfileImg = user?.profileImage ?? '';

    // Init Step 2
    _houseRoadCtrl = TextEditingController(text: user?.addressHouseRoad ?? '১২/বি, পূর্ব কাজী পাড়া রোড');
    _areaCtrl = TextEditingController(text: user?.addressArea ?? 'কাজী পাড়া');
    _postOfficeCtrl = TextEditingController(text: user?.addressPostOffice ?? 'কাজী পাড়া');
    _thanaCtrl = TextEditingController(text: user?.addressThana ?? 'মিরপুর');
    _districtCtrl = TextEditingController(text: user?.addressDistrict ?? 'ঢাকা');
    _postCodeCtrl = TextEditingController(text: user?.addressPostCode ?? '১২১৬');

    // Init Step 3
    _husbandNameCtrl = TextEditingController(text: user?.husbandName ?? 'মোহাম্মদ রাকিবুল ইসলাম');
    _husbandOccupation = user?.husbandOccupation ?? 'ব্যবসায়ী';
    _husbandProfileImg = user?.husbandImage ?? '';

    // Init Step 4
    _currentLocationCtrl = TextEditingController(text: user?.currentLocation ?? 'মিরপুর, ঢাকা, বাংলাদেশ');
    _regularResidence = user?.regularResidence ?? 'মিরপুর, ঢাকা';

    // Init Step 5
    _mobilePhoneCtrl = TextEditingController(text: user?.phone ?? '');
    _alternativePhoneCtrl = TextEditingController(text: user?.alternativePhone ?? '০১৮১২-৩৪৫৬৭৮');
  }

  @override
  void dispose() {
    _pageController.dispose();
    _motherNameCtrl.dispose();
    _houseRoadCtrl.dispose();
    _areaCtrl.dispose();
    _postOfficeCtrl.dispose();
    _thanaCtrl.dispose();
    _districtCtrl.dispose();
    _postCodeCtrl.dispose();
    _husbandNameCtrl.dispose();
    _currentLocationCtrl.dispose();
    _mobilePhoneCtrl.dispose();
    _alternativePhoneCtrl.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _prevPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _saveProfile() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final updatedUser = authState.user.copyWith(
        name: _motherNameCtrl.text.trim(),
        dob: _dob,
        bloodGroup: _bloodGroup,
        occupation: _motherOccupation,
        profileImage: _motherProfileImg.isNotEmpty ? _motherProfileImg : null,
        addressHouseRoad: _houseRoadCtrl.text.trim(),
        addressArea: _areaCtrl.text.trim(),
        addressPostOffice: _postOfficeCtrl.text.trim(),
        addressThana: _thanaCtrl.text.trim(),
        addressDistrict: _districtCtrl.text.trim(),
        addressPostCode: _postCodeCtrl.text.trim(),
        husbandName: _husbandNameCtrl.text.trim(),
        husbandOccupation: _husbandOccupation,
        husbandImage: _husbandProfileImg.isNotEmpty ? _husbandProfileImg : null,
        currentLocation: _currentLocationCtrl.text.trim(),
        regularResidence: _regularResidence,
        phone: _mobilePhoneCtrl.text.trim(),
        alternativePhone: _alternativePhoneCtrl.text.trim(),
      );

      // Dispatch update event
      context.read<AuthBloc>().add(AuthProfileUpdated(updatedUser: updatedUser));

      // Show beautiful success dialog with checkmark animation
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogCtx) => _SuccessDialog(
          onDismiss: () {
            Navigator.pop(dialogCtx); // Close dialog
            Navigator.pop(context); // Return to dashboard
          },
        ),
      );
    }
  }

  // Helper method to pick profile photo dummy simulation
  void _simulatePhotoPick({required bool isMother}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isMother ? 'মাতার ছবি পরিবর্তন' : 'স্বামীর ছবি পরিবর্তন',
                  style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.primarySurface,
                    child: Icon(Icons.photo_library_outlined, color: AppColors.primary),
                  ),
                  title: const Text('গ্যালারি থেকে নির্বাচন'),
                  onTap: () {
                    Navigator.pop(bottomSheetCtx);
                    setState(() {
                      if (isMother) {
                        _motherProfileImg = 'picked';
                      } else {
                        _husbandProfileImg = 'picked';
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isMother ? 'মাতার প্রোফাইল ছবি সফলভাবে আপডেট হয়েছে!' : 'স্বামীর প্রোফাইল ছবি সফলভাবে আপডেট হয়েছে!'),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.primarySurface,
                    child: Icon(Icons.camera_alt_outlined, color: AppColors.primary),
                  ),
                  title: const Text('ক্যামেরা দিয়ে ছবি তুলুন'),
                  onTap: () {
                    Navigator.pop(bottomSheetCtx);
                    setState(() {
                      if (isMother) {
                        _motherProfileImg = 'picked';
                      } else {
                        _husbandProfileImg = 'picked';
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isMother ? 'মাতার প্রোফাইল ছবি সফলভাবে আপডেট হয়েছে!' : 'স্বামীর প্রোফাইল ছবি সফলভাবে আপডেট হয়েছে!'),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.error.withValues(alpha: 0.1),
                    child: const Icon(Icons.delete_outline, color: AppColors.error),
                  ),
                  title: const Text('ছবি মুছে ফেলুন'),
                  onTap: () {
                    Navigator.pop(bottomSheetCtx);
                    setState(() {
                      if (isMother) {
                        _motherProfileImg = '';
                      } else {
                        _husbandProfileImg = '';
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Simulate GPS location fetching
  void _simulateLocationFetch() async {
    setState(() {
      _isLocating = true;
    });
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isLocating = false;
        _currentLocationCtrl.text = 'মিরপুর, ঢাকা, বাংলাদেশ';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('জিপিএস এর মাধ্যমে আপনার বর্তমান অবস্থান সনাক্ত করা হয়েছে!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Standard interactive date picker dialog
  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1996, 3, 15),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        // Simple Bengali date formulation
        const monthNames = [
          'জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
          'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর'
        ];
        final bDay = AppConstants.toBengaliNumber(picked.day);
        final bYear = AppConstants.toBengaliNumber(picked.year);
        _dob = '$bDay ${monthNames[picked.month - 1]} $bYear';
      });
    }
  }

  // Blood group selector bottom sheet
  void _selectBloodGroup() {
    final List<String> bloodGroups = [
      'A+ (পজিটিভ)',
      'A- (নেগেটিভ)',
      'B+ (পজিটিভ)',
      'B- (নেগেটিভ)',
      'AB+ (পজিটিভ)',
      'AB- (নেগেটিভ)',
      'O+ (পজিটিভ)',
      'O- (নেগেটিভ)',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'রক্তের গ্রুপ নির্বাচন করুন',
                  style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: bloodGroups.length,
                    itemBuilder: (context, index) {
                      final group = bloodGroups[index];
                      final isSelected = _bloodGroup == group;
                      return ListTile(
                        title: Text(
                          group,
                          style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                            : null,
                        onTap: () {
                          setState(() {
                            _bloodGroup = group;
                          });
                          Navigator.pop(bottomSheetCtx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Occupation selector bottom sheet
  void _selectOccupation({required bool isMother}) {
    final List<String> occupations = isMother
        ? ['শিক্ষিকা', 'গৃহিণী', 'চাকুরীজীবী', 'ব্যবসায়ী', 'চিকিৎসক', 'অন্যান্য']
        : ['ব্যবসায়ী', 'চাকুরীজীবী', 'কৃষক', 'শিক্ষক', 'চিকিৎসক', 'অন্যান্য'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isMother ? 'মাতার পেশা নির্বাচন করুন' : 'স্বামীর পেশা নির্বাচন করুন',
                  style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: occupations.length,
                    itemBuilder: (context, index) {
                      final occ = occupations[index];
                      final current = isMother ? _motherOccupation : _husbandOccupation;
                      final isSelected = current == occ;
                      return ListTile(
                        title: Text(
                          occ,
                          style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                            : null,
                        onTap: () {
                          setState(() {
                            if (isMother) {
                              _motherOccupation = occ;
                            } else {
                              _husbandOccupation = occ;
                            }
                          });
                          Navigator.pop(bottomSheetCtx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Regular residence selector
  void _selectRegularResidence() {
    final List<String> areas = [
      'মিরপুর, ঢাকা',
      'উত্তরা, ঢাকা',
      'ধানমন্ডি, ঢাকা',
      'গুলশান, ঢাকা',
      'মোহাম্মদপুর, ঢাকা',
      'বাড্ডা, ঢাকা',
      'অন্যান্য'
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'নিয়মিত বসবাসের স্থান নির্বাচন করুন',
                  style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: areas.length,
                    itemBuilder: (context, index) {
                      final area = areas[index];
                      final isSelected = _regularResidence == area;
                      return ListTile(
                        title: Text(
                          area,
                          style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                            : null,
                        onTap: () {
                          setState(() {
                            _regularResidence = area;
                          });
                          Navigator.pop(bottomSheetCtx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String stepTitle = '';
    switch (_currentStep) {
      case 0:
        stepTitle = 'মাতার প্রোফাইল';
        break;
      case 1:
        stepTitle = 'ঠিকানা (Address)';
        break;
      case 2:
        stepTitle = 'স্বামীর নাম';
        break;
      case 3:
        stepTitle = 'অবস্থান (Location)';
        break;
      case 4:
        stepTitle = 'যোগাযোগ নম্বর';
        break;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
            onPressed: _prevPage,
          ),
          title: Text(
            stepTitle,
            style: AppTextStyles.headingLarge.copyWith(color: AppColors.textPrimary),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // ── Stepper UI Indicator ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildStepper(),
            ),

            // ── Form Page Container ─────────────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMotherProfileStep(),
                  _buildAddressStep(),
                  _buildHusbandStep(),
                  _buildLocationStep(),
                  _buildContactStep(),
                ],
              ),
            ),
          ],
        ),
        // ── Next/Save Premium Bottom Button ─────────────────────────────────────
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 6,
                  shadowColor: AppColors.primary.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: _currentStep == _totalSteps - 1 ? _saveProfile : _nextPage,
                child: Text(
                  _currentStep == _totalSteps - 1 ? 'সংরক্ষণ করুন' : 'পরবর্তী',
                  style: GoogleFonts.hindSiliguri(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Stepper Custom Rendering ───────────────────────────────────────────────
  Widget _buildStepper() {
    List<Widget> stepWidgets = [];
    for (int i = 0; i < _totalSteps; i++) {
      final isCompleted = i < _currentStep;
      final isActive = i == _currentStep;

      // Circle Bubble
      stepWidgets.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.primary
                : isActive
                    ? AppColors.primary
                    : AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted || isActive
                  ? AppColors.primary
                  : AppColors.border,
              width: 1.5,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.24),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ]
                : null,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontFamily: 'Hind_Siliguri',
                      fontSize: 14,
                      fontWeight: isActive || isCompleted ? FontWeight.w700 : FontWeight.w500,
                      color: isActive || isCompleted
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
          ),
        ),
      );

      // Connecting line
      if (i < _totalSteps - 1) {
        stepWidgets.add(
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2.5,
              decoration: BoxDecoration(
                color: i < _currentStep
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stepWidgets,
    );
  }

  // ── Step 1: Mother Profile Step ─────────────────────────────────────────────
  Widget _buildMotherProfileStep() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Circular profile picture picker
          Center(
            child: Stack(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _motherProfileImg.isNotEmpty
                        ? const Image(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=256'),
                            fit: BoxFit.cover,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.pregnant_woman_rounded,
                              size: 60,
                              color: AppColors.primary.withValues(alpha: 0.8),
                            ),
                          ),
                  ),
                ),
                // Camera Badge Button
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _simulatePhotoPick(isMother: true),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Fields Card List
          _buildInputCard(
            icon: Icons.person_outline,
            label: 'পূর্ণ নাম (মা)',
            widget: TextFormField(
              controller: _motherNameCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _motherNameCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildPickerCard(
            icon: Icons.calendar_today_outlined,
            label: 'জন্ম তারিখ',
            value: _dob,
            hint: 'আপনার জন্ম তারিখ নির্ধারণ করুন',
            onTap: _selectDate,
            isValid: _dob.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildPickerCard(
            icon: Icons.bloodtype_outlined,
            label: 'রক্তের গ্রুপ',
            value: _bloodGroup,
            hint: 'রক্তের গ্রুপ নির্বাচন করুন',
            onTap: _selectBloodGroup,
            isValid: _bloodGroup.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildPickerCard(
            icon: Icons.work_outline,
            label: 'পেশা',
            value: _motherOccupation,
            hint: 'আপনার পেশা নির্বাচন করুন',
            onTap: () => _selectOccupation(isMother: true),
            isValid: _motherOccupation.isNotEmpty,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── Step 2: Address Step ──────────────────────────────────────────────────
  Widget _buildAddressStep() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          _buildInputCard(
            icon: Icons.home_outlined,
            label: 'বাড়ি নং / রোড',
            widget: TextFormField(
              controller: _houseRoadCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _houseRoadCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildInputCard(
            icon: Icons.location_city_outlined,
            label: 'এরিয়া / মহল্লা',
            widget: TextFormField(
              controller: _areaCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _areaCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildInputCard(
            icon: Icons.mail_outline,
            label: 'পোস্ট অফিস',
            widget: TextFormField(
              controller: _postOfficeCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _postOfficeCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildInputCard(
            icon: Icons.map_outlined,
            label: 'থানা',
            widget: TextFormField(
              controller: _thanaCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _thanaCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildInputCard(
            icon: Icons.location_on_outlined,
            label: 'জেলা',
            widget: TextFormField(
              controller: _districtCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _districtCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildInputCard(
            icon: Icons.pin_outlined,
            label: 'পোস্ট কোড',
            widget: TextFormField(
              controller: _postCodeCtrl,
              keyboardType: TextInputType.number,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _postCodeCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  // ── Step 3: Husband Step ──────────────────────────────────────────────────
  Widget _buildHusbandStep() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Circular picture picker for husband
          Center(
            child: Stack(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _husbandProfileImg.isNotEmpty
                        ? const Image(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=256'),
                            fit: BoxFit.cover,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.person_rounded,
                              size: 60,
                              color: AppColors.primary.withValues(alpha: 0.8),
                            ),
                          ),
                  ),
                ),
                // Camera Badge Button
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _simulatePhotoPick(isMother: false),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          _buildInputCard(
            icon: Icons.person_outline,
            label: 'স্বামীর পূর্ণ নাম',
            widget: TextFormField(
              controller: _husbandNameCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _husbandNameCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildPickerCard(
            icon: Icons.work_outline,
            label: 'পেশা',
            value: _husbandOccupation,
            hint: 'স্বামীর পেশা নির্বাচন করুন',
            onTap: () => _selectOccupation(isMother: false),
            isValid: _husbandOccupation.isNotEmpty,
          ),
          const SizedBox(height: 20),

          // Optional Info Banner Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primarySurface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'স্বামীর তথ্য প্রদান সম্পূর্ণ ঐচ্ছিক, তবে দিলে আমরা আপনাকে আরও ভালোভাবে সাহায্য করতে পারব।',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primaryDark,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  // ── Step 4: Location Step ─────────────────────────────────────────────────
  Widget _buildLocationStep() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Beautiful Map Pin Visual Card
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE8E5F9), Color(0xFFF0EDFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Floating dots or maps elements in code vector
                Icon(
                  Icons.map_rounded,
                  size: 100,
                  color: AppColors.primary.withValues(alpha: 0.06),
                ),
                // Glowing pin
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          _buildInputCard(
            icon: Icons.my_location_rounded,
            label: 'আপনার বর্তমান অবস্থান',
            widget: TextFormField(
              controller: _currentLocationCtrl,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _currentLocationCtrl.text.isNotEmpty,
            actionWidget: GestureDetector(
              onTap: _isLocating ? null : _simulateLocationFetch,
              child: _isLocating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    )
                  : const Icon(
                      Icons.gps_fixed_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
            ),
          ),
          const SizedBox(height: 14),

          _buildPickerCard(
            icon: Icons.home_work_outlined,
            label: 'নিয়মিত বসবাসের স্থান',
            value: _regularResidence,
            hint: 'নিয়মিত বসবাসের স্থান নির্বাচন করুন',
            onTap: _selectRegularResidence,
            isValid: _regularResidence.isNotEmpty,
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  // ── Step 5: Contact Step ──────────────────────────────────────────────────
  Widget _buildContactStep() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Phone mock illustration
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF3EEFF), Color(0xFFF9F7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.phone_iphone_rounded,
                  size: 100,
                  color: AppColors.primary.withValues(alpha: 0.05),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.security_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          _buildInputCard(
            icon: Icons.phone_android_rounded,
            label: 'মোবাইল নম্বর',
            widget: TextFormField(
              controller: _mobilePhoneCtrl,
              keyboardType: TextInputType.phone,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _mobilePhoneCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 14),

          _buildInputCard(
            icon: Icons.phone_iphone_rounded,
            label: 'বিকল্প নম্বর (ঐচ্ছিক)',
            widget: TextFormField(
              controller: _alternativePhoneCtrl,
              keyboardType: TextInputType.phone,
              style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (v) => setState(() {}),
            ),
            isValid: _alternativePhoneCtrl.text.isNotEmpty,
          ),
          const SizedBox(height: 20),

          // Security Policy Info Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDCFCE7)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lock_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'আপনার নম্বর নিরাপদ এবং গোপন রাখা হবে। আমরা শুধুমাত্র প্রয়োজনীয় ক্ষেত্রে যোগাযোগ করি।',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: const Color(0xFF15803D),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  // ── Universal Custom Premium Direct Input Card ──────────────────────────────
  Widget _buildInputCard({
    required IconData icon,
    required String label,
    required Widget widget,
    required bool isValid,
    Widget? actionWidget,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Icon on left
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryLight, size: 22),
          ),
          const SizedBox(width: 16),
          // Input block in middle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                widget,
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Validation Checkmark Badge on right
          if (actionWidget != null)
            actionWidget
          else if (isValid)
            const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20)
          else
            const Icon(Icons.check_circle_rounded, color: AppColors.border, size: 20),
        ],
      ),
    );
  }

  // ── Universal Custom Premium Interactive Picker Card ────────────────────────
  Widget _buildPickerCard({
    required IconData icon,
    required String label,
    required String value,
    required String hint,
    required VoidCallback onTap,
    required bool isValid,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon on left
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryLight, size: 22),
            ),
            const SizedBox(width: 16),
            // Picker content in middle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value.isNotEmpty ? value : hint,
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: value.isNotEmpty ? AppColors.textPrimary : AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Dropdown/Chevron or checkmark badge
            if (isValid)
              const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20)
            else
              const Icon(Icons.check_circle_rounded, color: AppColors.border, size: 20),
          ],
        ),
      ),
    );
  }
}

// ── Beautiful Animated Success Dialog Widget ─────────────────────────────────
class _SuccessDialog extends StatefulWidget {
  final VoidCallback onDismiss;
  const _SuccessDialog({required this.onDismiss});

  @override
  State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Check Icon
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ScaleTransition(
                        scale: _checkAnimation,
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                          size: 54,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'সফলভাবে সংরক্ষিত!',
                style: AppTextStyles.headingLarge.copyWith(color: AppColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'আপনার পরিবর্তিত প্রোফাইল সফলভাবে আপডেট ও সংরক্ষণ করা হয়েছে।',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: widget.onDismiss,
                  child: const Text(
                    'ঠিক আছে',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
