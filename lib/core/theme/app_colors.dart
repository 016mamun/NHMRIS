import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Purple Palette
  static const Color primary = Color(0xFF6B3FA0);
  static const Color primaryLight = Color(0xFF8B5EC6);
  static const Color primaryDark = Color(0xFF4A2B7A);
  static const Color primarySurface = Color(0xFFF3EEFF);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7C4FC4), Color(0xFF5B2D9A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient bannerGradient = LinearGradient(
    colors: [Color(0xFF8A5DCE), Color(0xFF5B2D9A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Scaffold & Background
  static const Color background = Color(0xFFF7F4FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1030);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Module Card Accent Colors
  static const Color kickCounterBg = Color(0xFFE8F5E9);
  static const Color kickCounterIcon = Color(0xFF4CAF50);

  static const Color doctorBg = Color(0xFFE3F2FD);
  static const Color doctorIcon = Color(0xFF2196F3);

  static const Color nutritionBg = Color(0xFFE8F5E9);
  static const Color nutritionIcon = Color(0xFF66BB6A);

  static const Color weeklyBg = Color(0xFFEDE7F6);
  static const Color weeklyIcon = Color(0xFF7E57C2);

  static const Color reminderBg = Color(0xFFFCE4EC);
  static const Color reminderIcon = Color(0xFFEC407A);

  static const Color deliveryBg = Color(0xFFFFF3E0);
  static const Color deliveryIcon = Color(0xFFFF9800);

  // Arrow / Link Colors
  static const Color arrowPurple = Color(0xFF6B3FA0);
  static const Color arrowGreen = Color(0xFF4CAF50);
  static const Color arrowBlue = Color(0xFF2196F3);
  static const Color arrowPink = Color(0xFFEC407A);
  static const Color arrowOrange = Color(0xFFFF9800);

  // Divider & Border
  static const Color divider = Color(0xFFE5E7EB);
  static const Color border = Color(0xFFE5E7EB);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Shadow
  static const Color shadow = Color(0x1A6B3FA0);
}
