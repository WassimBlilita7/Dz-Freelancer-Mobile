import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wassit_freelancer_dz_flutter/constants/api_constants.dart';

class CategoryApiService {
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.categoriesEndpoint}');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Erreur inconnue lors de la récupération des catégories');
      }
    } on TimeoutException {
      throw Exception('Le serveur ne répond pas. Vérifiez votre connexion.');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}