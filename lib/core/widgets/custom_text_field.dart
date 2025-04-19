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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16.sp, color: AppColors.getText(context)),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.getText(context).withOpacity(0.6),
            fontSize: 14.sp,
          ),
          errorText: errorText,
          prefixIcon: Icon(
            isPassword ? Icons.lock : Icons.person,
            color: AppColors.getText(context).withOpacity(0.6),
            size: 20.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }
}