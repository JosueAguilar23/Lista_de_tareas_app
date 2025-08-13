import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Nunito'),
        displayMedium: TextStyle(fontFamily: 'Nunito'),
        displaySmall: TextStyle(fontFamily: 'Nunito'),
        headlineMedium: TextStyle(fontFamily: 'Nunito'),
        headlineSmall: TextStyle(fontFamily: 'Nunito'),
        titleLarge: TextStyle(fontFamily: 'Nunito'),
        titleMedium: TextStyle(fontFamily: 'Nunito'),
        titleSmall: TextStyle(fontFamily: 'Nunito'),
        bodyLarge: TextStyle(fontFamily: 'Nunito'),
        bodyMedium: TextStyle(fontFamily: 'Nunito'),
        bodySmall: TextStyle(fontFamily: 'Nunito'),
        labelLarge: TextStyle(fontFamily: 'Nunito'),
        labelSmall: TextStyle(fontFamily: 'Nunito'),
      ),
    );
  }

  static ThemeData dark() {
    final baseDark = ThemeData(brightness: Brightness.dark);
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
      textTheme: baseDark.textTheme.apply(fontFamily: 'Nunito'),
    );
  }
}