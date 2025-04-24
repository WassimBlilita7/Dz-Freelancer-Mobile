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
    // Contenu différent selon isFreelancer
    final String discountText = '15%';
    final String title = isFreelancer
        ? 'Boostez vos projets !'
        : 'Black Friday !';
    final String subtitle = isFreelancer
        ? 'Obtenez 15% de réduction sur vos abonnements ce mois-ci.'
        : 'Obtenez 15% de réduction sur chaque commande ce Black Friday.';

    // Définir le dégradé ou la couleur selon le thème
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Decoration cardDecoration = BoxDecoration(
      gradient: isDarkMode
          ? const LinearGradient(
        colors: [
          AppColors.backgroundDark, // #121212
          AppColors.primaryDark, // #1976D2
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )
          : null,
      color: isDarkMode ? null : AppColors.bubbleColor1, // #42A5F5 pour le mode clair
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: AppColors.cardBoxShadow,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: cardDecoration,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      discountText,
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.9),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 8.h),
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
          SizedBox(
            width: 80.w,
            height: 80.h,
            child: Lottie.asset(
              'assets/lottie/promo.json',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms);
  }
}