import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';

class AppTextStyles {
  static TextStyle titleLarge(BuildContext context) => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.getText(context), // Dynamique : textLight ou textDark
  );

  static TextStyle subtitleMedium(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    color: AppColors.textLightGrey, // Fixe pour cohérence avec HomeTab
  );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    color: AppColors.textLightGrey, // Fixe pour cohérence
  );

  static TextStyle linkSmall(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    color: AppColors.getPrimary(context), // Dynamique : primaryLight ou primaryDark
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonText(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white, // Fixe : blanc convient pour les deux modes
  );

  static TextStyle otpInputText(BuildContext context) => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.getText(context), // Dynamique : textLight ou textDark
  );

  static TextStyle otpKeyboardText(BuildContext context) => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.getText(context), // Dynamique : textLight ou textDark
  );

  static TextStyle bodyText(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    color: AppColors.getText(context), // Dynamique : textLight ou textDark
    fontWeight: FontWeight.normal,
  );
}