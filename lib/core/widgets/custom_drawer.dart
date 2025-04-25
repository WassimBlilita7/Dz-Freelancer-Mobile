import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/profile_api_service.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/theme_toggle_button.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/controllers/profile_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/providers/profile_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/profile/views/edit_profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomDrawer({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  void _navigateToProfile(BuildContext context) async {
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

  void _handleNavigation(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menu',
                style: AppTextStyles.titleLarge(context),
              ),
              SizedBox(height: 20.h),
              ListTile(
                leading: Icon(
                  Icons.brightness_6,
                  color: AppColors.getText(context),
                ),
                title: Text(
                  'Thème',
                  style: AppTextStyles.subtitleMedium(context).copyWith(
                    color: AppColors.getText(context),
                  ),
                ),
                trailing: const ThemeToggleButton(),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: AppColors.getText(context),
                ),
                title: Text(
                  'Profil',
                  style: AppTextStyles.subtitleMedium(context).copyWith(
                    color: AppColors.getText(context),
                  ),
                ),
                onTap: () => _navigateToProfile(context),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: AppColors.getText(context),
                ),
                title: Text(
                  'Paramètres',
                  style: AppTextStyles.subtitleMedium(context).copyWith(
                    color: AppColors.getText(context),
                  ),
                ),
                onTap: () => _handleNavigation(context),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.errorRed,
                ),
                title: Text(
                  'Déconnexion',
                  style: AppTextStyles.subtitleMedium(context).copyWith(
                    color: AppColors.errorRed,
                  ),
                ),
                onTap: () {
                  onLogout();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
