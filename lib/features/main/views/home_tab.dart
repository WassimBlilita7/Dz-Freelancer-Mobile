import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/category_card.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/promo_card.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_button.dart';
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
      provider.controller?.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.model.isLoading) {
          return _buildLoadingView();
        }

        if (provider.model.errorMessage != null) {
          return _buildErrorView(provider);
        }

        return _buildContentView(provider);
      },
    );
  }

  Widget _buildLoadingView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          FadeShimmer(width: double.infinity, height: 30.h, highlightColor: Colors.grey.shade200, baseColor: Colors.grey.shade300),
          SizedBox(height: 16.h),
          FadeShimmer(width: double.infinity, height: 20.h, highlightColor: Colors.grey.shade200, baseColor: Colors.grey.shade300),
          SizedBox(height: 16.h),
          FadeShimmer(width: double.infinity, height: 150.h, highlightColor: Colors.grey.shade200, baseColor: Colors.grey.shade300),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) => FadeShimmer(
                width: 80.w,
                height: 100.h,
                highlightColor: Colors.grey.shade200,
                baseColor: Colors.grey.shade300,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorView(HomeProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Erreur : ${provider.model.errorMessage}',
            style: AppTextStyles.subtitleMedium(context).copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () {
              provider.controller?.fetchUserProfile();
              provider.controller?.fetchCategories();
            },
            child: Text('Réessayer', style: AppTextStyles.buttonText(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildContentView(HomeProvider provider) {
    final username = provider.model.username ?? 'Utilisateur';
    final welcomeMessage = provider.model.isFreelancer == true
        ? 'Liberté, mission, revenu, impact ❤️‍🔥'
        : 'Qualité, rapidité, budget maîtrisé 🥶';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(username, welcomeMessage),
          SizedBox(height: 16.h),
          _buildPromoCard(provider),
          SizedBox(height: 16.h),
          _buildCategorySection(provider),
          if (provider.model.isFreelancer == false) ...[
            SizedBox(height: 16.h),
            CustomButton(
              title: 'Créer un post',
              onTap: () {
                Navigator.pushNamed(context, '/create_post');
              },
              backgroundColor: AppColors.primaryGreen,
              textColor: Colors.white,
              icon: Icons.add,
              iconColor: Colors.white,
            ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
          ],
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildHeader(String username, String welcomeMessage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hi $username', style: AppTextStyles.titleLarge(context)).animate().fadeIn(duration: 600.ms),
        SizedBox(height: 5.h),
        Text(welcomeMessage, style: AppTextStyles.subtitleMedium(context)).animate().fadeIn(duration: 600.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildPromoCard(HomeProvider provider) {
    return PromoCard(
      isFreelancer: provider.model.isFreelancer ?? false,
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms);
  }

  Widget _buildCategorySection(HomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Catégories', style: AppTextStyles.subtitleMedium(context))
            .animate()
            .fadeIn(duration: 600.ms, delay: 400.ms),
        SizedBox(height: 8.h),
        SizedBox(
          height: 100.h,
          child: provider.model.categories.isEmpty
              ? const Center(child: Text('Aucune catégorie disponible'))
              : ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: provider.model.categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final category = provider.model.categories[index];
              return CategoryCard(
                name: category.name,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Catégorie : ${category.name}')),
                  );
                },
              );
            },
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
      ],
    );
  }
}