// lib/core/constant/theme/app_colors.dart
import 'package:flutter/material.dart';

final class AppColors {
  const AppColors._();

  // Brand
  static const primary      = Color(0xFF0B3D91);
  static const primaryDark  = Color(0xFF072A66);
  static const secondary    = Color(0xFF3A86FF);
  static const accent       = Color(0xFFFFC107);

  // Surfaces
  static const surface      = Colors.white;
  static const background   = Color(0xFFF7F8FA);
  static const scaffold     = background;

  // Text
  static const textPrimary  = Color(0xFF111111);
  static const textSecondary= Color(0xFF6B7280);

  // States
  static const success      = Color(0xFF22C55E);
  static const warning      = Color(0xFFF59E0B);
  static const error        = Color(0xFFEF4444);
  static const outline      = Color(0xFF9CA3AF);

  // Extra requested color (named as you wrote “colo”)
  static const colo         = Color(0xFF1F2937); // rename if you meant a specific token
}
