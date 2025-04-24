import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/promo_card.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.controller?.fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.model.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.model.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Erreur: ${provider.model.errorMessage}',
                  style: AppTextStyles.subtitleMedium(context).copyWith(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {
                    provider.controller?.fetchUserProfile();
                  },
                  child: Text(
                    'Réessayer',
                    style: AppTextStyles.buttonText(context),
                  ),
                ),
              ],
            ),
          );
        }

        final username = provider.model.username ?? 'Utilisateur';
        final welcomeMessage = provider.model.isFreelancer == true
            ? 'Liberté, mission, revenu, impact ❤️‍🔥'
            : 'Qualité, rapidité, budget maîtrisé 🥶';

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi $username',
                style: AppTextStyles.titleLarge(context),
              ).animate().fadeIn(duration: 600.ms),
              SizedBox(height: 5.h),
              Text(
                welcomeMessage,
                style: AppTextStyles.subtitleMedium(context),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
              SizedBox(height: 16.h), // Espacement avant la carte
              PromoCard(
                isFreelancer: provider.model.isFreelancer ?? false,
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}