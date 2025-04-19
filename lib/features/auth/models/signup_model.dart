class SignupModel {
  final String username;
  final String email;
  final String password;
  final bool isFreelancer;
  final bool isLoading;
  final String? errorMessage;

  SignupModel({
    this.username = '',
    this.email = '',
    this.password = '',
    this.isFreelancer = false,
    this.isLoading = false,
    this.errorMessage,
  });

  SignupModel copyWith({
    String? username,
    String? email,
    String? password,
    bool? isFreelancer,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignupModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isFreelancer: isFreelancer ?? this.isFreelancer,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}