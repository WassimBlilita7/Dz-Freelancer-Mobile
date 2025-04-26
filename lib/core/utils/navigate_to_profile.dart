import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/controllers/profile_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/providers/profile_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/views/edit_profile_screen.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/profile_api_service.dart';

Future<void> navigateToProfile(BuildContext context) async {
  Navigator.pop(context); // Fermer le Drawer

  SchedulerBinding.instance.addPostFrameCallback((_) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt-freelancerDZ');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token non trouvé, veuillez vous reconnecter')),
      );
      return;
    }

    final profileProvider = ProfileProvider();
    final profileController = ProfileController(profileProvider, ProfileApiService());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: profileProvider,
          child: EditProfileScreen(
            controller: profileController,
            token: token,
          ),
        ),
      ),
    );
  });
}
