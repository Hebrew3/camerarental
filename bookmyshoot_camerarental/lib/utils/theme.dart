import 'package:flutter/material.dart';

class CinematicColors {
  // Dark theme colors
  static const Color primary = Color(0xFF0A0A0A); // Deep black
  static const Color primaryVariant = Color(0xFF1A1A2E); // Dark blue-black
  static const Color secondary = Color(0xFFD4AF37); // Cinematic gold
  static const Color secondaryVariant = Color(0xFFB8860B); // Darker gold
  static const Color background = Color(0xFF0F0F0F); // Very dark background
  static const Color surface = Color(0xFF1E1E1E); // Dark surface
  static const Color surfaceVariant = Color(0xFF2D2D2D); // Lighter surface
  static const Color onPrimary = Color(0xFFFFFFFF); // White text on primary
  static const Color onSecondary = Color(0xFF000000); // Black text on gold
  static const Color onBackground = Color(0xFFE0E0E0); // Light text on dark background
  static const Color onSurface = Color(0xFFE0E0E0); // Light text on surface
  static const Color accent = Color(0xFF00B4D8); // Cinematic blue
  static const Color accentVariant = Color(0xFF0077B6); // Darker blue
  static const Color highlight = Color(0xFFFFD700); // Bright gold highlight
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color error = Color(0xFFE74C3C); // Red

  // Light theme colors
  static const Color lightPrimary = Color(0xFF1976D2); // Material blue
  static const Color lightPrimaryVariant = Color(0xFF1565C0); // Darker blue
  static const Color lightSecondary = Color(0xFFD4AF37); // Keep cinematic gold
  static const Color lightSecondaryVariant = Color(0xFFB8860B); // Darker gold
  static const Color lightBackground = Color(0xFFFAFAFA); // Light background
  static const Color lightSurface = Color(0xFFFFFFFF); // White surface
  static const Color lightSurfaceVariant = Color(0xFFF5F5F5); // Light surface variant
  static const Color lightOnPrimary = Color(0xFFFFFFFF); // White text on primary
  static const Color lightOnSecondary = Color(0xFF000000); // Black text on gold
  static const Color lightOnBackground = Color(0xFF212121); // Dark text on light background
  static const Color lightOnSurface = Color(0xFF212121); // Dark text on surface
  static const Color lightAccent = Color(0xFF00B4D8); // Keep cinematic blue
  static const Color lightAccentVariant = Color(0xFF0077B6); // Darker blue
  static const Color lightHighlight = Color(0xFFFFD700); // Keep bright gold
  static const Color lightSuccess = Color(0xFF4CAF50); // Green
  static const Color lightWarning = Color(0xFFFF9800); // Orange
  static const Color lightError = Color(0xFFE74C3C); // Red

  static const List<Color> primaryGradient = [
    Color(0xFF0A0A0A),
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
  ];

  static const List<Color> lightPrimaryGradient = [
    Color(0xFF1976D2),
    Color(0xFF1565C0),
    Color(0xFF0D47A1),
  ];

  static const List<Color> goldGradient = [
    Color(0xFFD4AF37),
    Color(0xFFB8860B),
    Color(0xFF8B6914),
  ];

  static const List<Color> cinematicGradient = [
    Color(0xFF0A0A0A),
    Color(0xFF1A1A2E),
    Color(0xFF00B4D8),
  ];

  static const List<Color> lightCinematicGradient = [
    Color(0xFFFAFAFA),
    Color(0xFFE3F2FD),
    Color(0xFF00B4D8),
  ];
}

// Dark theme
final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: CinematicColors.primary,
    onPrimary: CinematicColors.onPrimary,
    secondary: CinematicColors.secondary,
    onSecondary: CinematicColors.onSecondary,
    surface: CinematicColors.surface,
    onSurface: CinematicColors.onSurface,
    background: CinematicColors.background,
    onBackground: CinematicColors.onBackground,
    error: CinematicColors.error,
    onError: CinematicColors.onPrimary,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: CinematicColors.primary,
    foregroundColor: CinematicColors.onPrimary,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: CinematicColors.onPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: CinematicColors.surface,
    selectedItemColor: CinematicColors.secondary,
    unselectedItemColor: CinematicColors.onSurface,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  cardTheme: CardThemeData(
    color: CinematicColors.surface,
    elevation: 4,
    shadowColor: CinematicColors.primary.withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CinematicColors.secondary,
      foregroundColor: CinematicColors.onSecondary,
      elevation: 4,
      shadowColor: CinematicColors.secondary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: CinematicColors.secondary,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: CinematicColors.surfaceVariant,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: CinematicColors.secondary, width: 2),
    ),
    labelStyle: const TextStyle(color: CinematicColors.onSurface),
    hintStyle: TextStyle(color: CinematicColors.onSurface.withOpacity(0.6)),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.25,
    ),
    displaySmall: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: CinematicColors.onBackground,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
  ),
  scaffoldBackgroundColor: CinematicColors.background,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
);

// Light theme
final ThemeData lightAppTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: CinematicColors.lightPrimary,
    onPrimary: CinematicColors.lightOnPrimary,
    secondary: CinematicColors.lightSecondary,
    onSecondary: CinematicColors.lightOnSecondary,
    surface: CinematicColors.lightSurface,
    onSurface: CinematicColors.lightOnSurface,
    background: CinematicColors.lightBackground,
    onBackground: CinematicColors.lightOnBackground,
    error: CinematicColors.lightError,
    onError: CinematicColors.lightOnPrimary,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: CinematicColors.lightPrimary,
    foregroundColor: CinematicColors.lightOnPrimary,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: CinematicColors.lightOnPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: CinematicColors.lightSurface,
    selectedItemColor: CinematicColors.lightSecondary,
    unselectedItemColor: CinematicColors.lightOnSurface,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  cardTheme: CardThemeData(
    color: CinematicColors.lightSurface,
    elevation: 4,
    shadowColor: CinematicColors.lightPrimary.withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CinematicColors.lightSecondary,
      foregroundColor: CinematicColors.lightOnSecondary,
      elevation: 4,
      shadowColor: CinematicColors.lightSecondary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: CinematicColors.lightSecondary,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: CinematicColors.lightSurfaceVariant,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: CinematicColors.lightSecondary, width: 2),
    ),
    labelStyle: const TextStyle(color: CinematicColors.lightOnSurface),
    hintStyle: TextStyle(color: CinematicColors.lightOnSurface.withOpacity(0.6)),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.25,
    ),
    displaySmall: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: CinematicColors.lightOnBackground,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
  ),
  scaffoldBackgroundColor: CinematicColors.lightBackground,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
);