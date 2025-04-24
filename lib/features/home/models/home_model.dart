class HomeModel {
  final bool isLoading;
  final String? errorMessage;
  final int selectedIndex;
  final String? username; // Ajout du champ username
  final bool? isFreelancer; // Ajout du champ isFreelancer

  HomeModel({
    this.isLoading = false,
    this.errorMessage,
    this.selectedIndex = 0,
    this.username,
    this.isFreelancer,
  });

  HomeModel copyWith({
    bool? isLoading,
    String? errorMessage,
    int? selectedIndex,
    String? username,
    bool? isFreelancer,
  }) {
    return HomeModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      username: username ?? this.username,
      isFreelancer: isFreelancer ?? this.isFreelancer,
    );
  }
}