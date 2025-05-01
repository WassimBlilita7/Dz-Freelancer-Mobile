import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_button.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_text_field.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/models/category_model.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/controllers/post_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/providers/post_provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skillsController = TextEditingController();
  final _budgetController = TextEditingController();
  String? _selectedDuration;
  CategoryModel? _selectedCategory;
  File? _imageFile;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _skillsController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.getBackground(context),
              appBar: AppBar(
                title: Text('Créer un post', style: AppTextStyles.titleLarge(context)),
                backgroundColor: AppColors.getBackground(context),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: 'Titre',
                          controller: _titleController,
                          onChanged: (_) {},
                          prefixIcon: Icons.title,
                        ).animate().fadeIn(duration: 600.ms),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          label: 'Description',
                          controller: _descriptionController,
                          onChanged: (_) {},
                          prefixIcon: Icons.description,
                          keyboardType: TextInputType.multiline,
                        ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          label: 'Compétences (séparées par des virgules)',
                          controller: _skillsController,
                          onChanged: (_) {},
                          prefixIcon: Icons.build,
                        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          label: 'Budget (DZD)',
                          controller: _budgetController,
                          onChanged: (_) {},
                          prefixIcon: Icons.money,
                          keyboardType: TextInputType.number,
                        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                        SizedBox(height: 16.h),
                        DropdownButtonFormField<String>(
                          value: _selectedDuration,
                          hint: Text('Sélectionner la durée', style: AppTextStyles.bodyText(context)),
                          items: ['1j', '7j', '15j', '1mois', '3mois', '6mois', '+1an']
                              .map((duration) => DropdownMenuItem(
                            value: duration,
                            child: Text(duration, style: AppTextStyles.bodyText(context)),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDuration = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.timer, color: AppColors.textLightGrey),
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
                        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                        SizedBox(height: 16.h),
                        DropdownButtonFormField<CategoryModel>(
                          value: _selectedCategory,
                          hint: Text('Sélectionner une catégorie', style: AppTextStyles.bodyText(context)),
                          items: homeProvider.model.categories
                              .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name, style: AppTextStyles.bodyText(context)),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.category, color: AppColors.textLightGrey),
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
                        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 100.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.textLightGrey),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: _imageFile == null
                                ? Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image, color: AppColors.textLightGrey),
                                  SizedBox(width: 8.w),
                                  Text('Choisir une image', style: AppTextStyles.bodyText(context)),
                                ],
                              ),
                            )
                                : Image.file(_imageFile!, fit: BoxFit.cover),
                          ),
                        ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                        SizedBox(height: 24.h),
                        CustomButton(
                          title: 'Créer le post',
                          onTap: () {
                            Provider.of<PostProvider>(context, listen: false).controller?.createPost(
                              context: context,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              skillsRequired:
                              _skillsController.text.split(',').map((s) => s.trim()).toList(),
                              budget: double.tryParse(_budgetController.text) ?? 0,
                              duration: _selectedDuration ?? '',
                              categoryId: _selectedCategory?.id ?? '',
                              imageFile: _imageFile,
                            );
                          },
                          backgroundColor: AppColors.primaryGreen,
                          textColor: Colors.white,
                          isLoading: postProvider.isLoading,
                        ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (postProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/loading.json',
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}