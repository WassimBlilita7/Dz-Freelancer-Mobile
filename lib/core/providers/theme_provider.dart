import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/theme_model.dart';

class ThemeProvider with ChangeNotifier {
  ThemeModel _model = ThemeModel();

  ThemeModel get model => _model;

  void updateTheme(bool isDarkMode) {
    _model = ThemeModel(isDarkMode: isDarkMode);
    notifyListeners();
  }
}