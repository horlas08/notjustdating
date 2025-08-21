import 'dart:convert';

//  locationId: locationId,
//         ageRangeStart: ageRangeStart,
//         ageRangeEnd: ageRangeEnd,
//         radiusStart: radiusStart,
//         radiusEnd: radiusEnd
class FilterDataModel {
  final int locationId;
  final int ageRangeStart;
  final int ageRangeEnd;
  final int radiusStart;
  final int radiusEnd;
  FilterDataModel({
    required this.locationId,
    required this.ageRangeStart,
    required this.ageRangeEnd,
    required this.radiusStart,
    required this.radiusEnd,
  });

  FilterDataModel copyWith({
    int? locationId,
    int? ageRangeStart,
    int? ageRangeEnd,
    int? radiusStart,
    int? radiusEnd,
  }) {
    return FilterDataModel(
      locationId: locationId ?? this.locationId,
      ageRangeStart: ageRangeStart ?? this.ageRangeStart,
      ageRangeEnd: ageRangeEnd ?? this.ageRangeEnd,
      radiusStart: radiusStart ?? this.radiusStart,
      radiusEnd: radiusEnd ?? this.radiusEnd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationId': locationId,
      'ageRangeStart': ageRangeStart,
      'ageRangeEnd': ageRangeEnd,
      'radiusStart': radiusStart,
      'radiusEnd': radiusEnd,
    };
  }

  factory FilterDataModel.fromMap(Map<String, dynamic> map) {
    return FilterDataModel(
      locationId: map['locationId']?.toInt() ?? 0,
      ageRangeStart: map['ageRangeStart']?.toInt() ?? 0,
      ageRangeEnd: map['ageRangeEnd']?.toInt() ?? 0,
      radiusStart: map['radiusStart']?.toInt() ?? 0,
      radiusEnd: map['radiusEnd']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterDataModel.fromJson(String source) =>
      FilterDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FilterDataModel(locationId: $locationId, ageRangeStart: $ageRangeStart, ageRangeEnd: $ageRangeEnd, radiusStart: $radiusStart, radiusEnd: $radiusEnd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterDataModel &&
        other.locationId == locationId &&
        other.ageRangeStart == ageRangeStart &&
        other.ageRangeEnd == ageRangeEnd &&
        other.radiusStart == radiusStart &&
        other.radiusEnd == radiusEnd;
  }

  @override
  int get hashCode {
    return locationId.hashCode ^
        ageRangeStart.hashCode ^
        ageRangeEnd.hashCode ^
        radiusStart.hashCode ^
        radiusEnd.hashCode;
  }
}
