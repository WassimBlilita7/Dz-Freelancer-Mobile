import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final bool isLoading;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.borderRadius = 12.0,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: textColor,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}