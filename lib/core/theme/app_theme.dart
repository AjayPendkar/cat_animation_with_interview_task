import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF2B3A55),
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF2B3A55),
        secondary: Colors.grey[700]!,
        surface: Colors.white,
        background: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: const Color(0xFF2B3A55),
      scaffoldBackgroundColor: const Color(0xFF121212),
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF2B3A55),
        secondary: Colors.grey[300]!,
        surface: const Color(0xFF121212),
        background: const Color(0xFF121212),
      ),
    );
  }
} 