import 'package:flutter/material.dart';
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
    _controller = OnboardingController(Provider.of<OnboardingProvider>(context, listen: false));
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
          if (provider.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/home');
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
                bottom: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _controller.pageController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: AppColors.getPrimary(context),
                      dotColor: AppColors.getAccent(context).withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: TextButton(
                  onPressed: _controller.skipOnboarding,
                  child: Text(
                    'Passer',
                    style: TextStyle(
                      color: AppColors.getText(context),
                      fontSize: 16,
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
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}