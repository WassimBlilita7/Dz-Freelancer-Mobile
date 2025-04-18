import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentPage = 0;
  bool _isCompleted = false;

  int get currentPage => _currentPage;
  bool get isCompleted => _isCompleted;

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void completeOnboarding() {
    _isCompleted = true;
    notifyListeners();
  }
}