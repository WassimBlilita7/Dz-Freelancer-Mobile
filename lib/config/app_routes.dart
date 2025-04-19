import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/views/login_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/views/home_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/views/splash_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/views/onboarding_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/splash': (context) => const SplashScreen(),
      '/onboarding': (context) => const OnboardingScreen(),
      '/login': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
    };
  }
}