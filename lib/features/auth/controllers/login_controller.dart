import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/login_provider.dart';

import '../../../core/services/api_services.dart';

class LoginController {
  final LoginProvider provider;
  final ApiService apiService;

  LoginController(this.provider, this.apiService);

  bool _isValidEmail(String email) {
    const emailRegex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
    return RegExp(emailRegex).hasMatch(email);
  }

  Future<void> login(BuildContext context) async {
    final email = provider.model.email;
    final password = provider.model.password;

    if (email.isEmpty || password.isEmpty) {
      provider.setError('Veuillez remplir tous les champs');
      return;
    }

    if (!_isValidEmail(email)) {
      provider.setError('Veuillez entrer un email valide');
      return;
    }

    provider.setLoading(true);
    try {
      final response = await apiService.login(email, password);
      provider.setLoading(false);

      final token = response['token'] as String;
      final userData = response['userData'] as Map<String, dynamic>;

      // Sauvegarder le token et les données utilisateur
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt-freelancerDZ', token);
      await prefs.setString('userData', jsonEncode(userData));

      provider.setUserData(userData, token);

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      provider.setLoading(false);
      provider.setError(e.toString());
    }
  }
}