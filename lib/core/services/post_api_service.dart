import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/constants/api_constants.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/models/post_model.dart';

class PostApiService {
  Future<Map<String, dynamic>> createPost({
    required String title,
    required String description,
    required List<String> skillsRequired,
    required double budget,
    required String duration,
    required String categoryId,
    File? imageFile,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt-freelancerDZ');

    if (token == null) {
      if (kDebugMode) {
        print('PostApiService: Aucun token trouvé dans SharedPreferences');
      }
      throw Exception('Utilisateur non authentifié');
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/post/createPost'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['skillsRequired'] = jsonEncode(skillsRequired);
    request.fields['budget'] = budget.toString();
    request.fields['duration'] = duration;
    request.fields['category'] = categoryId;

    if (imageFile != null) {
      try {
        final imageSize = await imageFile.length();
        if (kDebugMode) {
          print('PostApiService: Taille de l\'image: ${imageSize / 1024 / 1024} Mo');
        }
        if (imageSize > 5 * 1024 * 1024) {
          throw Exception('Image trop volumineuse (max 5 Mo)');
        }
        final mimeType = imageFile.path.endsWith('.png') ? 'image/png' : 'image/jpeg';
        request.files.add(
          await http.MultipartFile.fromPath(
            'picture',
            imageFile.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      } catch (e) {
        throw Exception('Erreur avec l\'image: $e');
      }
    }

    try {
      if (kDebugMode) {
        print('PostApiService: Envoi de la requête à ${request.url}');
        print('PostApiService: Headers: ${request.headers}');
        print('PostApiService: Fields: ${request.fields}');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('PostApiService: Statut: ${response.statusCode}');
        print('PostApiService: Réponse: ${response.body}');
      }

      if (response.statusCode == 201) {
        try {
          final json = jsonDecode(response.body);
          if (json is Map<String, dynamic>) {
            if (kDebugMode) {
              print('PostApiService: JSON décodé: $json');
            }
            final postJson = json['post'] ?? json['data'] ?? json['result'] ?? json;
            if (postJson is Map<String, dynamic>) {
              return {
                'success': true,
                'post': PostModel.fromJson(postJson),
                'message': json['message']?.toString() ?? 'Post créé avec succès',
              };
            }
          }
          // Gérer le cas où la réponse est une String ou un JSON invalide
          if (kDebugMode) {
            print('PostApiService: Réponse n\'est pas un Map, traité comme succès: ${response.body}');
          }
          return {
            'success': true,
            'post': null,
            'message': response.body.isNotEmpty ? response.body : 'Post créé avec succès',
          };
        } catch (e) {
          if (kDebugMode) {
            print('PostApiService: Erreur de parsing JSON: $e');
            print('PostApiService: Corps de la réponse: ${response.body}');
          }
          // Succès sans PostModel si parsing échoue
          return {
            'success': true,
            'post': null,
            'message': response.body.isNotEmpty ? response.body : 'Post créé avec succès',
          };
        }
      } else if (response.statusCode == 413) {
        throw Exception('Image trop volumineuse, essayez une taille plus petite (max 5 Mo)');
      } else if (response.statusCode == 400 && response.body.contains('Seuls les fichiers')) {
        throw Exception('Seuls les fichiers JPEG, JPG et PNG sont autorisés');
      } else {
        String errorMessage = 'Erreur inconnue';
        try {
          final errorBody = jsonDecode(response.body);
          errorMessage = errorBody['message']?.toString() ?? 'Erreur serveur';
        } catch (_) {
          errorMessage = 'Réponse serveur invalide: ${response.body}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('PostApiService: Exception: $e');
      }
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}