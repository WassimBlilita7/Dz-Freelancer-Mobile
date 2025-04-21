import 'package:flutter/material.dart';

class AppBarController {
  final VoidCallback onMenuPressed;
  final VoidCallback onMessagesPressed;

  AppBarController({
    required this.onMenuPressed,
    required this.onMessagesPressed,
  });

  void handleMenuPress() {
    onMenuPressed();
  }

  void handleMessagesPress() {
    onMessagesPressed();
  }
}