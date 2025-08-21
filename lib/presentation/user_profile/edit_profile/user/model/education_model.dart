import 'dart:convert';

class EducationModel {
  final String value;

  EducationModel({
    required this.value,
  });

  EducationModel copyWith({
    String? value,
  }) {
    return EducationModel(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EducationModel.fromJson(String source) =>
      EducationModel.fromMap(json.decode(source));

  @override
  String toString() => 'EducationModel(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EducationModel && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

List<EducationModel> educationList = [
  EducationModel(value: "High School"),
  EducationModel(value: "Tech School"),
  EducationModel(value: "In College"),
  EducationModel(value: "Undergraduate Degree"),
  EducationModel(value: "In grad school"),
  EducationModel(value: "Graduate school"),
];
