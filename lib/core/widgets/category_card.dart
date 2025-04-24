import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.name,
    this.onTap,
  });

  String _getCategoryImage(String categoryName) {
    String baseUrlIcons = 'assets/images/categories';
    switch (categoryName.toLowerCase()) {
      case 'programmation & tech':
        return '$baseUrlIcons/python.png';
      case 'musique & audio':
        return '$baseUrlIcons/musique.png';
      case 'graphique & design':
        return '$baseUrlIcons/graphique.png';
      case 'finance':
        return '$baseUrlIcons/finance.png';
      case 'marketing & publicité':
        return '$baseUrlIcons/marketing.png';
      case 'rédaction & traduction':
        return '$baseUrlIcons/translate.png';
      case 'photographie & vidéo':
        return '$baseUrlIcons/video.png';
      case 'vente & commerce':
        return '$baseUrlIcons/commerce.png';
      default:
        return '$baseUrlIcons/default_category.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      splashColor: AppColors.primaryBlue.withOpacity(0.2), // Effet de ripple
      child: Container(
        width: 80.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.backgroundDark : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: AppColors.cardBoxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getCategoryImage(name),
              width: 28.w,
              height: 28.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.category,
                  size: 28.sp,
                  color: AppColors.primaryBlue,
                );
              },
            ),
            SizedBox(height: 4.h),
            Text(
              name,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.getText(context),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}