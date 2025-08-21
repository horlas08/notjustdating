import 'dart:convert';

class RecentMatches {
  String name;
  String imgUlr;
  RecentMatches({
    required this.name,
    required this.imgUlr,
  });

  RecentMatches copyWith({
    String? name,
    String? imgUlr,
  }) {
    return RecentMatches(
      name: name ?? this.name,
      imgUlr: imgUlr ?? this.imgUlr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUlr': imgUlr,
    };
  }

  factory RecentMatches.fromMap(Map<String, dynamic> map) {
    return RecentMatches(
      name: map['name'] ?? '',
      imgUlr: map['imgUlr'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentMatches.fromJson(String source) =>
      RecentMatches.fromMap(json.decode(source));

  @override
  String toString() => 'RecentMatches(name: $name, imgUlr: $imgUlr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecentMatches &&
        other.name == name &&
        other.imgUlr == imgUlr;
  }

  @override
  int get hashCode => name.hashCode ^ imgUlr.hashCode;
}

List<RecentMatches> recentMatches = [
  RecentMatches(name: "Anna", imgUlr: "assets/images/pngs/anna.png"),
  RecentMatches(name: "Rose", imgUlr: "assets/images/pngs/rose.png"),
  RecentMatches(name: "Abriel", imgUlr: "assets/images/pngs/abriel.png"),
  RecentMatches(name: "Felicia", imgUlr: "assets/images/pngs/felicia.png"),
  RecentMatches(name: "Jenny", imgUlr: "assets/images/pngs/jenny.png"),
];
