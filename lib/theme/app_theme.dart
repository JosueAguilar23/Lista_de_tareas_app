import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Nunito'),
        displayMedium: TextStyle(fontFamily: 'Nunito'),
        displaySmall: TextStyle(fontFamily: 'Nunito'),
        headlineMedium: TextStyle(fontFamily: 'Nunito'),
        headlineSmall: TextStyle(fontFamily: 'Nunito'),
        titleLarge: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Nunito'),
        displayMedium: TextStyle(fontFamily: 'Nunito'),
        displaySmall: TextStyle(fontFamily: 'Nunito'),
        headlineMedium: TextStyle(fontFamily: 'Nunito'),
        headlineSmall: TextStyle(fontFamily: 'Nunito'),
        titleLarge: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400),
      ),
    );
  }
}