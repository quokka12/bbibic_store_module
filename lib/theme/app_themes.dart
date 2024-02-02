import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes{
  AppThemes._();
  static ThemeData mainTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: "pretendard",
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: inputDecorationTheme(),
      textTheme: const TextTheme(),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Colors.black87)),
    );
  }
  static InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
    OutlineInputBorder outlineInputErrorBorder =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent));
    OutlineInputBorder outlineInputFocusBorder =
    OutlineInputBorder(borderSide: BorderSide(color: AppColors.black));
    return InputDecorationTheme(
        focusedBorder: outlineInputFocusBorder,
        errorBorder: outlineInputErrorBorder,
        border: outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12));
  }
}