class SplashModel {
  final bool isLoading;

  SplashModel({required this.isLoading});

  SplashModel copyWith({bool? isLoading}) {
    return SplashModel(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}