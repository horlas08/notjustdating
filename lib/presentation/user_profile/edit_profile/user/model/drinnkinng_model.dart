import 'dart:convert';

class DrinkingModel {
  final String value;

  DrinkingModel({
    required this.value,
  });

  DrinkingModel copyWith({
    String? value,
  }) {
    return DrinkingModel(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory DrinkingModel.fromMap(Map<String, dynamic> map) {
    return DrinkingModel(
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DrinkingModel.fromJson(String source) =>
      DrinkingModel.fromMap(json.decode(source));

  @override
  String toString() => 'DrinkingModel(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DrinkingModel && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

List<DrinkingModel> drinkingTypes = [
  DrinkingModel(value: "Often"),
  DrinkingModel(value: "On holiday"),
  DrinkingModel(value: "Sometimes"),
  DrinkingModel(value: "Never"),
];
