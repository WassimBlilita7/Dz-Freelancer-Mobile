import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/models/home_model.dart';

class HomeProvider extends ChangeNotifier {
  HomeModel _model = HomeModel();

  HomeModel get model => _model;

  void setLoading(bool isLoading) {
    _model = _model.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  void setError(String? errorMessage) {
    _model = _model.copyWith(errorMessage: errorMessage);
    notifyListeners();
  }

  void clearError() {
    _model = _model.copyWith(errorMessage: null);
    notifyListeners();
  }
}