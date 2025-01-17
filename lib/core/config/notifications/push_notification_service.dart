import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class PushNotificationService {
  static const String _channelId = 'channel_id';
  static const String _channelName = 'channel_name';
  static const String _channelDescription = 'channel_description';

  static const String _defaultSound = 'default_sound';

  static const String _initialRoute = '/';

  static const String _onMessage = 'onMessage';
  static const String _onMessageOpenedApp = 'onMessageOpenedApp';
  static const String _onResume = 'onResume';
  static const String _onLaunch = 'onLaunch';

  static const String _onBackgroundMessage = 'onBackgroundMessage';

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await messaging.getToken();
    Logger().i(token ?? "null");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
  static Future<void> handleBackgroundMessage(RemoteMessage message)async {
    Firebase.initializeApp();

  }
}
