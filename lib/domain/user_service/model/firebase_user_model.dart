import 'dart:convert';

class UserFromFirestore {
  String userName;
  String userId;
  UserFromFirestore({
    required this.userName,
    required this.userId,
  });

  UserFromFirestore copyWith({
    String? userName,
    String? userId,
  }) {
    return UserFromFirestore(
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userId': userId,
    };
  }

  factory UserFromFirestore.fromMap(Map<String, dynamic> map) {
    return UserFromFirestore(
      userName: map['userName'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFromFirestore.fromJson(String source) =>
      UserFromFirestore.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserFromFirestore(userName: $userName, userId: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserFromFirestore &&
        other.userName == userName &&
        other.userId == userId;
  }

  @override
  int get hashCode => userName.hashCode ^ userId.hashCode;
}
