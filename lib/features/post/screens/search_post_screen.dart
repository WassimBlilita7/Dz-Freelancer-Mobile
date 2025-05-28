import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_card.dart';
import '../providers/ost_list_provider.dart';

class SearchPostScreen extends StatefulWidget {
  const SearchPostScreen({super.key});

  @override
  State<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends State<SearchPostScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PostListProvider>(context, listen: false);
      provider.controller?.fetchPosts(context);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostListProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.getBackground(context),
          appBar: AppBar(
            title: Text('Recherche Offres', style: AppTextStyles.titleLarge(context)),
            backgroundColor: AppColors.getBackground(context),
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: TextField(
                  controller: _searchController,
                  onChanged: provider.filterPosts,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une offre... (titre, description, compétence)',
                    prefixIcon: Icon(Icons.search, color: AppColors.textLightGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.textLightGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.textLightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.primaryGreen),
                    ),
                  ),
                ),
              ),
            ),
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