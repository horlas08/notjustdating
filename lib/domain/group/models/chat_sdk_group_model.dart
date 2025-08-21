// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class MiniChatGroupModel {
  final int id;
  final String sdk_id;

  MiniChatGroupModel({
    required this.id,
    required this.sdk_id,
  });

  MiniChatGroupModel copyWith({
    int? id,
    String? sdk_id,
  }) {
    return MiniChatGroupModel(
      id: id ?? this.id,
      sdk_id: sdk_id ?? this.sdk_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sdk_id': sdk_id,
    };
  }

  factory MiniChatGroupModel.fromMap(Map<String, dynamic> map) {
    return MiniChatGroupModel(
      id: map['id']?.toInt() ?? 0,
      sdk_id: map['sdk_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniChatGroupModel.fromJson(String source) => MiniChatGroupModel.fromMap(json.decode(source));

  @override
  String toString() => 'MiniChatGroupModel(id: $id, sdk_id: $sdk_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MiniChatGroupModel &&
      other.id == id &&
      other.sdk_id == sdk_id;
  }

  @override
  int get hashCode => id.hashCode ^ sdk_id.hashCode;
}
