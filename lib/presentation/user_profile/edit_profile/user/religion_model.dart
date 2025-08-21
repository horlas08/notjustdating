import 'dart:convert';

class ReligionModel {
  final String value;
  ReligionModel({
    required this.value,
  });

  ReligionModel copyWith({
    String? value,
  }) {
    return ReligionModel(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory ReligionModel.fromMap(Map<String, dynamic> map) {
    return ReligionModel(
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReligionModel.fromJson(String source) =>
      ReligionModel.fromMap(json.decode(source));

  @override
  String toString() => 'ReligionModel(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReligionModel && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

List<ReligionModel> religionlist = [
  ReligionModel(value: "Atheism"),
  ReligionModel(value: "Buddhism"),
  ReligionModel(value: "Christianity"),
  ReligionModel(value: "Hinduism"),
  ReligionModel(value: "Islam"),
  ReligionModel(value: "Judaism"),
  ReligionModel(value: "Others"),
];
