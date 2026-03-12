import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // The Void
  static const Color pureBlack = Color(0xFF000000);
  static const Color voidBlack = Color(0xFF050505);
  static const Color shadowGray = Color(0xFF0A0A0A);
  
  // Illumination Colors (Category Based)
  static const Color survivalRed = Color(0xFFFF2D55);      // Danger/Urgency
  static const Color foodGold = Color(0xFFFFD60A);         // Warm/Texture
  static const Color peopleAmber = Color(0xFFFF9F0A);      // Human connection
  static const Color natureEmerald = Color(0xFF30D158);    // Organic
  static const Color abstractViolet = Color(0xFFBF5AF2);   // Mystery
  static const Color waterCyan = Color(0xFF64D2FF);        // Clarity
  
  // Flashlight Spectrum
  static const Color flashlightCore = Color(0xFFFFFFFF);
  static const Color flashlightHalo = Color(0xFFFFE4B5);
  static const Color flashlightEdge = Color(0x40FFFFFF);
  static const Color flashlightYellow = Color(0xFFFFD60A);

  
  // Battery States
  static const Color batteryFull = Color(0xFF30D158);
  static const Color batteryMedium = Color(0xFFFFD60A);
  static const Color batteryCritical = Color(0xFFFF453A);
  static const Color batteryDead = Color(0xFF8E8E93);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: pureBlack,
      colorScheme: const ColorScheme.dark(
        primary: flashlightCore,
        surface: shadowGray,
        onSurface: flashlightCore,
      ),
      textTheme: GoogleFonts.interTightTextTheme().copyWith(
        displayLarge: GoogleFonts.interTight(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: flashlightCore,
          letterSpacing: -2,
          height: 1.1,
        ),
        headlineLarge: GoogleFonts.interTight(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: flashlightCore,
          letterSpacing: -1,
        ),
        titleLarge: GoogleFonts.interTight(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: flashlightCore,
        ),
        bodyLarge: GoogleFonts.interTight(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: flashlightCore.withValues(alpha: 0.9),
          letterSpacing: 0.5,
        ),
        bodyMedium: GoogleFonts.interTight(
          fontSize: 14,
          color: flashlightCore.withValues(alpha: 0.7),
          letterSpacing: 0.3,
        ),
        labelLarge: GoogleFonts.interTight(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: flashlightCore.withValues(alpha: 0.5),
          letterSpacing: 1,
        ),
      ),
      iconTheme: const IconThemeData(color: flashlightCore, size: 24),
    );
  }
}
