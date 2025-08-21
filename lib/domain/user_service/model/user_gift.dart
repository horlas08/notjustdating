// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UserGift {
  final int id;
  final String name;
  final String description;
  final num unit_price;
  final String image;

  UserGift({
    required this.id,
    required this.name,
    required this.description,
    required this.unit_price,
    required this.image,
  });

  UserGift copyWith({
    int? id,
    String? name,
    String? description,
    num? unit_price,
    String? image,
  }) {
    return UserGift(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unit_price: unit_price ?? this.unit_price,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'unit_price': unit_price,
      'image': image,
    };
  }

  factory UserGift.fromMap(Map<String, dynamic> map) {
    return UserGift(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      unit_price: map['unit_price'] ?? 0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGift.fromJson(String source) => UserGift.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserGift(id: $id, name: $name, description: $description, unit_price: $unit_price, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserGift &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.unit_price == unit_price &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      unit_price.hashCode ^
      image.hashCode;
  }
}
