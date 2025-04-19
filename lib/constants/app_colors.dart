import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  // Light mode colors
  static const Color primaryLight = Color(0xFF2196F3); // Blue
  static const Color backgroundLight = Color(0xFFFFFFFF); // White
  static const Color textLight = Color(0xFF212121); // Dark gray
  static const Color accentLight = Color(0xFFFFC107); // Amber
  static const Color primaryGreen = Color(0xFF2E9ACC);

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

  static const bubbleColor1 = Color(0xFF42A5F5); // Bleu moderne
  static const bubbleColor2 = Color(0xFFAB47BC); // Violet vibrant
  static const bubbleColor3 = Color(0xFF26A69A); // Teal frais

  // Dégradé pour le bouton
  static const buttonGradient = LinearGradient(
    colors: [bubbleColor1, bubbleColor2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Style pour la carte
  static final cardBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10.r,
      offset: Offset(0, 5.h),
    ),
  ];

  // Style pour l'ombre du logo
  static final logoBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 8.r,
      offset: Offset(0, 4.h),
    ),
  ];
  static const primaryBlue = Color(0xFF1565C0); // Bleu pour le bouton et le lien
  static const textDarkGrey = Color(0xFF333333); // Gris foncé pour le titre
  static const textLightGrey = Color(0xFF666666); // Gris clair pour le sous-titre

}