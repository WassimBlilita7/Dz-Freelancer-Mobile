import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';

class PromoCard extends StatelessWidget {
  final bool isFreelancer;

  const PromoCard({
    super.key,
    required this.isFreelancer,
  });

  @override
  Widget build(BuildContext context) {
    final String discountText = '15%';
    final String title = isFreelancer ? 'Postuler 🔍' : 'Publiez 🚀';
    final String subtitle = isFreelancer
        ? 'Recevez 15% de réduction sur vos abonnements ce mois-ci.'
        : 'Bénéficiez de 15% de réduction sur chaque projet publié ce mois-ci.';

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Decoration cardDecoration = BoxDecoration(
      gradient: isDarkMode
          ? const LinearGradient(
        colors: [AppColors.backgroundDark, AppColors.primaryDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )
          : const LinearGradient(
        colors: [AppColors.bubbleColor1, AppColors.bubbleColor2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: AppColors.cardBoxShadow,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: cardDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discountText,
                  style: AppTextStyles.titleLarge(context).copyWith(
                    color: Colors.white,
                    fontSize: 32.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  title,
                  style: AppTextStyles.subtitleMedium(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: AppTextStyles.labelSmall(context).copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 12.h),
                SmoothPageIndicator(
                  controller: PageController(initialPage: 0),
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 6.h,
                    dotWidth: 6.w,
                    spacing: 4.w,
                    dotColor: Colors.white.withOpacity(0.4),
                    activeDotColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 1,
            child: Lottie.asset(
              'assets/lottie/promo.json',
              height: 80.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ).animate()
        .slideY(begin: 0.2, end: 0.0, duration: 600.ms)
        .fadeIn(duration: 600.ms, delay: 400.ms);
  }
}
