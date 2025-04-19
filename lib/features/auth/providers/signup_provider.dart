import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/utils/toast_utils.dart';
import 'package:wassit_freelancer_dz_flutter/features/auth/models/signup_model.dart';

import '../controllers/signup_controller.dart';

class SignupProvider extends ChangeNotifier {
  SignupModel _model = SignupModel();
  SignupController? _controller;

  SignupModel get model => _model;
  SignupController? get controller => _controller;

  set controller(SignupController? controller) {
    _controller = controller;
    notifyListeners();
  }

  void updateUsername(String username) {
    _model = _model.copyWith(username: username, errorMessage: null);
    notifyListeners();
  }

  void updateEmail(String email) {
    _model = _model.copyWith(email: email, errorMessage: null);
    notifyListeners();
  }

  void updatePassword(String password) {
    _model = _model.copyWith(password: password, errorMessage: null);
    notifyListeners();
  }

  void updateConfirmPassword(String confirmPassword) {
    _model = _model.copyWith(confirmPassword: confirmPassword, errorMessage: null);
    notifyListeners();
  }

  void toggleFreelancer(bool isFreelancer) {
    _model = _model.copyWith(isFreelancer: isFreelancer, errorMessage: null);
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

  void setSuccess(BuildContext context, String successMessage) {
    _model = _model.copyWith(errorMessage: null);
    ToastUtils.showToast(
      context: context,
      message: successMessage,
      isSuccess: true,
    );
    notifyListeners();
  }

  void clear() {
    _model = SignupModel();
    notifyListeners();
  }
}