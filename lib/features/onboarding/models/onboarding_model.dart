class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static List<OnboardingModel> getOnboardingData() {
    return [
      OnboardingModel(
        title: 'Connectez-vous avec des freelances ❤️‍🔥',
        description: 'Trouvez et collaborez avec des freelances talentueux à travers l’Algérie pour vos projets.',
        imagePath: 'assets/images/onBoarding/connection.png',
      ),
      OnboardingModel(
        title: 'Explorez des projets 🚀',
        description: 'Découvrez une large gamme de projets et mettez en avant vos compétences auprès des clients.',
        imagePath: 'assets/images/onBoarding/project.png',
      ),
      OnboardingModel(
        title: 'Paiements sécurisés',
        description: 'Profitez de transactions sûres et fiables grâce à notre système de paiement sécurisé.',
        imagePath: 'assets/images/onBoarding/payment.png',
      ),
    ];
  }
}