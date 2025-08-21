import 'dart:convert';

class SmokingModel {
  final String value;

  SmokingModel({
    required this.value,
  });

  SmokingModel copyWith({
    String? value,
  }) {
    return SmokingModel(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory SmokingModel.fromMap(Map<String, dynamic> map) {
    return SmokingModel(
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SmokingModel.fromJson(String source) =>
      SmokingModel.fromMap(json.decode(source));

  @override
  String toString() => 'SmokingModel(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SmokingModel && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

List<SmokingModel> smokingTypes = [
  SmokingModel(value: "Regularly"),
  SmokingModel(value: "On holiday"),
  SmokingModel(value: "Sometimes"),
  SmokingModel(value: "Never"),
];
