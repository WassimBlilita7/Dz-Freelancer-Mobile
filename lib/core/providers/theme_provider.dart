import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/theme_model.dart';

class ThemeProvider with ChangeNotifier {
  ThemeModel _model = ThemeModel();
  static const String _themeKey = 'isDarkMode';

  ThemeProvider() {
    _loadTheme();
  }

  ThemeModel get model => _model;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeKey) ?? false;
    _model = ThemeModel(isDarkMode: isDarkMode);
    notifyListeners();
  }

  Future<void> updateTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
    _model = ThemeModel(isDarkMode: isDarkMode);
    notifyListeners();
  }
}