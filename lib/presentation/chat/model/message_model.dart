import 'dart:convert';

class MessageModel {
  String name;
  String imageUrl;
  String date;
  String lastMessage;
  MessageModel({
    required this.name,
    required this.imageUrl,
    required this.date,
    required this.lastMessage,
  });

  MessageModel copyWith({
    String? name,
    String? imageUrl,
    String? date,
    String? lastMessage,
  }) {
    return MessageModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'date': date,
      'lastMessage': lastMessage,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      date: map['date'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(name: $name, imageUrl: $imageUrl, date: $date, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.date == date &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imageUrl.hashCode ^
        date.hashCode ^
        lastMessage.hashCode;
  }
}

List<MessageModel> messages = [
  MessageModel(
      name: "Georgia",
      imageUrl: "",
      date: "11 Mar",
      lastMessage: "Hello, how are you"),
  MessageModel(
      name: "Daniella",
      imageUrl: "assets/images/pngs/daniella.png",
      date: "14 Mar",
      lastMessage: "Tell me more about you"),
  MessageModel(
      name: "Esther",
      imageUrl: "assets/images/pngs/esther.png",
      date: "2 Mar",
      lastMessage: "Here you go, call me"),
  MessageModel(
      name: "Candy",
      imageUrl: "assets/images/pngs/candy.png",
      date: "26 Feb",
      lastMessage: "Yes its a date"),
  MessageModel(
      name: "Francisca",
      imageUrl: "",
      date: "26 Feb",
      lastMessage: "Good luck to you too")
];
