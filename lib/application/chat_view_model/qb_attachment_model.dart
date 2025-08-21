import 'dart:convert';

class QBAttachmentModel {
  final String url;
  final String contextType;

  QBAttachmentModel({
    required this.url,
    required this.contextType,
  });

  QBAttachmentModel copyWith({
    String? url,
    String? contextType,
  }) {
    return QBAttachmentModel(
      url: url ?? this.url,
      contextType: contextType ?? this.contextType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'contextType': contextType,
    };
  }

  factory QBAttachmentModel.fromMap(Map<String, dynamic> map) {
    return QBAttachmentModel(
      url: map['url'] ?? '',
      contextType: map['contextType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QBAttachmentModel.fromJson(String source) =>
      QBAttachmentModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'QBAttachmentModel(url: $url, contextType: $contextType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QBAttachmentModel &&
        other.url == url &&
        other.contextType == contextType;
  }

  @override
  int get hashCode => url.hashCode ^ contextType.hashCode;
}
