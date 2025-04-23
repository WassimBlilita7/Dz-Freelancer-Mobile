import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/core/controllers/theme_controller.dart';
import 'package:wassit_freelancer_dz_flutter/core/providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final controller = ThemeController(themeProvider);

    return GestureDetector(
      onTap: controller.toggleTheme,
      child: Container(
        width: 60.w,
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: themeProvider.model.isDarkMode ? Colors.black : const Color(0xFFFF5722), // Orange comme dans l'image pour le mode clair
        ),
        child: Stack(
          children: [
            // Icône Soleil (mode clair)
            Positioned(
              left: 5.w,
              top: 5.h,
              child: Icon(
                Icons.wb_sunny,
                size: 20.sp,
                color: themeProvider.model.isDarkMode ? Colors.grey : Colors.white,
              ),
            ),
            // Icône Lune (mode sombre)
            Positioned(
              right: 5.w,
              top: 5.h,
              child: Icon(
                Icons.nightlight_round,
                size: 20.sp,
                color: themeProvider.model.isDarkMode ? Colors.white : Colors.grey,
              ),
            ),
            // Cercle de bascule
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: themeProvider.model.isDarkMode ? 30.w : 0,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}