import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/providers/signup_provider.dart';

class SignupController {
  final SignupProvider provider;
  final ApiService apiService;

  SignupController(this.provider, this.apiService);

  bool _isValidEmail(String email) {
    const emailRegex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
    return RegExp(emailRegex).hasMatch(email);
  }

  bool _isValidUsername(String username) {
    return username.length >= 5 && username.length <= 20;
  }

  bool _isValidPassword(String password) {
    const passwordRegex = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,}$';
    return RegExp(passwordRegex).hasMatch(password);
  }

  Future<void> register(BuildContext context) async {
    final username = provider.model.username;
    final email = provider.model.email;
    final password = provider.model.password;
    final confirmPassword = provider.model.confirmPassword;
    final isFreelancer = provider.model.isFreelancer;

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      provider.setError('Veuillez remplir tous les champs');
      return;
    }

    if (!_isValidUsername(username)) {
      provider.setError('Le nom d\'utilisateur doit contenir entre 5 et 20 caractères');
      return;
    }

    if (!_isValidEmail(email)) {
      provider.setError('Veuillez entrer un email valide');
      return;
    }

    if (!_isValidPassword(password)) {
      provider.setError(
          'Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule et un chiffre');
      return;
    }

    if (password != confirmPassword) {
      provider.setError('Les mots de passe ne correspondent pas');
      return;
    }

    provider.setLoading(true);
    try {
      await apiService.register(username, email, password, isFreelancer);
      provider.setLoading(false);
      provider.setError(null);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('signupEmail', email);

      if (context.mounted) {
        Navigator.pushNamed(context, '/verify-otp');
      }
    } catch (e) {
      provider.setLoading(false);
      provider.setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> verifyOtp(BuildContext context, String otp) async {
    final email = provider.model.email;

    if (otp.isEmpty || !RegExp(r'^\d{6}$').hasMatch(otp)) {
      provider.setError('L\'OTP doit être un code de 6 chiffres');
      return;
    }

    provider.setLoading(true);
    try {
      await apiService.verifyOTP(email, otp);
      provider.setLoading(false);
      provider.setError(null);

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('signupEmail');

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      provider.setLoading(false);
      provider.setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}