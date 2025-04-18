import 'package:flutter/material.dart';

import '../models/splash_model.dart';

class SplashProvider extends ChangeNotifier {
  SplashModel _model = SplashModel(isLoading: true);

  SplashModel get model => _model;

  void setLoading(bool isLoading) {
    _model = _model.copyWith(isLoading: isLoading);
    notifyListeners();
  }
}