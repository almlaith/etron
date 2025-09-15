import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3A5DAE)),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.vazirmatn(fontSize: 48, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.vazirmatn(fontSize: 36),
      displaySmall: GoogleFonts.vazirmatn(fontSize: 24),

      headlineLarge: GoogleFonts.vazirmatn(fontSize: 24, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.vazirmatn(fontSize: 20),
      headlineSmall: GoogleFonts.vazirmatn(fontSize: 18),

      titleLarge: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.alexandria(fontSize: 18),
      titleSmall: GoogleFonts.alexandria(fontSize: 16),

      bodyLarge: GoogleFonts.vazirmatn(fontSize: 16),
      bodyMedium: GoogleFonts.vazirmatn(fontSize: 14),
      bodySmall: GoogleFonts.vazirmatn(fontSize: 12),

      labelLarge: GoogleFonts.alexandria(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.alexandria(fontSize: 12),
      labelSmall: GoogleFonts.alexandria(fontSize: 10),
    ),
  );
}
