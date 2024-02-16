import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  AppThemes._();
  static ThemeData mainTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: "pretendard",
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: inputDecorationTheme(),
      textTheme: const TextTheme(),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.black87)),
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey200,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12));
  }
}
