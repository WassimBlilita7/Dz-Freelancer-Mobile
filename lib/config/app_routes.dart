import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/views/splash_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/views/onboarding_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/splash': (context) => const SplashScreen(),
      '/onboarding': (context) => const OnboardingScreen(),
      '/home': (context) => const Scaffold(body: Center(child: Text('Écran d\'accueil'))),
    };
  }
}