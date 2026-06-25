import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> init() async {
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  String? token = await messaging.getToken();
  log("FCM TOKEN: $token");

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    log("Refreshed FCM Token: $newToken");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log("Foreground Notification: ${message.notification?.title}");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    log("Notification Clicked");
  });
}
}