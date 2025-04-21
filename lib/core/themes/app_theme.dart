import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.deepBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      appBarStyle: FlexAppBarStyle.custom,
      appBarBackground: const Color(0xFFF8FAFC), // Blanc cassé comme base
      appBarOpacity: 1.0, // Pas de transparence, on gérera le dégradé dans le widget
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        navigationBarOpacity: 0.95,
        navigationBarHeight: 60.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      primary: const Color(0xFF6D28D9),
      secondary: const Color(0xFF6B7280),
      surface: const Color(0xFFFFFFFF),
      error: const Color(0xFFE74C3C),
      fontFamily: 'Poppins',
    );
  }

  static ThemeData darkTheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.deepBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      appBarStyle: FlexAppBarStyle.custom,
      appBarBackground: const Color(0xFF1E1E2F), // Gris anthracite comme base
      appBarOpacity: 1.0, // Pas de transparence, on gérera le dégradé dans le widget
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        navigationBarOpacity: 0.95,
        navigationBarHeight: 60.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      primary: const Color(0xFF6D28D9),
      secondary: const Color(0xFF6B7280),
      surface: const Color(0xFF1F2937),
      error: const Color(0xFFE74C3C),
      fontFamily: 'Poppins',
    );
  }
}