// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';

import 'package:ofwhich_v2/domain/group/models/group_model.dart';

class GroupResponse {
  final List<GroupModel>? groups;
  final int? current_page;
  final int? per_page;
  final int? total;
  final String? first_page_url;
  final String? prev_page_url;
  final String? next_page_url;
  final String? last_page_url;

  GroupResponse({
    this.groups,
    this.current_page,
    this.per_page,
    this.total,
    this.first_page_url,
    this.prev_page_url,
    this.next_page_url,
    this.last_page_url,
  });

  GroupResponse copyWith({
    ValueGetter<List<GroupModel>?>? groups,
    ValueGetter<int?>? current_page,
    ValueGetter<int?>? per_page,
    ValueGetter<int?>? total,
    ValueGetter<String?>? first_page_url,
    ValueGetter<String?>? prev_page_url,
    ValueGetter<String?>? next_page_url,
    ValueGetter<String?>? last_page_url,
  }) {
    return GroupResponse(
      groups: groups != null ? groups() : this.groups,
      current_page: current_page != null ? current_page() : this.current_page,
      per_page: per_page != null ? per_page() : this.per_page,
      total: total != null ? total() : this.total,
      first_page_url:
          first_page_url != null ? first_page_url() : this.first_page_url,
      prev_page_url:
          prev_page_url != null ? prev_page_url() : this.prev_page_url,
      next_page_url:
          next_page_url != null ? next_page_url() : this.next_page_url,
      last_page_url:
          last_page_url != null ? last_page_url() : this.last_page_url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groups': groups?.map((x) => x.toMap()).toList(),
      'current_page': current_page,
      'per_page': per_page,
      'total': total,
      'first_page_url': first_page_url,
      'prev_page_url': prev_page_url,
      'next_page_url': next_page_url,
      'last_page_url': last_page_url,
    };
  }

  factory GroupResponse.fromMap(Map<String, dynamic> map) {
    return GroupResponse(
      groups: map['groups'] != null
          ? List<GroupModel>.from(
              map['groups']?.map((x) => GroupModel.fromMap(x)))
          : null,
      current_page: map['current_page']?.toInt(),
      per_page: map['per_page']?.toInt(),
      total: map['total']?.toInt(),
      first_page_url: map['first_page_url'],
      prev_page_url: map['prev_page_url'],
      next_page_url: map['next_page_url'],
      last_page_url: map['last_page_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupResponse.fromJson(String source) =>
      GroupResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupResponse(groups: $groups, current_page: $current_page, per_page: $per_page, total: $total, first_page_url: $first_page_url, prev_page_url: $prev_page_url, next_page_url: $next_page_url, last_page_url: $last_page_url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupResponse &&
        listEquals(other.groups, groups) &&
        other.current_page == current_page &&
        other.per_page == per_page &&
        other.total == total &&
        other.first_page_url == first_page_url &&
        other.prev_page_url == prev_page_url &&
        other.next_page_url == next_page_url &&
        other.last_page_url == last_page_url;
  }

  @override
  int get hashCode {
    return groups.hashCode ^
        current_page.hashCode ^
        per_page.hashCode ^
        total.hashCode ^
        first_page_url.hashCode ^
        prev_page_url.hashCode ^
        next_page_url.hashCode ^
        last_page_url.hashCode;
  }
}
