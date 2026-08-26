import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    const navy = Color(0xFF19324A);
    const teal = Color(0xFF167D78);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF5F7F6),
      colorScheme: ColorScheme.fromSeed(seedColor: teal, primary: teal, onPrimary: Colors.white, surface: Colors.white),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF5F7F6), foregroundColor: navy, elevation: 0),
      cardTheme: const CardThemeData(color: Colors.white, elevation: 0, margin: EdgeInsets.zero),
    );
  }
}