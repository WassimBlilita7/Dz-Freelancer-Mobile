import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/theme_toggle_button.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomDrawer({
    super.key,
    required this.onLogout,
  });

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
                onTap: () => _handleNavigation(context),
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