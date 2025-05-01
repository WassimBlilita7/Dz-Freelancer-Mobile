import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/post_api_service.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_toast.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/providers/post_provider.dart';

class PostController {
  final PostProvider provider;
  final PostApiService apiService;

  PostController(this.provider, this.apiService);

  Future<void> createPost({
    required BuildContext context,
    required String title,
    required String description,
    required List<String> skillsRequired,
    required double budget,
    required String duration,
    required String categoryId,
    File? imageFile,
  }) async {
    if (title.isEmpty ||
        description.isEmpty ||
        skillsRequired.isEmpty ||
        budget <= 0 ||
        duration.isEmpty ||
        categoryId.isEmpty) {
      provider.setError('Veuillez remplir tous les champs');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const CustomToast(
              message: 'Veuillez remplir tous les champs',
              isSuccess: false,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      }
      return;
    }

    try {
      if (kDebugMode) {
        print('PostController: Début de createPost');
        print('PostController: title=$title, budget=$budget, categoryId=$categoryId');
      }

      provider.setLoading(true);

      final post = await apiService.createPost(
        title: title,
        description: description,
        skillsRequired: skillsRequired,
        budget: budget,
        duration: duration,
        categoryId: categoryId,
        imageFile: imageFile,
      );

      provider.setSuccess(post);

      if (context.mounted) {
        if (kDebugMode) {
          print('PostController: Post créé avec succès, ID: ${post.id}');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const CustomToast(
              message: 'Offre publiée avec succès',
              isSuccess: true,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
                (route) => false,
          );
        }
      }
    } catch (e) {
      provider.setError(e.toString().replaceFirst('Exception: ', ''));
      if (context.mounted) {
        if (kDebugMode) {
          print('PostController: Erreur: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomToast(
              message: e.toString().replaceFirst('Exception: ', ''),
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
        print('PostController: Fin de createPost, isLoading: ${provider.isLoading}');
      }
    }
  }
}