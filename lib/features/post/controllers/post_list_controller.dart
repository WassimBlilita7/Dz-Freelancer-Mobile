import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/post_list_api_service.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_toast.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/models/post_model.dart';

import '../providers/ost_list_provider.dart';

class PostListController {
  final PostListProvider provider;
  final PostListApiService apiService;

  PostListController(this.provider, this.apiService);

  Future<void> fetchPosts(BuildContext context, {bool random = false}) async {
    try {
      if (kDebugMode) {
        print('PostListController: Début de fetchPosts, random=$random');
      }

      provider.setLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final userRole = prefs.getString('userRole') ?? 'client'; // Valeur par défaut
      if (kDebugMode) {
        print('PostListController: userRole=$userRole');
      }

      if (userRole != 'client' && userRole != 'freelancer') {
        if (kDebugMode) {
          print('PostListController: userRole invalide, utilisation de client par défaut');
        }
      }

      final posts = await apiService.getAllPosts(
        random: random && userRole == 'freelancer',
      );

      provider.setPosts(posts);

      if (kDebugMode) {
        print('PostListController: Posts récupérés: ${posts.length}');
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      provider.setError(errorMessage);
      if (context.mounted) {
        if (kDebugMode) {
          print('PostListController: Erreur: $errorMessage');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomToast(
              message: errorMessage,
              isSuccess: false,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      }
    } finally {
      provider.setLoading(false);
      if (kDebugMode) {
        print('PostListController: Fin de fetchPosts, isLoading: ${provider.isLoading}');
      }
    }
  }
}