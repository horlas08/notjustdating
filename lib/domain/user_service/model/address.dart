import 'dart:convert';

class Address {
  final String address;
  final String longitude;
  final String latitude;

  Address({
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  Address copyWith({
    String? address,
    String? longitude,
    String? latitude,
  }) {
    return Address(
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address: map['address'] ?? '',
      longitude: map['longitude'] ?? '',
      latitude: map['latitude'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() =>
      'Address(address: $address, longitude: $longitude, latitude: $latitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.address == address &&
        other.longitude == longitude &&
        other.latitude == latitude;
  }

  @override
  int get hashCode => address.hashCode ^ longitude.hashCode ^ latitude.hashCode;
}
