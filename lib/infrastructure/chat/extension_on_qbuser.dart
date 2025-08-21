import 'package:quickblox_sdk/models/qb_user.dart';

class QBUserHelper {
  // Convert QBUser instance to JSON
  static Map<String, dynamic> toJson(QBUser user) {
    return {
      'id': user.id,
      'fullName': user.fullName,
      'email': user.email,
      'login': user.login,
      'phone': user.phone,
      'website': user.website,
      'lastRequestAt': user.lastRequestAt?.toString(),
      'externalId': user.externalId,
      'facebookId': user.facebookId,
      'twitterId': user.twitterId,
      // 'twitterDigitsId': user.twitterDigitsId,
      'blobId': user.blobId,
      'customData': user.customData,
      'tags': user.tags,
    };
  }

  // Create QBUser instance from JSON
  static QBUser fromJson(Map<String, dynamic> json) {
    return QBUser()
      ..id = json['id'] as int?
      ..fullName = json['fullName'] as String?
      ..email = json['email'] as String?
      ..login = json['login'] as String?
      ..phone = json['phone'] as String?
      ..website = json['website'] as String?
      ..lastRequestAt = (json['lastRequestAt'] != null
          ? DateTime.parse(json['lastRequestAt'] as String)
          : null) as String?
      ..externalId = json['externalId'] as String?
      ..facebookId = json['facebookId'] as String?
      ..twitterId = json['twitterId'] as String?
     
      ..blobId = json['blobId'] as int?
      ..customData = json['customData'] as String?
      ..tags = (json['tags'] as List<dynamic>?)
          ?.map((tag) => tag as String)
          .toList();
  }
}
