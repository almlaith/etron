import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme buildTextTheme(BuildContext context) {
  final isArabic = Directionality.of(context) == TextDirection.rtl;
  final base = Theme.of(context).textTheme;

  return TextTheme(
    displayLarge: isArabic
        ? GoogleFonts.tajawal(textStyle: base.displayLarge)
        : GoogleFonts.exo2(textStyle: base.displayLarge),
    displayMedium: isArabic
        ? GoogleFonts.tajawal(textStyle: base.displayMedium)
        : GoogleFonts.exo2(textStyle: base.displayMedium),
    displaySmall: isArabic
        ? GoogleFonts.tajawal(textStyle: base.displaySmall)
        : GoogleFonts.exo2(textStyle: base.displaySmall),
    headlineLarge: isArabic
        ? GoogleFonts.tajawal(textStyle: base.headlineLarge)
        : GoogleFonts.exo2(textStyle: base.headlineLarge),
    headlineMedium: isArabic
        ? GoogleFonts.tajawal(textStyle: base.headlineMedium)
        : GoogleFonts.exo2(textStyle: base.headlineMedium),
    headlineSmall: isArabic
        ? GoogleFonts.tajawal(textStyle: base.headlineSmall)
        : GoogleFonts.exo2(textStyle: base.headlineSmall),
    titleLarge: isArabic
        ? GoogleFonts.tajawal(textStyle: base.titleLarge)
        : GoogleFonts.exo2(textStyle: base.titleLarge),
    titleMedium: isArabic
        ? GoogleFonts.tajawal(textStyle: base.titleMedium)
        : GoogleFonts.exo2(textStyle: base.titleMedium),
    titleSmall: isArabic
        ? GoogleFonts.tajawal(textStyle: base.titleSmall)
        : GoogleFonts.exo2(textStyle: base.titleSmall),
    bodyLarge: isArabic
        ? GoogleFonts.tajawal(textStyle: base.bodyLarge)
        : GoogleFonts.exo2(textStyle: base.bodyLarge),
    bodyMedium: isArabic
        ? GoogleFonts.tajawal(textStyle: base.bodyMedium)
        : GoogleFonts.exo2(textStyle: base.bodyMedium),
    bodySmall: isArabic
        ? GoogleFonts.tajawal(textStyle: base.bodySmall)
        : GoogleFonts.exo2(textStyle: base.bodySmall),
    labelLarge: isArabic
        ? GoogleFonts.tajawal(textStyle: base.labelLarge)
        : GoogleFonts.exo2(textStyle: base.labelLarge),
    labelMedium: isArabic
        ? GoogleFonts.tajawal(textStyle: base.labelMedium)
        : GoogleFonts.exo2(textStyle: base.labelMedium),
    labelSmall: isArabic
        ? GoogleFonts.tajawal(textStyle: base.labelSmall)
        : GoogleFonts.exo2(textStyle: base.labelSmall),
  );
}
