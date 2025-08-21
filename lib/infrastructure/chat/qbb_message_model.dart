import 'dart:convert';

import 'package:flutter/foundation.dart';

class QBMessageModel {
  final bool markable;
  final int senderId;
  final List<int> deleiveredIds;
  final List<int> readIds;
  final String body;
  final int dateSent;
  final String dialogId;
  QBMessageModel({
    required this.markable,
    required this.senderId,
    required this.deleiveredIds,
    required this.readIds,
    required this.body,
    required this.dateSent,
    required this.dialogId,
  });

  QBMessageModel copyWith({
    bool? markable,
    int? senderId,
    List<int>? deleiveredIds,
    List<int>? readIds,
    String? body,
    int? dateSent,
    String? dialogId,
  }) {
    return QBMessageModel(
      markable: markable ?? this.markable,
      senderId: senderId ?? this.senderId,
      deleiveredIds: deleiveredIds ?? this.deleiveredIds,
      readIds: readIds ?? this.readIds,
      body: body ?? this.body,
      dateSent: dateSent ?? this.dateSent,
      dialogId: dialogId ?? this.dialogId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'markable': markable,
      'senderId': senderId,
      'deleiveredIds': deleiveredIds,
      'readIds': readIds,
      'body': body,
      'dateSent': dateSent,
      'dialogId': dialogId,
    };
  }

  factory QBMessageModel.fromMap(Map<String, dynamic> map) {
    return QBMessageModel(
      markable: map['markable'] ?? false,
      senderId: map['senderId']?.toInt() ?? 0,
      deleiveredIds: List<int>.from(map['deleiveredIds']),
      readIds: List<int>.from(map['readIds']),
      body: map['body'] ?? '',
      dateSent: map['dateSent']?.toInt() ?? 0,
      dialogId: map['dialogId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QBMessageModel.fromJson(String source) =>
      QBMessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QBMessageModel(markable: $markable, senderId: $senderId, deleiveredIds: $deleiveredIds, readIds: $readIds, body: $body, dateSent: $dateSent, dialogId: $dialogId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QBMessageModel &&
        other.markable == markable &&
        other.senderId == senderId &&
        listEquals(other.deleiveredIds, deleiveredIds) &&
        listEquals(other.readIds, readIds) &&
        other.body == body &&
        other.dateSent == dateSent &&
        other.dialogId == dialogId;
  }

  @override
  int get hashCode {
    return markable.hashCode ^
        senderId.hashCode ^
        deleiveredIds.hashCode ^
        readIds.hashCode ^
        body.hashCode ^
        dateSent.hashCode ^
        dialogId.hashCode;
  }
}
