// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

//  import 'package:flutter/widgets.dart';

import 'tagged_user_model.dart';

class FeedPostModel {
  final int id;
  final int user_id;
  final String file_name;
  final String comment;
  final int location_id;
  final List<TaggedUserModel> tagged_people;
  final int is_public;
  final String? status;
  final String? file_url;
  final Comments comments;
  final Likes likes;
  FeedPostModel({
    required this.id,
    required this.user_id,
    required this.file_name,
    required this.comment,
    required this.location_id,
    required this.tagged_people,
    required this.is_public,
    this.status,
    this.file_url,
    required this.comments,
    required this.likes,
  });

  FeedPostModel copyWith({
    int? id,
    int? user_id,
    String? file_name,
    String? comment,
    int? location_id,
    List<TaggedUserModel>? tagged_people,
    int? is_public,
    String? status,
    ValueGetter<String?>? file_url,
    Comments? comments,
    Likes? likes,
  }) {
    return FeedPostModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      file_name: file_name ?? this.file_name,
      comment: comment ?? this.comment,
      location_id: location_id ?? this.location_id,
      tagged_people: tagged_people ?? this.tagged_people,
      is_public: is_public ?? this.is_public,
      status: status ?? this.status,
      file_url: file_url != null ? file_url() : this.file_url,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'file_name': file_name,
      'comment': comment,
      'location_id': location_id,
      'tagged_people': tagged_people.map((x) => x.toMap()).toList(),
      'is_public': is_public,
      'status': status,
      'file_url': file_url,
      'comments': comments.toMap(),
      'likes': likes.toMap(),
    };
  }

  factory FeedPostModel.fromMap(Map<String, dynamic> map) {
    return FeedPostModel(
      id: map['id']?.toInt() ?? 0,
      user_id: map['user_id']?.toInt() ?? 0,
      file_name: map['file_name'] ?? '',
      comment: map['comment'] ?? '',
      location_id: map['location_id']?.toInt() ?? 0,
      tagged_people: List<TaggedUserModel>.from(
          map['tagged_people']?.map((x) => TaggedUserModel.fromMap(x))),
      is_public: map['is_public']?.toInt() ?? 0,
      status: map['status'] ?? '',
      file_url: map['file_url'],
      comments: Comments.fromMap(map['comments']),
      likes: Likes.fromMap(map['likes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedPostModel.fromJson(String source) =>
      FeedPostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedPostModel(id: $id, user_id: $user_id, file_name: $file_name, comment: $comment, location_id: $location_id, tagged_people: $tagged_people, is_public: $is_public, status: $status, file_url: $file_url, comments: $comments, likes: $likes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedPostModel &&
        other.id == id &&
        other.user_id == user_id &&
        other.file_name == file_name &&
        other.comment == comment &&
        other.location_id == location_id &&
        listEquals(other.tagged_people, tagged_people) &&
        other.is_public == is_public &&
        other.status == status &&
        other.file_url == file_url &&
        other.comments == comments &&
        other.likes == likes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        file_name.hashCode ^
        comment.hashCode ^
        location_id.hashCode ^
        tagged_people.hashCode ^
        is_public.hashCode ^
        status.hashCode ^
        file_url.hashCode ^
        comments.hashCode ^
        likes.hashCode;
  }
}

class UserModelForPost {
  final int? user_id;
  final String full_name;
  final int? like_id;
  final String? comment;
  UserModelForPost({
    this.user_id,
    required this.full_name,
    this.like_id,
    this.comment,
  });

  UserModelForPost copyWith({
    ValueGetter<int?>? user_id,
    String? full_name,
    ValueGetter<int?>? like_id,
    ValueGetter<String?>? comment,
  }) {
    return UserModelForPost(
      user_id: user_id != null ? user_id() : this.user_id,
      full_name: full_name ?? this.full_name,
      like_id: like_id != null ? like_id() : this.like_id,
      comment: comment != null ? comment() : this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'full_name': full_name,
      'like_id': like_id,
      'comment': comment,
    };
  }

  factory UserModelForPost.fromMap(Map<String, dynamic> map) {
    return UserModelForPost(
      user_id: map['user_id']?.toInt(),
      full_name: map['full_name'] ?? '',
      like_id: map['like_id']?.toInt(),
      comment: map['comment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelForPost.fromJson(String source) =>
      UserModelForPost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModelForPost(user_id: $user_id, full_name: $full_name, like_id: $like_id, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModelForPost &&
        other.user_id == user_id &&
        other.full_name == full_name &&
        other.like_id == like_id &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        full_name.hashCode ^
        like_id.hashCode ^
        comment.hashCode;
  }
}

class Comments {
  final int? total_count;
  final List<UserModelForPost> users;
  final int comment_id;
  Comments({
    this.total_count,
    required this.users,
    required this.comment_id,
  });

  Comments copyWith({
    ValueGetter<int?>? total_count,
    List<UserModelForPost>? users,
    int? comment_id,
  }) {
    return Comments(
      total_count: total_count != null ? total_count() : this.total_count,
      users: users ?? this.users,
      comment_id: comment_id ?? this.comment_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_count': total_count,
      'users': users.map((x) => x.toMap()).toList(),
      'comment_id': comment_id,
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      total_count: map['total_count']?.toInt(),
      users: List<UserModelForPost>.from(
          map['users']?.map((x) => UserModelForPost.fromMap(x))),
      comment_id: map['comment_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comments.fromJson(String source) =>
      Comments.fromMap(json.decode(source));

  @override
  String toString() =>
      'Comments(total_count: $total_count, users: $users, comment_id: $comment_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comments &&
        other.total_count == total_count &&
        listEquals(other.users, users) &&
        other.comment_id == comment_id;
  }

  @override
  int get hashCode =>
      total_count.hashCode ^ users.hashCode ^ comment_id.hashCode;
}

class Likes {
  final int? total_count;
  final List<UserModelForPost> users;
  Likes({
    this.total_count,
    required this.users,
  });

  Likes copyWith({
    ValueGetter<int?>? total_count,
    List<UserModelForPost>? users,
  }) {
    return Likes(
      total_count: total_count != null ? total_count() : this.total_count,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_count': total_count,
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory Likes.fromMap(Map<String, dynamic> map) {
    return Likes(
      total_count: map['total_count']?.toInt(),
      users: List<UserModelForPost>.from(
          map['users']?.map((x) => UserModelForPost.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Likes.fromJson(String source) => Likes.fromMap(json.decode(source));

  @override
  String toString() => 'Likes(total_count: $total_count, users: $users)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Likes &&
        other.total_count == total_count &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode => total_count.hashCode ^ users.hashCode;
}
