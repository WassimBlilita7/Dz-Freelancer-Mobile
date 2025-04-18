import 'package:flutter/material.dart';

class AppColors {
  // Light mode colors
  static const Color primaryLight = Color(0xFF2196F3); // Blue
  static const Color backgroundLight = Color(0xFFFFFFFF); // White
  static const Color textLight = Color(0xFF212121); // Dark gray
  static const Color accentLight = Color(0xFFFFC107); // Amber

  // Dark mode colors
  static const Color primaryDark = Color(0xFF1976D2); // Darker blue
  static const Color backgroundDark = Color(0xFF121212); // Dark gray
  static const Color textDark = Color(0xFFE0E0E0); // Light gray
  static const Color accentDark = Color(0xFFFFB300); // Darker amber

  // Get colors based on theme
  static Color getPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? primaryDark : primaryLight;
  }

  static Color getBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? backgroundDark : backgroundLight;
  }

  static Color getText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? textDark : textLight;
  }

  static Color getAccent(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? accentDark : accentLight;
  }
}