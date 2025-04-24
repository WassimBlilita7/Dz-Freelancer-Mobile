import 'package:wassit_freelancer_dz_flutter/features/home/models/category_model.dart';

class HomeModel {
  final bool isLoading;
  final String? errorMessage;
  final int selectedIndex;
  final String? username;
  final bool? isFreelancer;
  final List<CategoryModel> categories; // Ajout du champ categories

  HomeModel({
    this.isLoading = false,
    this.errorMessage,
    this.selectedIndex = 0,
    this.username,
    this.isFreelancer,
    this.categories = const [], // Valeur par défaut : liste vide
  });

  HomeModel copyWith({
    bool? isLoading,
    String? errorMessage,
    int? selectedIndex,
    String? username,
    bool? isFreelancer,
    List<CategoryModel>? categories,
  }) {
    return HomeModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      username: username ?? this.username,
      isFreelancer: isFreelancer ?? this.isFreelancer,
      categories: categories ?? this.categories,
    );
  }
}