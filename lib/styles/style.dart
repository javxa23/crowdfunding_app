import 'package:flutter/material.dart';

class MyColors {
  static const Color primary = Color(0xFF006BCD); // Deep Blue
  static const Color secondary = Color(0xFF3399FF); // Medium Blue
  static const Color background = Color(0xFFE3F2FD); // Light Blue
  static const Color textPrimary = Color(0xFF004C8C); // Dark Blue
  static const Color textSecondary = Color(0xFF80B9FF); // Soft Blue
}

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: MyColors.textPrimary,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: MyColors.textPrimary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}
