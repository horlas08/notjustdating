import 'dart:convert';

//  "payment_data": {
//             "reference_id": "9530833302032L0",
//             "name": "Ade ade",
//             "email": "balop97@gmail.com",
//             "amount": 5000
//         },

// ignore_for_file: non_constant_identifier_names

class DatePaymentData {
  final String reference_id;
  final String name;
  final String email;
  final num amount;
  DatePaymentData({
    required this.reference_id,
    required this.name,
    required this.email,
    required this.amount,
  });

  // DatePaymentData(
  //     {required this.reference_id,
  //     required this.name,
  //     required this.email,
  //     required this.amount});

  DatePaymentData copyWith({
    String? reference_id,
    String? name,
    String? email,
    num? amount,
  }) {
    return DatePaymentData(
      reference_id: reference_id ?? this.reference_id,
      name: name ?? this.name,
      email: email ?? this.email,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference_id': reference_id,
      'name': name,
      'email': email,
      'amount': amount,
    };
  }

  factory DatePaymentData.fromMap(Map<String, dynamic> map) {
    return DatePaymentData(
      reference_id: map['reference_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      amount: map['amount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DatePaymentData.fromJson(String source) =>
      DatePaymentData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DatePaymentData(reference_id: $reference_id, name: $name, email: $email, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DatePaymentData &&
        other.reference_id == reference_id &&
        other.name == name &&
        other.email == email &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return reference_id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        amount.hashCode;
  }
}
