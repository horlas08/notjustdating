class OnboardingModel {
  final String imgUrl;
  final String title;
  final String subTitle;

  OnboardingModel(
      {required this.imgUrl, required this.title, required this.subTitle});
}

List<OnboardingModel> onboardingPages = [
  OnboardingModel(
      imgUrl: "assets/images/pngs/onboardingImage1.png",
      title: "Meet people who truly match your vibe",
      subTitle:
          "Utilize a sophisticated algorithm that learns from user behavior and preferences to suggest more compatible matches."),
  OnboardingModel(
      imgUrl: "assets/images/pngs/onboardingImage2.png",
      title: "Connect, go on date and share matching passion",
      subTitle:
          "Rooms & forums within the app dedicated to specific relationship topics such as communication, trust-building and more."),
  OnboardingModel(
      imgUrl: "assets/images/pngs/onboardingImage3.png",
      title: "Feel confidents, build relationship that last.",
      subTitle:
          "Relationship experts, therapists, and influencers to produce high-quality video content addressing various aspects of dating"),
];
