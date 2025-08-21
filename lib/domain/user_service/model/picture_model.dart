// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/widgets.dart';

class PictureModel {
  final int? id;
  final String? file_url;
  PictureModel({
    this.id,
    this.file_url,
  });

  PictureModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? file_path,
  }) {
    return PictureModel(
      id: id != null ? id() : this.id,
      file_url: file_path != null ? file_path() : file_url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'file_url': file_url,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      id: map['id']?.toInt(),
      file_url: map['file_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) =>
      PictureModel.fromMap(json.decode(source));

  @override
  String toString() => 'PictureModel(id: $id, file_url: $file_url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PictureModel &&
        other.id == id &&
        other.file_url == file_url;
  }

  @override
  int get hashCode => id.hashCode ^ file_url.hashCode;
}
