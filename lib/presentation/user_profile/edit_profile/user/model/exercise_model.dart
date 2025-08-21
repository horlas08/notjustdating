import 'dart:convert';

class ExerciseModel {
  String value;
  ExerciseModel({
    required this.value,
  });

  ExerciseModel copyWith({
    String? value,
  }) {
    return ExerciseModel(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap(json.decode(source));

  @override
  String toString() => 'ExerciseModel(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExerciseModel && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

List<ExerciseModel> exerciseList = [
  ExerciseModel(value: "Lifestyle"),
  ExerciseModel(value: "Regularly"),
  ExerciseModel(value: "Often"),
  ExerciseModel(value: "Sometimes"),
  ExerciseModel(value: "Never"),
];
