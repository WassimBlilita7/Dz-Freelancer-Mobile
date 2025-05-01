import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/constants/api_constants.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/models/post_model.dart';

class PostListApiService {
  Future<List<PostModel>> getAllPosts({bool random = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt-freelancerDZ');

    if (token == null) {
      if (kDebugMode) {
        print('PostListApiService: Aucun token trouvé dans SharedPreferences');
      }
      throw Exception('Utilisateur non authentifié');
    }

    final uri = Uri.parse('${ApiConstants.baseUrl}/post${random ? '?random=true' : ''}');

    try {
      if (kDebugMode) {
        print('PostListApiService: Envoi de la requête à $uri avec token: $token');
      }

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print('PostListApiService: Statut HTTP: ${response.statusCode}');
        print('PostListApiService: Réponse brute: ${response.body}');
      }

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (kDebugMode) {
          print('PostListApiService: JSON décodé: $json');
        }
        final postsJson = json['posts'] as List<dynamic>?;
        if (postsJson == null || postsJson.isEmpty) {
          if (kDebugMode) {
            print('PostListApiService: Aucun post trouvé dans la réponse');
          }
          return []; // Retourne une liste vide au lieu de lancer une exception
        }
        final posts = postsJson.map((post) => PostModel.fromJson(post)).toList();
        if (kDebugMode) {
          print('PostListApiService: Posts parsés: ${posts.length}');
        }
        return posts;
      } else {
        String errorMessage = 'Erreur inconnue';
        try {
          final errorBody = jsonDecode(response.body);
          errorMessage = errorBody['message'] ?? 'Erreur serveur';
          if (kDebugMode) {
            print('PostListApiService: Erreur serveur: $errorMessage');
          }
        } catch (_) {
          errorMessage = 'Réponse serveur invalide: ${response.body}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('PostListApiService: Exception: $e');
      }
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}