import 'dart:convert';

class PetModel {
  final String value;
  PetModel({
    required this.value,
  });

  PetModel copyWith({
    String? value,
  }) {
    return PetModel(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PetModel.fromJson(String source) =>
      PetModel.fromMap(json.decode(source));

  @override
  String toString() => 'PetModel(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PetModel && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

List<PetModel> petList = [
  PetModel(value: "Birds"),
  PetModel(value: "Cats"),
  PetModel(value: "Dogs"),
  PetModel(value: "Fish"),
  PetModel(value: "Hamsters"),
  PetModel(value: "Rabbits"),
  PetModel(value: "Snakes"),
  PetModel(value: "Turtles"),
  PetModel(value: "None"),
];
