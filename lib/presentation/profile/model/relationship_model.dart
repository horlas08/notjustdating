class RelationshipModel {
  final String? title;
  final String? subtTtile;

  RelationshipModel({required this.title, required this.subtTtile});
}

List<RelationshipModel> relationships = [
  RelationshipModel(
      title: "Single", subtTtile: "Single and not in any relationship"),
  RelationshipModel(
      title: "Divorced",
      subtTtile: "Married before and parted ways in my marriage"),
  RelationshipModel(
      title: "Single Parent",
      subtTtile: "I am a single parent with children/child"),
  RelationshipModel(
      title: "Widow", subtTtile: "Married before but partner is dead"),
  RelationshipModel(
      title: "Open relationship",
      subtTtile: "I am in a relationship but open to another"),
  RelationshipModel(
      title: "Others", subtTtile: "Select the category you fall under"),
];
