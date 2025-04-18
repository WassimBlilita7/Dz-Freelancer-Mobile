import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final int index;

  const OnboardingPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final data = OnboardingModel.getOnboardingData()[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            data.imagePath,
            height: 300,
            fit: BoxFit.contain,
          )
              .animate()
              .fadeIn(duration: 800.ms)
              .slideY(begin: 0.2, end: 0.0, duration: 600.ms),
          const SizedBox(height: 40),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.getText(context),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
          const SizedBox(height: 20),
          Text(
            data.description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.getText(context).withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
        ],
      ),
    );
  }
}