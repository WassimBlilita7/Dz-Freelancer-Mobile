class HomeModel {
  final bool isLoading;
  final String? errorMessage;

  HomeModel({
    this.isLoading = false,
    this.errorMessage,
  });

  HomeModel copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}