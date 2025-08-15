
import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF9F6F1); // soft parchment
  static const Color primary = Color(0xFFDC6B2F); // warm burnt orange
  static const Color secondary = Color(0xFFB6B8BE); // soft silver
  static const Color accent = Color(0xFF8C6849); // olive/bark
  static const Color text = Color(0xFF333333);
  static const Color fadedText = Color(0xFF888888);
}

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Sans',
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.text),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.text),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.text),
    bodySmall: TextStyle(fontSize: 14, color: AppColors.fadedText),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
);
