import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';

class AppTextStyles {
  // Style pour les titres principaux (ex: "Créer un compte")
  static TextStyle titleLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textDarkGrey,
  );

  // Style pour les sous-titres (ex: "Rejoignez Wassit Freelancer DZ !")
  static TextStyle subtitleMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightGrey,
  );

  // Style pour les labels des champs (ex: "Nom d'utilisateur")
  static TextStyle labelSmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightGrey,
  );

  // Style pour le texte saisi dans les TextField
  static TextStyle inputText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textDarkGrey,
  );

  // Style pour le texte des boutons (ex: "S'inscrire")
  static TextStyle buttonText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Style pour les liens (ex: "Connectez-vous ici")
  static TextStyle linkSmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryGreen,
  );

  // Style pour les messages d'erreur
  static TextStyle errorText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  );

  // Style pour les chiffres du clavier OTP
  static TextStyle otpKeyboardText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textDarkGrey,
  );

  // Style pour le texte des champs OTP
  static TextStyle otpInputText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textDarkGrey,
  );
}