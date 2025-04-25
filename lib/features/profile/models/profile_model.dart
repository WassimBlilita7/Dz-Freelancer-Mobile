class ProfileModel {
  String username;
  String firstName;
  String lastName;
  String bio;
  String companyName;
  String webSite;
  String? profilePicture;
  bool isLoading;
  String? errorMessage;

  ProfileModel({
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.bio = '',
    this.companyName = '',
    this.webSite = '',
    this.profilePicture,
    this.isLoading = false,
    this.errorMessage,
  });

  ProfileModel copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? bio,
    String? companyName,
    String? webSite,
    String? profilePicture,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileModel(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      companyName: companyName ?? this.companyName,
      webSite: webSite ?? this.webSite,
      profilePicture: profilePicture ?? this.profilePicture,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
