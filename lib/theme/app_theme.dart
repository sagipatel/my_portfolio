// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Backgrounds
  static const bg0 = Color(0xFF070B14);
  static const bg1 = Color(0xFF0C1221);
  static const bg2 = Color(0xFF111827);

  // Glass
  static const glassBg = Color(0x0DFFFFFF);       // 5% white
  static const glassBorder = Color(0x1AFFFFFF);   // 10% white
  static const glassShadow = Color(0x66000000);   // 40% black

  // Brand
  static const indigo = Color(0xFF6C63FF);
  static const violet = Color(0xFFA78BFA);
  static const sky    = Color(0xFF38BDF8);
  static const emerald= Color(0xFF10B981);
  static const pink   = Color(0xFFF472B6);
  static const amber  = Color(0xFFFBBF24);

  // Text
  static const textPrimary  = Color(0xFFF1F5F9);
  static const textSub      = Color(0xFF94A3B8);
  static const textDim      = Color(0xFF475569);

  // Gradients
  static const LinearGradient primaryGrad = LinearGradient(
    colors: [indigo, violet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient accentGrad = LinearGradient(
    colors: [indigo, sky],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient heroGrad = LinearGradient(
    colors: [Colors.white, violet, sky],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient emeraldGrad = LinearGradient(
    colors: [emerald, Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg0,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.indigo,
      secondary: AppColors.violet,
      surface: AppColors.bg1,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
  );
}

// Glass card decoration helper
BoxDecoration glassDecoration({
  double borderRadius = 20,
  Color? borderColor,
  List<BoxShadow>? shadows,
}) {
  return BoxDecoration(
    color: AppColors.glassBg,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: borderColor ?? AppColors.glassBorder, width: 1),
    boxShadow: shadows ??
        [
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: const Offset(0, 8),
          ),
        ],
  );
}
