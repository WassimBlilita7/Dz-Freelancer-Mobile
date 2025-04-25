import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/profile_api_service.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/models/profile_model.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/providers/profile_provider.dart';

class ProfileController {
  final ProfileProvider provider;
  final ProfileApiService apiService;

  ProfileController(this.provider, this.apiService);

  Future<void> fetchProfile(BuildContext context, String token) async {
    try {
      provider.setLoading(true);
      final userData = await apiService.getProfile(token);

      provider.setProfile(ProfileModel(
        username: userData['username'] ?? '',
        firstName: userData['profile']['firstName'] ?? '',
        lastName: userData['profile']['lastName'] ?? '',
        bio: userData['profile']['bio'] ?? '',
        companyName: userData['profile']['companyName'] ?? '',
        webSite: userData['profile']['webSite'] ?? '',
        profilePicture: userData['profile']['profilePicture'],
      ));
    } catch (e) {
      provider.setError(e.toString());
    } finally {
      provider.setLoading(false);
    }
  }

  Future<void> updateProfile(BuildContext context, String token) async {
    try {
      provider.setLoading(true);

      final updatedData = {
        'firstName': provider.model.firstName,
        'lastName': provider.model.lastName,
        'bio': provider.model.bio,
        'companyName': provider.model.companyName,
        'webSite': provider.model.webSite,
      };

      await apiService.updateProfile(token, updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès')),
      );
    } catch (e) {
      provider.setError(e.toString());
    } finally {
      provider.setLoading(false);
    }
  }


  Future<void> updateProfilePicture(BuildContext context, String token, File imageFile) async {
    try {
      provider.setLoading(true);
      final response = await apiService.updateProfilePicture(token, imageFile);
      provider.updateProfilePicture(response['userData']['profile']['profilePicture']);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo de profil mise à jour')),
      );
    } catch (e) {
      provider.setError(e.toString());
    } finally {
      provider.setLoading(false);
    }
  }
}
