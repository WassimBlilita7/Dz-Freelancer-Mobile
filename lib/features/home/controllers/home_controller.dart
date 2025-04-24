import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/core/middleware/auth_middleware.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/category_api_service.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/views/login_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/models/category_model.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';

class HomeController {
  final HomeProvider provider;
  final ApiService apiService;
  final CategoryApiService categoryApiService;

  HomeController(this.provider, this.apiService, this.categoryApiService);

  Future<void> fetchUserProfile() async {
    if (provider.model.username != null && provider.model.isFreelancer != null) {
      return;
    }

    try {
      provider.setLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt-freelancerDZ');

      if (token == null) {
        throw Exception('Utilisateur non authentifié');
      }

      final response = await apiService.getUserProfile(token);

      final userData = response['userData'] as Map<String, dynamic>;
      final username = userData['username'] as String;
      final isFreelancer = userData['isFreelancer'] as bool;

      provider.setUserData(username, isFreelancer);
    } catch (e) {
      provider.setError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      provider.setLoading(false);
    }
  }

  Future<void> fetchCategories() async {
    try {
      provider.setLoading(true);
      final categoriesJson = await categoryApiService.getAllCategories();
      final categories = categoriesJson.map((json) => CategoryModel.fromJson(json)).toList();
      provider.setCategories(categories);
    } catch (e) {
      provider.setError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      provider.setLoading(false);
    }
  }

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
            (Route<dynamic> route) => false,
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