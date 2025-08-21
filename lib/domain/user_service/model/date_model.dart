import 'dart:convert';

class DateModel {
  final String date;
  final String time;

  DateModel({
    required this.date,
    required this.time,
  });

  DateModel copyWith({
    String? date,
    String? time,
  }) {
    return DateModel(
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
    };
  }

  factory DateModel.fromDateTime(DateTime dateTime) {
    // Format date as YYYY-MM-DD
    String date =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    // Format time as HH:MM
    String time =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return DateModel(date: date, time: time);
  }

  factory DateModel.fromMap(Map<String, dynamic> map) {
    return DateModel(
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DateModel.fromJson(String source) =>
      DateModel.fromMap(json.decode(source));

  @override
  String toString() => 'DateModel(date: $date, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DateModel && other.date == date && other.time == time;
  }

  @override
  int get hashCode => date.hashCode ^ time.hashCode;
}
