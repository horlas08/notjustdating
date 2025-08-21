// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:ofwhich_v2/domain/user_service/model/user_gift.dart';

class WalletTransactionModel {
  final int? id;
  final UserGift? gift;
  final num? amount;
  final String? status;
  final String? type;
  final String? payment_type;
  final String? narration;
  final String? create_at;
  WalletTransactionModel({
    this.id,
    this.gift,
    this.amount,
    this.status,
    this.type,
    this.payment_type,
    this.narration,
    this.create_at,
  });

  WalletTransactionModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<UserGift?>? gift,
    ValueGetter<num?>? amount,
    ValueGetter<String?>? status,
    ValueGetter<String?>? type,
    ValueGetter<String?>? payment_type,
    ValueGetter<String?>? narration,
    ValueGetter<String?>? create_at,
  }) {
    return WalletTransactionModel(
      id: id != null ? id() : this.id,
      gift: gift != null ? gift() : this.gift,
      amount: amount != null ? amount() : this.amount,
      status: status != null ? status() : this.status,
      type: type != null ? type() : this.type,
      payment_type: payment_type != null ? payment_type() : this.payment_type,
      narration: narration != null ? narration() : this.narration,
      create_at: create_at != null ? create_at() : this.create_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gift': gift?.toMap(),
      'amount': amount,
      'status': status,
      'type': type,
      'payment_type': payment_type,
      'narration': narration,
      'created_at': create_at,
    };
  }

  factory WalletTransactionModel.fromMap(Map<String, dynamic> map) {
    return WalletTransactionModel(
      id: map['id']?.toInt(),
      gift: map['gift'] != null ? UserGift.fromMap(map['gift']) : null,
      amount: map['amount'],
      status: map['status'],
      type: map['type'],
      payment_type: map['payment_type'],
      narration: map['narration'],
      create_at: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletTransactionModel.fromJson(String source) =>
      WalletTransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletTransactionModel(id: $id, gift: $gift, amount: $amount, status: $status, type: $type, payment_type: $payment_type, narration: $narration, create_at: $create_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletTransactionModel &&
        other.id == id &&
        other.gift == gift &&
        other.amount == amount &&
        other.status == status &&
        other.type == type &&
        other.payment_type == payment_type &&
        other.narration == narration &&
        other.create_at == create_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gift.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        type.hashCode ^
        payment_type.hashCode ^
        narration.hashCode ^
        create_at.hashCode;
  }
}
