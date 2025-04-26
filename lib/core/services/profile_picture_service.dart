import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_images.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/profile_api_service.dart';

Future<String> getProfileImageUrl() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(AppUtils.token);

  if (token == null) {
    return AppUtils.emptyImage;
  }

  try {
    final apiService = ProfileApiService();
    final profileData = await apiService.getProfile(token);
    String profilePicture = profileData['profile']['profilePicture'];

    return profilePicture.isEmpty
        ? AppUtils.emptyImage
        : profilePicture;
  } catch (e) {
    return AppUtils.emptyImage;
  }
}
