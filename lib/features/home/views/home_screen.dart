import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/controllers/home_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';

import '../../../core/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    _controller = HomeController(provider, ApiService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accueil',
          style: TextStyle(fontSize: 20.sp, color: AppColors.getText(context)),
        ),
        backgroundColor: AppColors.getBackground(context),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenue sur Wassit Freelancer DZ !',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getText(context),
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms),
                SizedBox(height: 40.h),
                provider.model.isLoading
                    ? CircularProgressIndicator(
                  color: AppColors.getPrimary(context),
                )
                    : ElevatedButton(
                  onPressed: () => _controller.logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Déconnexion',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                if (provider.model.errorMessage != null) ...[
                  SizedBox(height: 20.h),
                  Text(
                    provider.model.errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}