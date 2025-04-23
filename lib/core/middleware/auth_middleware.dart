import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware {
  static const String _tokenKey = 'jwt-freelancerDZ';
  static const String _userDataKey = 'userData';
  static const String _hasSeenOnboardingKey = 'hasSeenOnboarding';

  Future<Map<String, dynamic>?> _getSavedAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final userDataJson = prefs.getString(_userDataKey);

    if (kDebugMode) {
      print('AuthMiddleware: token = $token');
      print('AuthMiddleware: userDataJson = $userDataJson');
    }

    if (token == null || userDataJson == null) {
      return null;
    }

    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    return {
      'token': token,
      'userData': userData,
    };
  }

  Future<bool> isUserLoggedIn() async {
    final authData = await _getSavedAuthData();
    final isLoggedIn = authData != null;
    if (kDebugMode) {
      print('AuthMiddleware: isUserLoggedIn = $isLoggedIn');
    }
    return isLoggedIn;
  }

  Future<Map<String, dynamic>?> getAuthData() async {
    return await _getSavedAuthData();
  }

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = prefs.getBool(_hasSeenOnboardingKey) ?? false;
    if (kDebugMode) {
      print('AuthMiddleware: hasSeenOnboarding = $hasSeen');
    }
    return hasSeen;
  }

  Future<void> setHasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, true);
    if (kDebugMode) {
      print('AuthMiddleware: hasSeenOnboarding set to true');
    }
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
    if (kDebugMode) {
      print('AuthMiddleware: Auth data cleared');
    }
  }
}