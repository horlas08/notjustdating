class UserType {
  final String iconUrl;
  final String title;
  final String subTitle;

  UserType(
      {required this.iconUrl, required this.title, required this.subTitle});
}

List<UserType> userTypes = [
  UserType(
      iconUrl: "assets/images/pngs/match_icon.png",
      title: "Match Making",
      subTitle:
          "I am here to match \nwith singles looking for \nrelationship."),
  UserType(
      iconUrl: "assets/images/pngs/video_icon.png",
      title: "Content Creator",
      subTitle: "I am here to create \nnvideo podcast and relatable \ncontents."),
];
