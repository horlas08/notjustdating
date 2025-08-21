// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ofwhich_v2/domain/feed/model/feed_post_model.dart';

class FeedsModel {
  final int current_page;
  final List<FeedPostModel> posts;
  final String first_page_url;
  final int from;
  final int last_page;

  final String last_page_url;
  final String next_page_url;
  final String path;
  final int per_page;

  FeedsModel({
    required this.current_page,
    required this.posts,
    required this.first_page_url,
    required this.from,
    required this.last_page,
    required this.last_page_url,
    required this.next_page_url,
    required this.path,
    required this.per_page,
  });

  FeedsModel copyWith({
    int? current_page,
    List<FeedPostModel>? posts,
    String? first_page_url,
    int? from,
    int? last_page,
    String? last_page_url,
    String? next_page_url,
    String? path,
    int? per_page,
  }) {
    return FeedsModel(
      current_page: current_page ?? this.current_page,
      posts: posts ?? this.posts,
      first_page_url: first_page_url ?? this.first_page_url,
      from: from ?? this.from,
      last_page: last_page ?? this.last_page,
      last_page_url: last_page_url ?? this.last_page_url,
      next_page_url: next_page_url ?? this.next_page_url,
      path: path ?? this.path,
      per_page: per_page ?? this.per_page,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_page': current_page,
      'posts': posts.map((x) => x.toMap()).toList(),
      'first_page_url': first_page_url,
      'from': from,
      'last_page': last_page,
      'last_page_url': last_page_url,
      'next_page_url': next_page_url,
      'path': path,
      'per_page': per_page,
    };
  }

  factory FeedsModel.fromMap(Map<String, dynamic> map) {
    return FeedsModel(
      current_page: map['current_page']?.toInt() ?? 0,
      posts: List<FeedPostModel>.from(
          map['posts']?.map((x) => FeedPostModel.fromMap(x))),
      first_page_url: map['first_page_url'] ?? '',
      from: map['from']?.toInt() ?? 0,
      last_page: map['last_page']?.toInt() ?? 0,
      last_page_url: map['last_page_url'] ?? '',
      next_page_url: map['next_page_url'] ?? '',
      path: map['path'] ?? '',
      per_page: map['per_page']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedsModel.fromJson(String source) =>
      FeedsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedsModel(current_page: $current_page, posts: $posts, first_page_url: $first_page_url, from: $from, last_page: $last_page, last_page_url: $last_page_url, next_page_url: $next_page_url, path: $path, per_page: $per_page)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedsModel &&
        other.current_page == current_page &&
        listEquals(other.posts, posts) &&
        other.first_page_url == first_page_url &&
        other.from == from &&
        other.last_page == last_page &&
        other.last_page_url == last_page_url &&
        other.next_page_url == next_page_url &&
        other.path == path &&
        other.per_page == per_page;
  }

  @override
  int get hashCode {
    return current_page.hashCode ^
        posts.hashCode ^
        first_page_url.hashCode ^
        from.hashCode ^
        last_page.hashCode ^
        last_page_url.hashCode ^
        next_page_url.hashCode ^
        path.hashCode ^
        per_page.hashCode;
  }
}
