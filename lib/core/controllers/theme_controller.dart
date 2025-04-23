import 'package:wassit_freelancer_dz_flutter/core/models/theme_model.dart';
import 'package:wassit_freelancer_dz_flutter/core/providers/theme_provider.dart';

class ThemeController {
  final ThemeProvider provider;

  ThemeController(this.provider);

  void toggleTheme() {
    provider.updateTheme(!provider.model.isDarkMode);
  }
}