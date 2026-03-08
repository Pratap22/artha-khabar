import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand colors from Arthakhabar logo
  static const Color primaryRed = Color(0xFFE60023);
  static const Color primaryBlue = Color(0xFF003399);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.muktaTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryRed,
        primary: primaryRed,
        secondary: primaryBlue,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: primaryBlue,
        elevation: 0,
        titleTextStyle: GoogleFonts.mukta(
          color: primaryBlue,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: primaryRed,
        labelColor: primaryRed,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.mukta(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.mukta(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
