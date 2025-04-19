class LoginModel {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic>? userData;
  final String? token;

  LoginModel({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
    this.userData,
    this.token,
  });

  LoginModel copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? userData,
    String? token,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userData: userData ?? this.userData,
      token: token ?? this.token,
    );
  }
}