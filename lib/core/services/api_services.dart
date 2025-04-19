import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wassit_freelancer_dz_flutter/constants/api_constants.dart';

class ApiService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');
    try {
      final response = await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Erreur inconnue');
      }
    } on TimeoutException {
      throw Exception('Le serveur ne répond pas. Vérifiez votre connexion.');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
  Future<void> logout() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.logoutEndpoint}');
    try {
      final response = await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Erreur inconnue');
      }
    } on TimeoutException {
      throw Exception('Le serveur ne répond pas. Vérifiez votre connexion.');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}