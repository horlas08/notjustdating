// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'date_model.dart';

class DateRequestModel {
  String request_initiator_type;
  String budget;
  String payment_method;
  String? requestType;
  List<num> locations;
  List<DateModel> availability_options;
  DateRequestModel({
    required this.request_initiator_type,
    required this.budget,
    required this.payment_method,
    this.requestType,
    // required this.requested_id,
    required this.locations,
    required this.availability_options,
  });

  DateRequestModel copyWith({
    String? request_initiator_type,
    String? budget,
    String? payment_method,
    String? requested_id,
    List<num>? locations,
    List<DateModel>? availability_options,
  }) {
    return DateRequestModel(
      request_initiator_type:
          request_initiator_type ?? this.request_initiator_type,
      budget: budget ?? this.budget,
      payment_method: payment_method ?? this.payment_method,
      // requested_id: requested_id ?? this.requested_id,
      locations: locations ?? this.locations,
      availability_options: availability_options ?? this.availability_options,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'request_initiator_type': request_initiator_type,
      'budget': budget,
      'payment_method': payment_method,
      // 'requested_id': requested_id,
      'locations': locations,
      'availability_options':
          availability_options.map((x) => x.toMap()).toList(),
    };
  }

  factory DateRequestModel.fromMap(Map<String, dynamic> map) {
    return DateRequestModel(
      request_initiator_type: map['request_initiator_type'] ?? '',
      budget: map['budget'] ?? '',
      payment_method: map['payment_method'] ?? '',
      // requested_id: map['requested_id'] ?? 0,
      locations: List<num>.from(map['locations']),
      availability_options: List<DateModel>.from(
          map['availability_options']?.map((x) => DateModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DateRequestModel.fromJson(String source) =>
      DateRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DateRequestModel(request_initiator_type: $request_initiator_type, budget: $budget, payment_method: $payment_method, locations: $locations, availability_options: $availability_options)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DateRequestModel &&
        other.request_initiator_type == request_initiator_type &&
        other.budget == budget &&
        other.payment_method == payment_method &&
        // other.requested_id == requested_id &&
        listEquals(other.locations, locations) &&
        listEquals(other.availability_options, availability_options);
  }

  @override
  int get hashCode {
    return request_initiator_type.hashCode ^
        budget.hashCode ^
        payment_method.hashCode ^
        // requested_id.hashCode ^
        locations.hashCode ^
        availability_options.hashCode;
  }
}
