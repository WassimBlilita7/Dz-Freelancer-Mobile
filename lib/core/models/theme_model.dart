import 'package:flutter/material.dart';

class ThemeModel {
  bool isDarkMode;

  ThemeModel({this.isDarkMode = false});

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;
}