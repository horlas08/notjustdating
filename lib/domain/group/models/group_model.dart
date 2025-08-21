// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';


import 'package:ofwhich_v2/domain/group/models/member_model.dart';

class GroupModel {
  final int? id;
  final String? sdk_id;
  final String? name;
  final String? description;
  final bool? is_active;
  final bool? is_public;
  final List<MemberModel>? members;
  final String? create_at;
  final String? updated_at;

  GroupModel({
    this.id,
    this.sdk_id,
    this.name,
    this.description,
    this.is_active,
    this.is_public,
    this.members,
    this.create_at,
    this.updated_at,
  });

  

  GroupModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? sdk_id,
    ValueGetter<String?>? name,
    ValueGetter<String?>? description,
    ValueGetter<bool?>? is_active,
    ValueGetter<bool?>? is_public,
    ValueGetter<List<MemberModel>?>? members,
    ValueGetter<String?>? create_at,
    ValueGetter<String?>? updated_at,
  }) {
    return GroupModel(
      id: id != null ? id() : this.id,
      sdk_id: sdk_id != null ? sdk_id() : this.sdk_id,
      name: name != null ? name() : this.name,
      description: description != null ? description() : this.description,
      is_active: is_active != null ? is_active() : this.is_active,
      is_public: is_public != null ? is_public() : this.is_public,
      members: members != null ? members() : this.members,
      create_at: create_at != null ? create_at() : this.create_at,
      updated_at: updated_at != null ? updated_at() : this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sdk_id': sdk_id,
      'name': name,
      'description': description,
      'is_active': is_active,
      'is_public': is_public,
      'members': members?.map((x) => x.toMap()).toList(),
      'create_at': create_at,
      'updated_at': updated_at,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id']?.toInt(),
      sdk_id: map['sdk_id'],
      name: map['name'],
      description: map['description'],
      is_active: map['is_active'],
      is_public: map['is_public'],
      members: map['members'] != null ? List<MemberModel>.from(map['members']?.map((x) => MemberModel.fromMap(x))) : null,
      create_at: map['create_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) => GroupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupModel(id: $id, sdk_id: $sdk_id, name: $name, description: $description, is_active: $is_active, is_public: $is_public, members: $members, create_at: $create_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GroupModel &&
      other.id == id &&
      other.sdk_id == sdk_id &&
      other.name == name &&
      other.description == description &&
      other.is_active == is_active &&
      other.is_public == is_public &&
      listEquals(other.members, members) &&
      other.create_at == create_at &&
      other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      sdk_id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      is_active.hashCode ^
      is_public.hashCode ^
      members.hashCode ^
      create_at.hashCode ^
      updated_at.hashCode;
  }
}
