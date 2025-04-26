import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_images.dart';
import 'package:wassit_freelancer_dz_flutter/core/controllers/app_bar_controller.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/app_bar_model.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/profile_picture_service.dart'; // Import du service

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarModel model;
  final AppBarController controller;

  const CustomAppBar({
    super.key,
    required this.model,
    required this.controller,
  });

  Widget _buildLeadingIcon(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: AppColors.getText(context),
        size: 24.sp,
      ),
      onPressed: controller.handleMenuPress,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'DZFreelancer',
      style: TextStyle(
        color: AppColors.getText(context),
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildMessagesIcon(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Icons.message,
            color: AppColors.primaryGreen,
            size: 24.sp,
          ),
          onPressed: controller.handleMessagesPress,
        ),
        if (model.unreadNotifications > 0)
          Positioned(
            right: 8.w,
            top: 8.h,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
              child: Text(
                model.unreadNotifications.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return FutureBuilder<String>(
      future: getProfileImageUrl(), // Appel à la fonction pour récupérer la photo de profil
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white,
              child: const CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white,
              child: const Icon(Icons.error),
            ),
          );
        } else {
          String imageUrl = snapshot.data ?? AppUtils.emptyImage; // Photo par défaut
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(imageUrl),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundGradient = LinearGradient(
      colors: isDarkMode
          ? [AppColors.backgroundDark, AppColors.primaryDark]
          : [AppColors.backgroundLight, AppColors.primaryLight],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final borderGradient = LinearGradient(
      colors: isDarkMode
          ? [AppColors.primaryDark, AppColors.primaryGreen]
          : [AppColors.primaryLight, AppColors.primaryGreen],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        border: Border(
          bottom: BorderSide(
            width: 2.w,
            color: Colors.transparent,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.w,
              color: Colors.transparent,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: _buildLeadingIcon(context),
          title: _buildTitle(context),
          centerTitle: true,
          actions: [
            _buildMessagesIcon(context),
            _buildProfileImage(context), // Utilisation de la photo de profil récupérée
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
