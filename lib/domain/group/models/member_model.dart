// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/widgets.dart';

class MemberModel {
  final int? id;
  final String? full_name;
  final String? photo;
  final String? email;

  MemberModel({
    this.id,
    this.full_name,
    this.photo,
    this.email,
  });

 

  MemberModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? full_name,
    ValueGetter<String?>? photo,
    ValueGetter<String?>? email,
  }) {
    return MemberModel(
      id: id != null ? id() : this.id,
      full_name: full_name != null ? full_name() : this.full_name,
      photo: photo != null ? photo() : this.photo,
      email: email != null ? email() : this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': full_name,
      'photo': photo,
      'email': email,
    };
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id']?.toInt(),
      full_name: map['full_name'],
      photo: map['photo'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberModel.fromJson(String source) => MemberModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MemberModel(id: $id, full_name: $full_name, photo: $photo, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MemberModel &&
      other.id == id &&
      other.full_name == full_name &&
      other.photo == photo &&
      other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      full_name.hashCode ^
      photo.hashCode ^
      email.hashCode;
  }
}
