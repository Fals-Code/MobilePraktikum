import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary     = Color(0xFF1A56DB);
  static const Color primaryLight = Color(0xFFEBF0FF);
  static const Color primaryDark  = Color(0xFF1239A5);

  static const Color success      = Color(0xFF0E9F6E);
  static const Color successLight = Color(0xFFDEF7EC);

  static const Color warning      = Color(0xFFE3A008);
  static const Color warningLight = Color(0xFFFDF6B2);

  static const Color danger       = Color(0xFFE02424);
  static const Color dangerLight  = Color(0xFFFDE8E8);

  static const Color purple       = Color(0xFF7E3AF2);
  static const Color purpleLight  = Color(0xFFF3EEFF);

  static const Color neutral900 = Color(0xFF111827);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral50  = Color(0xFFF9FAFB);
  static const Color white      = Colors.white;

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: success,
      surface: white,
      onPrimary: white,
      onSurface: neutral900,
    ),
    scaffoldBackgroundColor: neutral50,
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: neutral900),
      titleTextStyle: TextStyle(
        color: neutral900,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: neutral300, width: 0.8),
      ),
    ),
    dividerTheme: const DividerThemeData(color: neutral100, thickness: 1),
  );
}