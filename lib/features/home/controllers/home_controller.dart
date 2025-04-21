import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';

import '../../../core/services/api_services.dart';

class HomeController {
  final HomeProvider provider;
  final ApiService apiService;

  HomeController(this.provider, this.apiService);

  Future<void> logout(BuildContext context) async {
    provider.setLoading(true);
    try {
      await apiService.logout();

      // Supprimer les données locales
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt-freelancerDZ');
      await prefs.remove('userData');

      provider.setLoading(false);
      provider.clearError();
      provider.setSuccess(context, 'Déconnexion réussie !');

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      provider.setLoading(false);
      provider.setError(context, e.toString().replaceFirst('Exception: ', ''));
    }
  }
}