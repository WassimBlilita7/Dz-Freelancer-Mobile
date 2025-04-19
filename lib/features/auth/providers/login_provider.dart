import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/models/login_model.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel _model = LoginModel();

  LoginModel get model => _model;

  void updateEmail(String email) {
    _model = _model.copyWith(email: email, errorMessage: null);
    notifyListeners();
  }

  void updatePassword(String password) {
    _model = _model.copyWith(password: password, errorMessage: null);
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _model = _model.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  void setError(String? errorMessage) {
    _model = _model.copyWith(errorMessage: errorMessage);
    notifyListeners();
  }

  void setUserData(Map<String, dynamic> userData, String token) {
    _model = _model.copyWith(userData: userData, token: token);
    notifyListeners();
  }

  void clear() {
    _model = LoginModel();
    notifyListeners();
  }
}