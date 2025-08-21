class GenderModel {
  final String title;
  final String value;

  GenderModel({required this.title, required this.value});
}

List<GenderModel> genders = [
  GenderModel(title: "I'm a Male", value: "Male"),
  GenderModel(title: "I'm a Female", value: "Female"),
  GenderModel(title: "Others", value: "Others")
];
