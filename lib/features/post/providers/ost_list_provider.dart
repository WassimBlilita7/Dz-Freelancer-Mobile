import 'package:flutter/foundation.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/controllers/post_list_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/models/post_model.dart';

class PostListProvider with ChangeNotifier {
  PostListController? controller; // Rendu nullable, supprimé late
  List<PostModel> _posts = [];
  List<PostModel> _allPosts = [];
  bool _isLoading = false;
  String? _error;

  PostListProvider({this.controller});

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setPosts(List<PostModel> posts) {
    _posts = posts;
    _allPosts = List.from(posts);
    _error = null;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  void filterPosts(String query) {
    if (query.isEmpty) {
      _posts = List.from(_allPosts);
    } else {
      final lowerQuery = query.toLowerCase();
      _posts = _allPosts.where((post) =>
        post.title.toLowerCase().contains(lowerQuery) ||
        post.description.toLowerCase().contains(lowerQuery) ||
        post.skillsRequired.any((skill) => skill.toLowerCase().contains(lowerQuery))
      ).toList();
    }
    notifyListeners();
  }
}