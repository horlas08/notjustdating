class InterestModel {
  final String title;
  final String value;

  InterestModel({
    required this.title,
    required this.value,
  });
}

List<InterestModel> interest = [
  InterestModel(title: "Men", value: "Male"),
  InterestModel(title: "Women", value: "Female"),
  InterestModel(title: "Both", value: "Both"),
];
