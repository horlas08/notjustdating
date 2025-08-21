import 'dart:convert';

class SubbscriptionResponseModel {
  final String referenceId;
  final String email;
  final String name;
  final num amount;
  SubbscriptionResponseModel({
    required this.referenceId,
    required this.email,
    required this.name,
    required this.amount,
  });

  SubbscriptionResponseModel copyWith({
    String? referenceId,
    String? email,
    String? name,
    num? amount,
  }) {
    return SubbscriptionResponseModel(
      referenceId: referenceId ?? this.referenceId,
      email: email ?? this.email,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference_id': referenceId,
      'email': email,
      'name': name,
      'amount': amount,
    };
  }

  factory SubbscriptionResponseModel.fromMap(Map<String, dynamic> map) {
    return SubbscriptionResponseModel(
      referenceId: map['reference_id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      amount: map['amount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubbscriptionResponseModel.fromJson(String source) =>
      SubbscriptionResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubbscriptionResponseModel(referenceId: $referenceId, email: $email, name: $name, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubbscriptionResponseModel &&
        other.referenceId == referenceId &&
        other.email == email &&
        other.name == name &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return referenceId.hashCode ^
        email.hashCode ^
        name.hashCode ^
        amount.hashCode;
  }
}
