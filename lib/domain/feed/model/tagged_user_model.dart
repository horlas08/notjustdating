// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class TaggedUserModel {
  final int id;
  final String full_name;

  TaggedUserModel({
    required this.id,
    required this.full_name,
  });

  

  TaggedUserModel copyWith({
    int? id,
    String? full_name,
  }) {
    return TaggedUserModel(
      id: id ?? this.id,
      full_name: full_name ?? this.full_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': full_name,
    };
  }

  factory TaggedUserModel.fromMap(Map<String, dynamic> map) {
    return TaggedUserModel(
      id: map['id']?.toInt() ?? 0,
      full_name: map['full_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaggedUserModel.fromJson(String source) => TaggedUserModel.fromMap(json.decode(source));

  @override
  String toString() => 'TaggedUserModel(id: $id, full_name: $full_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TaggedUserModel &&
      other.id == id &&
      other.full_name == full_name;
  }

  @override
  int get hashCode => id.hashCode ^ full_name.hashCode;
}
