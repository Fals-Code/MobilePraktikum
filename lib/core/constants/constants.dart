import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Dashboard Mahasiswa D4TI';
  static const String appVersion = '1.0.0';
  static const String userPrefsKey = 'user_prefs';

  // Spacing
  static const double paddingXS   = 4.0;
  static const double paddingSmall  = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge  = 24.0;
  static const double paddingXL    = 32.0;

  // Border Radius
  static const double radiusSmall  = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge  = 16.0;
  static const double radiusXL    = 24.0;

  // Stat Card Gradients
  static const List<List<Color>> statGradients = [
    [Color(0xFF1A56DB), Color(0xFF1239A5)],
    [Color(0xFF0E9F6E), Color(0xFF057A55)],
    [Color(0xFFE3A008), Color(0xFFC27803)],
    [Color(0xFF7E3AF2), Color(0xFF6C2BD9)],
  ];
}