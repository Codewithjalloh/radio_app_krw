import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette
  static const Color primaryColor = Color(0xFFe94560);
  static const Color primaryVariant = Color(0xFFf27121);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFF2196F3);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);

  // Background Colors
  static const Color backgroundDark = Color(0xFFFFFFFF);
  static const Color backgroundCard = Color(0xFFFAFAFA);
  static const Color backgroundElevated = Color(0xFFFFFFFF);
  static const Color backgroundSurface = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  static const Color textDisabled = Color(0xFFCCCCCC);

  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMedium = Color(0xFFD0D0D0);
  static const Color borderDark = Color(0xFFB0B0B0);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMediumColor = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryVariant],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundDark, backgroundCard],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [backgroundCard, backgroundElevated],
  );

  // Text Styles
  static TextStyle get heading1 => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.2,
  );

  static TextStyle get heading2 => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.3,
  );

  static TextStyle get heading3 => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );

  static TextStyle get heading4 => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondary,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textTertiary,
    height: 1.4,
  );

  static TextStyle get caption => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: textTertiary,
    height: 1.3,
  );

  static TextStyle get button => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.2,
  );

  static TextStyle get buttonSmall => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.2,
  );

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusRound = 50.0;

  // Elevation
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Box Shadows
  static List<BoxShadow> get shadowSmall => [
    BoxShadow(color: shadowLight, blurRadius: 4, offset: const Offset(0, 2)),
  ];

  static List<BoxShadow> get shadowMedium => [
    BoxShadow(
      color: shadowMediumColor,
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowLarge => [
    BoxShadow(color: shadowDark, blurRadius: 16, offset: const Offset(0, 8)),
  ];

  static List<BoxShadow> get shadowGlow => [
    BoxShadow(
      color: primaryColor.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  // Card Styles
  static BoxDecoration get cardDecoration => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(radiusL),
    border: Border.all(color: borderLight, width: 1),
    boxShadow: shadowMedium,
  );

  static BoxDecoration get cardDecorationElevated => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(radiusL),
    border: Border.all(color: borderMedium, width: 1),
    boxShadow: shadowLarge,
  );

  static BoxDecoration get cardDecorationPrimary => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(radiusL),
    boxShadow: shadowGlow,
  );

  // Button Styles
  static BoxDecoration get buttonPrimaryDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(radiusM),
    boxShadow: shadowMedium,
  );

  static BoxDecoration get buttonSecondaryDecoration => BoxDecoration(
    color: backgroundCard,
    borderRadius: BorderRadius.circular(radiusM),
    border: Border.all(color: borderLight, width: 1),
    boxShadow: shadowSmall,
  );

  static BoxDecoration get buttonOutlineDecoration => BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(radiusM),
    border: Border.all(color: primaryColor, width: 2),
  );

  // Input Field Styles
  static BoxDecoration get inputDecoration => BoxDecoration(
    color: backgroundCard,
    borderRadius: BorderRadius.circular(radiusM),
    border: Border.all(color: borderLight, width: 1),
  );

  static BoxDecoration get inputDecorationFocused => BoxDecoration(
    color: backgroundCard,
    borderRadius: BorderRadius.circular(radiusM),
    border: Border.all(color: primaryColor, width: 2),
    boxShadow: shadowGlow,
  );

  // Navigation Styles
  static BoxDecoration get navItemDecoration => BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(radiusM),
  );

  static BoxDecoration get navItemActiveDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(radiusM),
    boxShadow: shadowMedium,
  );

  // Progress Indicator Styles
  static BoxDecoration get progressTrackDecoration => BoxDecoration(
    color: backgroundCard,
    borderRadius: BorderRadius.circular(radiusS),
  );

  static BoxDecoration get progressFillDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(radiusS),
  );
}
