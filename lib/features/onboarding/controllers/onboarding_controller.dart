import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/middleware/auth_middleware.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/providers/onboarding_provider.dart';

class OnboardingController {
  final OnboardingProvider provider;
  final PageController pageController;

  OnboardingController(this.provider) : pageController = PageController();

  Future<void> nextPage() async {
    if (provider.currentPage < 2) {
      provider.setCurrentPage(provider.currentPage + 1);
      await pageController.animateToPage(
        provider.currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await completeOnboarding();
    }
  }

  void onPageChanged(int page) {
    provider.setCurrentPage(page);
  }

  Future<void> skipOnboarding() async {
    final authMiddleware = AuthMiddleware();
    await authMiddleware.setHasSeenOnboarding();
    await provider.completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    final authMiddleware = AuthMiddleware();
    await authMiddleware.setHasSeenOnboarding();
    await provider.completeOnboarding();
  }

  void dispose() {
    pageController.dispose();
  }
}