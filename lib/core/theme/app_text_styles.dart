import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Display
  static TextStyle get displayLarge => GoogleFonts.hindSiliguri(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get displayMedium => GoogleFonts.hindSiliguri(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Heading
  static TextStyle get headingLarge => GoogleFonts.hindSiliguri(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get headingMedium => GoogleFonts.hindSiliguri(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get headingSmall => GoogleFonts.hindSiliguri(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body
  static TextStyle get bodyLarge => GoogleFonts.hindSiliguri(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.hindSiliguri(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get bodySmall => GoogleFonts.hindSiliguri(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.5,
  );

  // Label
  static TextStyle get labelMedium => GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelSmall => GoogleFonts.hindSiliguri(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // On Primary (white text for colored backgrounds)
  static TextStyle get onPrimaryDisplay => GoogleFonts.hindSiliguri(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    height: 1.3,
  );

  static TextStyle get onPrimaryHeading => GoogleFonts.hindSiliguri(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.4,
  );

  static TextStyle get onPrimaryBody => GoogleFonts.hindSiliguri(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: const Color(0xCCFFFFFF),
    height: 1.6,
  );

  // Module Card Title
  static TextStyle get moduleTitle => GoogleFonts.hindSiliguri(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle get moduleBody => GoogleFonts.hindSiliguri(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );
}
