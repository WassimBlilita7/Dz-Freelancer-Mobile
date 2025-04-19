import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/utils/toast_utils.dart';
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

  void setError(BuildContext context, String? errorMessage) {
    _model = _model.copyWith(errorMessage: errorMessage);
    if (errorMessage != null) {
      ToastUtils.showToast(
        context: context,
        message: errorMessage,
        isSuccess: false,
      );
    }
    notifyListeners();
  }

  void setUserData(BuildContext context, Map<String, dynamic> userData, String token) {
    _model = _model.copyWith(userData: userData, token: token);
    ToastUtils.showToast(
      context: context,
      message: 'Connexion réussie !',
      isSuccess: true,
    );
    notifyListeners();
  }

  void clear() {
    _model = LoginModel();
    notifyListeners();
  }
}