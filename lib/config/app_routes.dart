import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/views/login_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/views/signup_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/views/verify_otp_screen.dart';

import '../features/home/views/home_screen.dart';
import '../features/onboarding/views/onboarding_screen.dart';
import '../features/post/screens/create_post_screen.dart';
import '../features/splash/views/splash_screen.dart';


Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/splash': (context) => const SplashScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/verify-otp': (context) => const VerifyOtpScreen(),
    '/home': (context) => const HomeScreen(),
    '/create_post': (context) => const CreatePostScreen()
  };
}