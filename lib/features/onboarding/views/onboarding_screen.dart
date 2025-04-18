import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/controllers/onboarding_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/providers/onboarding_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/onboarding/views/widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingController _controller;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<OnboardingProvider>(context, listen: false);
    _controller = OnboardingController(provider);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: Consumer<OnboardingProvider>(
        builder: (context, provider, child) {
          if (provider.isCompleted && mounted) {
            Future.delayed(Duration.zero, () {
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            });
          }
          return Stack(
            children: [
              PageView.builder(
                controller: _controller.pageController,
                onPageChanged: _controller.onPageChanged,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return OnboardingPage(index: index);
                },
              ),
              Positioned(
                bottom: 80.h, // Taille responsive
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _controller.pageController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: AppColors.getPrimary(context),
                      dotColor: AppColors.getAccent(context).withOpacity(0.5),
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40.h, // Taille responsive
                right: 20.w,
                child: TextButton(
                  onPressed: _controller.skipOnboarding,
                  child: Text(
                    'Passer',
                    style: TextStyle(
                      color: AppColors.getText(context),
                      fontSize: 16.sp, // Taille responsive
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.nextPage,
        backgroundColor: AppColors.getPrimary(context),
        child: Icon(Icons.arrow_forward, size: 24.w, color: Colors.white),
      ),
    );
  }
}