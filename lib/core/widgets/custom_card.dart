import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/models/post_model.dart';

class CustomCard extends StatelessWidget {
  final PostModel post;
  final int index; // Pour alterner les couleurs

  const CustomCard({
    super.key,
    required this.post,
    required this.index,
  });

  // Palette de couleurs pour light et dark themes
  static const List<Map<String, Color>> _colorPalette = [
    {
      'light': Color(0xFF2A6A7F), // Bleu-vert profond
      'dark': Color(0xFF1A4A5F), // Bleu-vert sombre
    },
    {
      'light': Color(0xFFF28C38), // Orange vif
      'dark': Color(0xFFD9752A), // Orange sombre
    },
    {
      'light': Color(0xFF6B48FF), // Violet vibrant
      'dark': Color(0xFF5A3AD9), // Violet sombre
    },
    {
      'light': Color(0xFF4FC3C7), // Bleu-vert clair
      'dark': Color(0xFF3AA0A4), // Bleu-vert sombre
    },
    {
      'light': Color(0xFFE91E63), // Rose vif
      'dark': Color(0xFFC2185B), // Rose sombre
    },
  ];

  Color _getCardColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorMap = _colorPalette[index % _colorPalette.length];
    return isDark ? colorMap['dark']! : colorMap['light']!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _getCardColor(context).withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          if (post.picture != null)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.network(
                post.picture!,
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120.h,
                  color: Theme.of(context).colorScheme.surface,
                  child: Icon(Icons.broken_image, size: 40.sp, color: AppColors.textLightGrey),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms),
          // Contenu
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: AppTextStyles.titleLarge(context).copyWith(
                    color: _getCardColor(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
                SizedBox(height: 8.h),
                Text(
                  post.description,
                  style: AppTextStyles.bodyText(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.monetization_on, size: 16.sp, color: AppColors.textLightGrey),
                    SizedBox(width: 4.w),
                    Text(
                      '${post.budget} DZD',
                      style: AppTextStyles.bodyText(context).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.timer, size: 16.sp, color: AppColors.textLightGrey),
                    SizedBox(width: 4.w),
                    Text(
                      post.duration,
                      style: AppTextStyles.bodyText(context),
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.category, size: 16.sp, color: AppColors.textLightGrey),
                    SizedBox(width: 4.w),
                    Text(
                      post.category?.name ?? 'Inconnue',
                      style: AppTextStyles.bodyText(context),
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}