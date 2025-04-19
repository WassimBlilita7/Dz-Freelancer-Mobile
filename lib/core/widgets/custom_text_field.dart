import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 16.sp, color: AppColors.getText(context)),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.getText(context).withOpacity(0.6)),
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.getPrimary(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.getAccent(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.getPrimary(context), width: 2.w),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }
}