class HomeModel {
  final bool isLoading;
  final String? errorMessage;
  final int selectedIndex;

  HomeModel({
    this.isLoading = false,
    this.errorMessage,
    this.selectedIndex = 0,
  });

  HomeModel copyWith({
    bool? isLoading,
    String? errorMessage,
    int? selectedIndex,
  }) {
    return HomeModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}