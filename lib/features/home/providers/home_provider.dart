import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/utils/toast_utils.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/controllers/home_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/models/home_model.dart';

class HomeProvider extends ChangeNotifier {
  HomeModel _model = HomeModel();
  HomeController? _controller;

  HomeModel get model => _model;
  HomeController? get controller => _controller;

  set controller(HomeController? controller) {
    _controller = controller;
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

  void clearError() {
    _model = _model.copyWith(errorMessage: null);
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _model = _model.copyWith(selectedIndex: index);
    notifyListeners();
  }
}