// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';

import '../../../domain/user_service/model/user_object.dart';

class FeedsModel {
  List<UserModel>? users;
  int? currentPage;
  String? per_page;
  String? first_page_url;
 String? prev_page_url;
 String? next_page_url;
String? last_page_url;
  FeedsModel({
    this.users,
    this.currentPage,
    this.per_page,
    this.first_page_url,
    this.prev_page_url,
    this.next_page_url,
    this.last_page_url,
  });

 

  FeedsModel copyWith({
    ValueGetter<List<UserModel>?>? users,
    ValueGetter<int?>? currentPage,
    ValueGetter<String?>? per_page,
    ValueGetter<String?>? first_page_url,
    ValueGetter<String?>? prev_page_url,
    ValueGetter<String?>? next_page_url,
    ValueGetter<String?>? last_page_url,
  }) {
    return FeedsModel(
      users: users != null ? users() : this.users,
      currentPage: currentPage != null ? currentPage() : this.currentPage,
      per_page: per_page != null ? per_page() : this.per_page,
      first_page_url: first_page_url != null ? first_page_url() : this.first_page_url,
      prev_page_url: prev_page_url != null ? prev_page_url() : this.prev_page_url,
      next_page_url: next_page_url != null ? next_page_url() : this.next_page_url,
      last_page_url: last_page_url != null ? last_page_url() : this.last_page_url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': users?.map((x) => x?.toMap())?.toList(),
      'currentPage': currentPage,
      'per_page': per_page,
      'first_page_url': first_page_url,
      'prev_page_url': prev_page_url,
      'next_page_url': next_page_url,
      'last_page_url': last_page_url,
    };
  }

  factory FeedsModel.fromMap(Map<String, dynamic> map) {
    return FeedsModel(
      users: map['users'] != null ? List<UserModel>.from(map['users']?.map((x) => UserModel.fromMap(x))) : null,
      currentPage: map['currentPage']?.toInt(),
      per_page: map['per_page'],
      first_page_url: map['first_page_url'],
      prev_page_url: map['prev_page_url'],
      next_page_url: map['next_page_url'],
      last_page_url: map['last_page_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedsModel.fromJson(String source) => FeedsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedsModel(users: $users, currentPage: $currentPage, per_page: $per_page, first_page_url: $first_page_url, prev_page_url: $prev_page_url, next_page_url: $next_page_url, last_page_url: $last_page_url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FeedsModel &&
      listEquals(other.users, users) &&
      other.currentPage == currentPage &&
      other.per_page == per_page &&
      other.first_page_url == first_page_url &&
      other.prev_page_url == prev_page_url &&
      other.next_page_url == next_page_url &&
      other.last_page_url == last_page_url;
  }

  @override
  int get hashCode {
    return users.hashCode ^
      currentPage.hashCode ^
      per_page.hashCode ^
      first_page_url.hashCode ^
      prev_page_url.hashCode ^
      next_page_url.hashCode ^
      last_page_url.hashCode;
  }
}




