import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/controllers/post_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/models/post_model.dart';

class PostProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  PostModel? _post;
  PostController? controller;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  PostModel? get post => _post;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setError(String errorMessage) {
    _errorMessage = errorMessage;
    _isLoading = false;
    notifyListeners();
  }

  void setSuccess(PostModel post) {
    _post = post;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _isLoading = false;
    _errorMessage = null;
    _post = null;
    notifyListeners();
  }
}