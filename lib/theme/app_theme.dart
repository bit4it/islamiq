import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryGreen = Color(0xFF0D8E6F);
  static const Color primaryGreenDark = Color(0xFF0A7458);
  static const Color primaryGreenLight = Color(0xFF4DB69D);
  static const Color accentGreen = Color(0xFFE8F5F1);
  static const Color accentGreenLight = Color(0xFFE8F5F1);
  static const Color accentBlue = Color(0xFFE3F2FD);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFFBF8F7);
  static const Color backgroundWhite = Colors.white;
  
  // Text Colors
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color textMedium = Color(0xFF594F4A);
  static const Color textLight = Color(0xFF6B6B6B);
  static const Color textWhite = Colors.white;
  static const Color textGreen =  Color(0xFF2C2C2C);
  static const Color textGreenLight =  Color(0xFF2C2C2C);
  static const Color textGreenMedium =  Color(0xFF2C2C2C);
  
  // Card Colors
  static const Color cardLight = Color(0xFFF6F1ED);
  static const Color cardGreen = Color(0xFF0D8E6F);
  static const Color cardGreenLight = Color.fromARGB(255, 215, 245, 236);
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D8E6F),
      Color(0xFF0FA678),
    ],
  );
  
  // Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x10000000),
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> lightShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];
  
  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textDark,
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textMedium,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textMedium,
  );
  
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 16,
    color: textLight,
  );
  
  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryGreen,
    foregroundColor: textWhite,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );
}