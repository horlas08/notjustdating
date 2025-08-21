class FlowerModel {
  final String? imageAsset;
  final String? credits;

  FlowerModel({required this.imageAsset, required this.credits});
}

List<FlowerModel> flowers = [
  FlowerModel(
      imageAsset: "assets/images/pngs/flower1.png", credits: "20 Credits"),
  FlowerModel(
      imageAsset: "assets/images/pngs/flower2.png", credits: "30 Credits"),
  FlowerModel(
      imageAsset: "assets/images/pngs/flower3.png", credits: "50 Credits"),
  FlowerModel(
      imageAsset: "assets/images/pngs/flower4.png", credits: "70 Credits")
];
