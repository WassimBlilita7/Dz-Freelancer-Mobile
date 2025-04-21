import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.deepBlue, // Base pour les autres couleurs
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 0.95,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        navigationBarOpacity: 0.95,
        navigationBarHeight: 60.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // Personnalisation des couleurs spécifiques
      primary: const Color(0xFF6D28D9), // Violet foncé pour les icônes sélectionnées
      secondary: const Color(0xFF6B7280), // Gris pour les icônes non sélectionnées
      surface: const Color(0xFFFFFFFF), // Fond blanc pour la navbar
      error: const Color(0xFFE74C3C), // errorRed
      fontFamily: 'Poppins',
    );
  }

  static ThemeData darkTheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.deepBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      appBarStyle: FlexAppBarStyle.primary,
      appBarOpacity: 0.90,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        navigationBarOpacity: 0.95,
        navigationBarHeight: 60.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // Personnalisation des couleurs spécifiques
      primary: const Color(0xFF6D28D9), // Violet foncé pour les icônes sélectionnées
      secondary: const Color(0xFF6B7280), // Gris pour les icônes non sélectionnées
      surface: const Color(0xFF1F2937), // Gris foncé pour le fond en mode sombre
      error: const Color(0xFFE74C3C), // errorRed
      fontFamily: 'Poppins',
    );
  }
}