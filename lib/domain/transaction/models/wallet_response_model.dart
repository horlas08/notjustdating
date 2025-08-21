// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
//  import 'package:flutter/widgets.dart';

import 'wallet_transaction_model.dart';

class WalletResponseModel {
  final String? status;
  final String? message;
  final List<WalletTransactionModel?> transactions;
  final int? current_page;
  final num? total_spent;
  final num? total_received;
  final int? per_page;
  final int? total;
  final String? first_page_url;
  final String? prev_page_url;
  final String? next_page_url;
  final String? last_page_url;
  WalletResponseModel({
    this.status,
    this.message,
    required this.transactions,
    this.current_page,
    this.total_spent,
    this.total_received,
    this.per_page,
    this.total,
    this.first_page_url,
    this.prev_page_url,
    this.next_page_url,
    this.last_page_url,
  });
 

  WalletResponseModel copyWith({
    ValueGetter<String?>? status,
    ValueGetter<String?>? message,
    List<WalletTransactionModel?>? transactions,
    ValueGetter<int?>? current_page,
    ValueGetter<num?>? total_spent,
    ValueGetter<num?>? total_received,
    ValueGetter<int?>? per_page,
    ValueGetter<int?>? total,
    ValueGetter<String?>? first_page_url,
    ValueGetter<String?>? prev_page_url,
    ValueGetter<String?>? next_page_url,
    ValueGetter<String?>? last_page_url,
  }) {
    return WalletResponseModel(
      status: status != null ? status() : this.status,
      message: message != null ? message() : this.message,
      transactions: transactions ?? this.transactions,
      current_page: current_page != null ? current_page() : this.current_page,
      total_spent: total_spent != null ? total_spent() : this.total_spent,
      total_received: total_received != null ? total_received() : this.total_received,
      per_page: per_page != null ? per_page() : this.per_page,
      total: total != null ? total() : this.total,
      first_page_url: first_page_url != null ? first_page_url() : this.first_page_url,
      prev_page_url: prev_page_url != null ? prev_page_url() : this.prev_page_url,
      next_page_url: next_page_url != null ? next_page_url() : this.next_page_url,
      last_page_url: last_page_url != null ? last_page_url() : this.last_page_url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'transactions': transactions.map((x) => x?.toMap()).toList(),
      'current_page': current_page,
      'total_spent': total_spent,
      'total_received': total_received,
      'per_page': per_page,
      'total': total,
      'first_page_url': first_page_url,
      'prev_page_url': prev_page_url,
      'next_page_url': next_page_url,
      'last_page_url': last_page_url,
    };
  }

  factory WalletResponseModel.fromMap(Map<String, dynamic> map) {
    return WalletResponseModel(
      status: map['status'],
      message: map['message'],
      transactions: List<WalletTransactionModel?>.from(map['transactions']?.map((x) => WalletTransactionModel.fromMap(x))),
      current_page: map['current_page']?.toInt(),
      total_spent: map['total_spent'],
      total_received: map['total_received'],
      per_page: map['per_page']?.toInt(),
      total: map['total']?.toInt(),
      first_page_url: map['first_page_url'],
      prev_page_url: map['prev_page_url'],
      next_page_url: map['next_page_url'],
      last_page_url: map['last_page_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletResponseModel.fromJson(String source) => WalletResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletResponseModel(status: $status, message: $message, transactions: $transactions, current_page: $current_page, total_spent: $total_spent, total_received: $total_received, per_page: $per_page, total: $total, first_page_url: $first_page_url, prev_page_url: $prev_page_url, next_page_url: $next_page_url, last_page_url: $last_page_url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WalletResponseModel &&
      other.status == status &&
      other.message == message &&
      listEquals(other.transactions, transactions) &&
      other.current_page == current_page &&
      other.total_spent == total_spent &&
      other.total_received == total_received &&
      other.per_page == per_page &&
      other.total == total &&
      other.first_page_url == first_page_url &&
      other.prev_page_url == prev_page_url &&
      other.next_page_url == next_page_url &&
      other.last_page_url == last_page_url;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      message.hashCode ^
      transactions.hashCode ^
      current_page.hashCode ^
      total_spent.hashCode ^
      total_received.hashCode ^
      per_page.hashCode ^
      total.hashCode ^
      first_page_url.hashCode ^
      prev_page_url.hashCode ^
      next_page_url.hashCode ^
      last_page_url.hashCode;
  }
}
