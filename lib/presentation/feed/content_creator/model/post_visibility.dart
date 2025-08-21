class PostVisibility {
  final String imgUrl;
  final String title;
  final String value;

  PostVisibility(
      {required this.imgUrl, required this.title, required this.value});
}

List<PostVisibility> postVisibiltiList = [
  PostVisibility(
      imgUrl: "assets/images/pngs/world_icon.png",
      value: "1",
      title: "Everyone can see this"),
  PostVisibility(
      imgUrl: "assets/images/pngs/world_icon.png",
      value: "0",
      title: "Only you can see this")
];
