import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.deepBlue,
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
      primary: const Color(0xFF1565C0), // primaryBlue
      secondary: const Color(0xFF666666), // textLightGrey pour les éléments non sélectionnés
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
      primary: const Color(0xFF1565C0), // primaryBlue
      secondary: const Color(0xFF666666), // textLightGrey pour les éléments non sélectionnés
      error: const Color(0xFFE74C3C), // errorRed
      fontFamily: 'Poppins',
    );
  }
}