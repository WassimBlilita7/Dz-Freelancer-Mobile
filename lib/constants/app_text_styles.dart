import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle titleLarge = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle subtitleMedium = TextStyle(
    fontSize: 16.sp,
    color: Colors.grey,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 14.sp,
    color: Colors.grey,
  );

  static TextStyle linkSmall = TextStyle(
    fontSize: 14.sp,
    color: Colors.blue,
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle otpInputText = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle otpKeyboardText = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  // Ajout du style bodyText pour le texte saisi dans les champs de texte
  static TextStyle bodyText = TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
}