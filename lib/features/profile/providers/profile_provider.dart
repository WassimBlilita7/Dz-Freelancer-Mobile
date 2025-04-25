import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel _model = ProfileModel();
  ProfileModel get model => _model;

  void setProfile(ProfileModel model) {
    _model = model;
    notifyListeners();
  }

  void updateField({
    String? firstName,
    String? lastName,
    String? bio,
    String? companyName,
    String? webSite,
  }) {
    _model = _model.copyWith(
      firstName: firstName,
      lastName: lastName,
      bio: bio,
      companyName: companyName,
      webSite: webSite,
    );
    notifyListeners();
  }

  void updateProfilePicture(String url) {
    _model = _model.copyWith(profilePicture: url);
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _model = _model.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  void setError(String errorMessage) {
    _model = _model.copyWith(errorMessage: errorMessage);
    notifyListeners();
  }
}
