import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/providers/onboarding_provider.dart';

class OnboardingController {
  final OnboardingProvider provider;
  final PageController pageController;

  OnboardingController(this.provider) : pageController = PageController();

  void nextPage() {
    if (provider.currentPage < 2) {
      provider.setCurrentPage(provider.currentPage + 1);
      pageController.animateToPage(
        provider.currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      provider.completeOnboarding();
    }
  }

  void onPageChanged(int page) {
    provider.setCurrentPage(page);
  }

  void skipOnboarding() {
    provider.completeOnboarding();
  }

  void dispose() {
    pageController.dispose();
  }
}