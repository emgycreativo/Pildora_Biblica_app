import 'package:flutter/material.dart';

final Color _backgroundColor = const Color(0xFFFFF8E1);
final Color _primaryColor = const Color(0xFFFF9800); // orange
final Color _secondaryColor = const Color(0xFF7E57C2); // purple

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      background: _backgroundColor,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

