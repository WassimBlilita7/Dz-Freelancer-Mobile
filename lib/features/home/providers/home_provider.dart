import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/controllers/home_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/models/home_model.dart';

class HomeProvider extends ChangeNotifier {
  HomeModel _model = HomeModel();
  HomeController? controller;

  HomeModel get model => _model;

  void setSelectedIndex(int index) {
    _model = _model.copyWith(selectedIndex: index);
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _model = _model.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  void setUserData(String username, bool isFreelancer) {
    _model = _model.copyWith(username: username, isFreelancer: isFreelancer);
    notifyListeners();
  }

  void setError(String errorMessage) {
    _model = _model.copyWith(errorMessage: errorMessage, isLoading: false);
    notifyListeners();
  }

  void clear() {
    _model = HomeModel();
    notifyListeners();
  }
}