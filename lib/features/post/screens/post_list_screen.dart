import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_card.dart';

import '../providers/ost_list_provider.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  void initState() {
    super.initState();
    // Appeler fetchPosts après le premier build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PostListProvider>(context, listen: false);
      provider.controller?.fetchPosts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostListProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.getBackground(context),
          appBar: AppBar(
            title: Text('Offres', style: AppTextStyles.titleLarge(context)),
            backgroundColor: AppColors.getBackground(context),
            elevation: 0,
          ),
          body: provider.isLoading
              ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
              : provider.error != null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provider.error!,
                  style: AppTextStyles.bodyText(context).copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => provider.controller?.fetchPosts(context),
                  child: Text('Réessayer', style: AppTextStyles.bodyText(context)),
                ),
              ],
            ),
          )
              : provider.posts.isEmpty
              ? Center(
            child: Text(
              'Aucune offre disponible',
              style: AppTextStyles.bodyText(context),
            ),
          )
              : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: provider.posts.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final post = provider.posts[index];
              return CustomCard(
                post: post,
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}