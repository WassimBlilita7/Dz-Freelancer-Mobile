import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/core/middleware/auth_middleware.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/login_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/views/login_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/views/home_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/views/onboarding_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final authMiddleware = AuthMiddleware();
    final isLoggedIn = await authMiddleware.isUserLoggedIn();
    final hasSeenOnboarding = await authMiddleware.hasSeenOnboarding();

    if (isLoggedIn) {
      final authData = await authMiddleware.getAuthData();
      if (authData != null) {
        final loginProvider = Provider.of<LoginProvider>(context, listen: false);
        loginProvider.setUserData(context, authData['userData'], authData['token']);
      }
    }

    setState(() {
      _isLoggedIn = isLoggedIn;
      _hasSeenOnboarding = hasSeenOnboarding;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasSeenOnboarding) {
      return const OnboardingScreen();
    }

    return _isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}