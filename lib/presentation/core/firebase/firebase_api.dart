import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';

import '../../../injectable.dart';
// import 'package:injectable/injectable.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title: ${message.notification?.title}");
  log("Body: ${message.notification?.body}");
  log("Payload: ${message.data}");
}

// @LazySingleton()
class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      "high_imprtance_channel", "High Importance Notifications",
      description: "This channel is used android notifications",
      importance: Importance.defaultImportance);
  final _locaLNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("_________token__________");

    log(settings.authorizationStatus.name);
    log(fcmToken ?? "Empty");
    print("_________token__________");
    initPushNotifications();
    initLocationNotifications();
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    getIt<AppRouter>().push(NotificationRoute(message: message));
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _locaLNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/ic_launcher')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initLocationNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _locaLNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      RemoteMessage remoteMessage =
          mapNotificationResponseToRemoteMessage(payload);

      // Process the RemoteMessage
      handleMessage(remoteMessage);
    });
    final platform = _locaLNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  RemoteMessage mapNotificationResponseToRemoteMessage(
      NotificationResponse response) {
    // Extract data from the payload (assume JSON string for this example)
    final Map<String, dynamic> data = response.payload != null
        ? Map<String, dynamic>.from(response.payload!.split('&').asMap().map(
            (index, element) {
              final keyValue = element.split('=');
              return MapEntry(keyValue[0], keyValue[1]);
            },
          ))
        : {};

    return RemoteMessage(
      data: data,
      notification: RemoteNotification(
        title: data['title'] ?? 'No Title',
        body: data['body'] ?? 'No Body',
      ),
      from: data['from'] ?? 'Unknown Source',
      sentTime: DateTime.now(),
    );
  }
}
