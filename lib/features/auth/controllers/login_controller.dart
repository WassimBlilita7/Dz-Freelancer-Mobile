import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/login_provider.dart';

class LoginController {
  final LoginProvider provider;
  final ApiService apiService;

  LoginController(this.provider, this.apiService);

  bool _isValidEmail(String email) {
    const emailRegex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
    return RegExp(emailRegex).hasMatch(email);
  }

  Future<void> _validateInputs(BuildContext context) async {
    final email = provider.model.email;
    final password = provider.model.password;

    if (email.isEmpty || password.isEmpty) {
      provider.setError(context, 'Veuillez remplir tous les champs');
      throw Exception('Champs incomplets');
    }

    if (!_isValidEmail(email)) {
      provider.setError(context, 'Veuillez entrer un email valide');
      throw Exception('Email invalide');
    }
  }

  Future<void> _saveAuthData(String token, Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt-freelancerDZ', token);
    await prefs.setString('userData', jsonEncode(userData));

    if (kDebugMode) {
      print('LoginController: Saved token = $token');
      print('LoginController: Saved userData = $userData');
    }
  }

  Future<void> _navigateToHome(BuildContext context) async {
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      await _validateInputs(context);

      provider.setLoading(true);
      final response = await apiService.login(provider.model.email, provider.model.password);

      final token = response['token'] as String;
      final userData = response['userData'] as Map<String, dynamic>;

      await _saveAuthData(token, userData);
      provider.setUserData(context, userData, token);

      await _navigateToHome(context);
    } catch (e) {
      provider.setLoading(false);
      provider.setError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      provider.setLoading(false);
    }
  }
}