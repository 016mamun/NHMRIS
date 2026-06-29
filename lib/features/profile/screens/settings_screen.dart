import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/localization/language_cubit.dart';
import '../../../core/localization/app_translations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Notification Toggle States
  bool _vaccineAlerts = true;
  bool _doctorAlerts = true;
  bool _dailyHealthTips = true;
  bool _kickCounterAlerts = false;

  // Language State
  String _selectedLanguage = 'বাংলা';

  // Security State
  bool _passcodeLock = false;
  bool _biometricAuth = false;

  // Sync Progress State
  double _syncProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = context.read<LanguageCubit>().state;
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'অ্যাপের ভাষা নির্বাচন করুন (Select Language)',
                  style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: const Text('🇧🇩', style: TextStyle(fontSize: 24)),
                  title: const Text('বাংলা', style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: _selectedLanguage == 'বাংলা'
                      ? Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'বাংলা';
                    });
                    context.read<LanguageCubit>().changeLanguage('বাংলা');
                    Navigator.pop(bottomSheetCtx);
                  },
                ),
                ListTile(
                  leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                  title: const Text('English', style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: _selectedLanguage == 'English'
                      ? Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'English';
                    });
                    context.read<LanguageCubit>().changeLanguage('English');
                    Navigator.pop(bottomSheetCtx);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _simulateDataSync() {
    final messenger = ScaffoldMessenger.of(context);
    final successMsg = 'আপনার গর্ভাবস্থা ও শিশুর ডাটা সফলভাবে অফলাইন সিঙ্ক হয়েছে!'.tr(context);
    final syncTitle = 'অফলাইন ব্যাকআপ ও সিঙ্ক'.tr(context);
    final syncProgressPrefix = 'ডাটা ব্যাকআপ ও সিঙ্ক করা হচ্ছে...'.tr(context);
    final syncWaitMsg = 'অনুগ্রহ করে অপেক্ষা করুন, সংযোগ বিচ্ছিন্ন করবেন না।'.tr(context);

    setState(() {
      _syncProgress = 0.0;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Setup a periodic timer inside the dialog
            Future.delayed(const Duration(milliseconds: 100), () {
              if (_syncProgress < 1.0) {
                setDialogState(() {
                  _syncProgress += 0.05;
                });
              } else {
                if (ctx.mounted) {
                  Navigator.pop(ctx); // Close dialog
                }
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(successMsg, style: TextStyle(fontFamily: 'Hind_Siliguri')),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              }
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(Icons.sync_rounded, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    syncTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  CircularProgressIndicator(
                    value: _syncProgress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '$syncProgressPrefix ${(_syncProgress * 100).toInt()}%',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    syncWaitMsg,
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    final oldPasswordCtrl = TextEditingController();
    final newPasswordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.lock_reset_rounded, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'পাসওয়ার্ড পরিবর্তন করুন', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'বর্তমান পাসওয়ার্ড'.tr(context),
                  labelStyle: const TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: newPasswordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'নতুন পাসওয়ার্ড'.tr(context),
                  labelStyle: const TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: confirmPasswordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'নতুন পাসওয়ার্ড নিশ্চিত করুন'.tr(context),
                  labelStyle: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('বাতিল', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              if (newPasswordCtrl.text == confirmPasswordCtrl.text && newPasswordCtrl.text.isNotEmpty) {
                Navigator.pop(ctx);
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('পাসওয়ার্ড সফলভাবে পরিবর্তন করা হয়েছে!', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('নতুন পাসওয়ার্ড দুইটি মেলেনি!', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Text('আপডেট করুন', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final messenger = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.error),
            SizedBox(width: 8),
            Text(
              'অ্যাকাউন্ট মুছে ফেলবেন?', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.error),
            ),
          ],
        ),
        content: Text(
          'আপনি কি নিশ্চিত যে আপনার MHRIS অ্যাকাউন্টটি স্থায়ীভাবে ডিলিট করতে চান? আপনার পূর্ববর্তী সমস্ত গর্ভাবস্থা ও ভ্যাকসিনের মেডিকেল রেকর্ড ডাটা স্থায়ীভাবে মুছে যাবে!', style: TextStyle(fontSize: 13, height: 1.45, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('বাতিল করুন', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              messenger.showSnackBar(
                SnackBar(
                  content: Text('অ্যাকাউন্ট নিষ্ক্রিয়করণের অনুরোধ জমা হয়েছে।', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('হ্যাঁ, ডিলিট করুন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('সেটিংস (Settings)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E1B4B), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Settings Card
            _buildSectionHeader('সাধারণ সেটিংস (General)'.tr(context)),
            SizedBox(height: 8),
            _buildSettingsCard([
              _buildListTile(
                icon: Icons.language_rounded,
                iconColor: Colors.blue,
                title: 'অ্যাপের ভাষা'.tr(context),
                subtitle: _selectedLanguage,
                onTap: _showLanguageSelector,
              ),
              const Divider(height: 1),
              _buildListTile(
                icon: Icons.sync_rounded,
                iconColor: AppColors.primary,
                title: 'অফলাইন ডাটা সিঙ্ক ও ব্যাকআপ'.tr(context),
                subtitle: 'আপনার মেডিকেল রেকর্ড ক্লাউডে সেভ করুন'.tr(context),
                onTap: _simulateDataSync,
              ),
            ]),
            SizedBox(height: 24),

            // Notification Settings Card
            _buildSectionHeader('বিজ্ঞপ্তি ও রিমাইন্ডার সেটিংস'.tr(context)),
            SizedBox(height: 8),
            _buildSettingsCard([
              _buildSwitchTile(
                icon: Icons.vaccines_outlined,
                iconColor: AppColors.primary,
                title: 'টিকার রিমাইন্ডার এলার্ট'.tr(context),
                subtitle: 'ভ্যাকসিনের তারিখের পূর্বের নোটিফিকেশন'.tr(context),
                value: _vaccineAlerts,
                onChanged: (val) => setState(() => _vaccineAlerts = val),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.calendar_month_outlined,
                iconColor: AppColors.success,
                title: 'ডাক্তারের এপয়েন্টমেন্ট রিমাইন্ডার'.tr(context),
                subtitle: 'চেকআপ তারিখের নোটিফিকেশন এলার্ট'.tr(context),
                value: _doctorAlerts,
                onChanged: (val) => setState(() => _doctorAlerts = val),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.emoji_objects_outlined,
                iconColor: Colors.amber,
                title: 'গর্ভকালীন দৈনিক স্বাস্থ্য টিপস'.tr(context),
                subtitle: 'মা ও শিশুর বিকাশের প্রয়োজনীয় পুষ্টি টিপস'.tr(context),
                value: _dailyHealthTips,
                onChanged: (val) => setState(() => _dailyHealthTips = val),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.ads_click_rounded,
                iconColor: AppColors.error,
                title: 'কিক কাউন্টার অনুস্মারক'.tr(context),
                subtitle: 'দৈনিক গর্ভের শিশুর কিক গুনতে রিমাইন্ডার'.tr(context),
                value: _kickCounterAlerts,
                onChanged: (val) => setState(() => _kickCounterAlerts = val),
              ),
            ]),
            SizedBox(height: 24),

            // Security & Privacy Card
            _buildSectionHeader('নিরাপত্তা ও ডাটা পলিসি'.tr(context)),
            SizedBox(height: 8),
            _buildSettingsCard([
              _buildSwitchTile(
                icon: Icons.lock_outline_rounded,
                iconColor: AppColors.primary,
                title: 'অ্যাপ পাসকোড লক'.tr(context),
                subtitle: 'অ্যাপ খোলার সময় পিন লক নিশ্চিত করুন'.tr(context),
                value: _passcodeLock,
                onChanged: (val) => setState(() => _passcodeLock = val),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.fingerprint_rounded,
                iconColor: AppColors.success,
                title: 'বায়োমেট্রিক আনলক (ফিঙ্গারপ্রিন্ট)'.tr(context),
                subtitle: 'দ্রুত অ্যাক্সেসের জন্য ফিঙ্গারপ্রিন্ট সেট করুন'.tr(context),
                value: _biometricAuth,
                onChanged: (val) => setState(() => _biometricAuth = val),
              ),
            ]),
            SizedBox(height: 24),

            // Account Actions Card
            _buildSectionHeader('অ্যাকাউন্ট সেটিংস'.tr(context)),
            SizedBox(height: 8),
            _buildSettingsCard([
              _buildListTile(
                icon: Icons.lock_reset_rounded,
                iconColor: Colors.amber.shade800,
                title: 'পাসওয়ার্ড পরিবর্তন করুন'.tr(context),
                subtitle: 'আপনার গোপনীয় পাসওয়ার্ড পরিবর্তন করুন'.tr(context),
                onTap: _showChangePasswordDialog,
              ),
              const Divider(height: 1),
              _buildListTile(
                icon: Icons.delete_forever_rounded,
                iconColor: AppColors.error,
                title: 'অ্যাকাউন্ট মুছে ফেলুন (Delete Account)'.tr(context),
                subtitle: 'আপনার সমস্ত ডাটা চিরতরে ডিলিট করুন'.tr(context),
                onTap: _showDeleteAccountDialog,
                titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.error),
              ),
            ]),
            SizedBox(height: 24),

            // Support Card
            _buildSectionHeader('সহায়তা ও তথ্য'.tr(context)),
            SizedBox(height: 8),
            _buildSettingsCard([
              _buildListTile(
                icon: Icons.privacy_tip_outlined,
                iconColor: Colors.teal,
                title: 'গোপনীয়তা নীতিমালা (Privacy Policy)'.tr(context),
                subtitle: 'আমাদের ডাটা ব্যবহার নির্দেশিকা পড়ুন'.tr(context),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('গোপনীয়তা নীতিমালা ফাইল ওপেন করা হচ্ছে...', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              _buildListTile(
                icon: Icons.help_outline_rounded,
                iconColor: Colors.indigo,
                title: 'সচরাচর জিজ্ঞাসিত প্রশ্ন (FAQ)'.tr(context),
                subtitle: 'অ্যাপ ব্যবহারে সাধারণ জিজ্ঞাসাসমূহ'.tr(context),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('এফএকিউ পেজ লোড হচ্ছে...', style: TextStyle(fontFamily: 'Hind_Siliguri')),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ]),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    TextStyle? titleStyle,
  }) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(icon, color: iconColor, size: 18)),
      ),
      title: Text(
        title,
        style: titleStyle ??
            const TextStyle(
              
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          
          fontSize: 11,
          color: Color(0xFF64748B),
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      activeTrackColor: AppColors.primary.withValues(alpha: 0.8),
      secondary: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(icon, color: iconColor, size: 18)),
      ),
      title: Text(
        title,
        style: TextStyle(
          
          fontSize: 14.5,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E293B),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          
          fontSize: 11,
          color: Color(0xFF64748B),
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
