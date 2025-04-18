import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final int index;

  const OnboardingPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final data = OnboardingModel.getOnboardingData()[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w), // Marge responsive
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            data.imagePath,
            height: 300.h, // Hauteur responsive
            fit: BoxFit.contain,
          )
              .animate()
              .fadeIn(duration: 800.ms)
              .slideY(begin: 0.2, end: 0.0, duration: 600.ms),
          SizedBox(height: 40.h), // Espacement responsive
          Text(
            data.title,
            style: TextStyle(
              fontSize: 24.sp, // Taille de police responsive
              fontWeight: FontWeight.bold,
              color: AppColors.getText(context),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
          SizedBox(height: 20.h), // Espacement responsive
          Text(
            data.description,
            style: TextStyle(
              fontSize: 16.sp, // Taille de police responsive
              color: AppColors.getText(context).withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
        ],
      ),
    );
  }
}