// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:ofwhich_v2/domain/feed/model/tagged_user_model.dart';

class DraftModel {
  final int? id;
  final TaggedUserModel user;
  final String? file_name;
  final String file_url;
  final String comment;
  final String? create_at;
  final String? updated_at;

  DraftModel({
    this.id,
    required this.user,
    this.file_name,
    required this.file_url,
    required this.comment,
    this.create_at,
    this.updated_at,
  });

  DraftModel copyWith({
    ValueGetter<int?>? id,
    TaggedUserModel? user,
    ValueGetter<String?>? file_name,
    String? file_url,
    String? comment,
    ValueGetter<String?>? create_at,
    ValueGetter<String?>? updated_at,
  }) {
    return DraftModel(
      id: id != null ? id() : this.id,
      user: user ?? this.user,
      file_name: file_name != null ? file_name() : this.file_name,
      file_url: file_url ?? this.file_url,
      comment: comment ?? this.comment,
      create_at: create_at != null ? create_at() : this.create_at,
      updated_at: updated_at != null ? updated_at() : this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'file_name': file_name,
      'file_url': file_url,
      'comment': comment,
      'create_at': create_at,
      'updated_at': updated_at,
    };
  }

  factory DraftModel.fromMap(Map<String, dynamic> map) {
    return DraftModel(
      id: map['id']?.toInt(),
      user: TaggedUserModel.fromMap(map['user']),
      file_name: map['file_name'],
      file_url: map['file_url'] ?? '',
      comment: map['comment'] ?? '',
      create_at: map['create_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DraftModel.fromJson(String source) => DraftModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DraftModel(id: $id, user: $user, file_name: $file_name, file_url: $file_url, comment: $comment, create_at: $create_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DraftModel &&
      other.id == id &&
      other.user == user &&
      other.file_name == file_name &&
      other.file_url == file_url &&
      other.comment == comment &&
      other.create_at == create_at &&
      other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user.hashCode ^
      file_name.hashCode ^
      file_url.hashCode ^
      comment.hashCode ^
      create_at.hashCode ^
      updated_at.hashCode;
  }
}
