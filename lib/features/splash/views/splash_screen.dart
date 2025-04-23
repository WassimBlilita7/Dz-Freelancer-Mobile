import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/controllers/splash_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/splash/providers/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController(Provider.of<SplashProvider>(context, listen: false));
    _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: Consumer<SplashProvider>(
        builder: (context, provider, child) {
          if (!provider.model.isLoading && mounted) {
            Future.delayed(Duration.zero, () {
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/onboarding');
              }
            });
          }
          return Center(
            child: Image.asset(
              'assets/images/wassim.png',
              width: 200.w, // Taille responsive
              height: 200.h,
            )
                .animate()
                .fadeIn(duration: 1000.ms)
                .scaleXY(begin: 0.5, end: 1.0, duration: 800.ms),
          );
        },
      ),
    );
  }
}