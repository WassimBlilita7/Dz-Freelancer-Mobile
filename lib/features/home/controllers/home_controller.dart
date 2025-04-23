import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/middleware/auth_middleware.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/models/home_model.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';

import '../../auth/views/login_screen.dart';

class HomeController {
  final HomeProvider provider;
  final ApiService apiService;

  HomeController(this.provider, this.apiService);

  Future<void> _clearAuthData() async {
    final authMiddleware = AuthMiddleware();
    await authMiddleware.clearAuthData();
    if (kDebugMode) {
      print('HomeController: Auth data cleared');
    }
  }

  Future<void> _callLogoutApi() async {
    try {
      await apiService.logout();
      if (kDebugMode) {
        print('HomeController: Logout API called successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('HomeController: Logout API error - $e');
      }
      // Ignorer les erreurs de l'API pour ne pas bloquer la déconnexion
    }
  }

  Future<void> _navigateToLogin(BuildContext context) async {
    if (context.mounted) {
      if (kDebugMode) {
        print('HomeController: Navigating to /login');
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false, // Retire toutes les routes précédentes
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    provider.setLoading(true);
    try {
      await _callLogoutApi();
      await _clearAuthData();
      provider.clear();
      await _navigateToLogin(context);
    } catch (e) {
      if (kDebugMode) {
        print('HomeController: Logout error - $e');
      }
    } finally {
      provider.setLoading(false);
    }
  }
}