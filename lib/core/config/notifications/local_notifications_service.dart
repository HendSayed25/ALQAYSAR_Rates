import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
  StreamController();

  /// Callback when notification is tapped
  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
    // Navigate to specific screen or take action
  }

  /// Initialize the notification service
  static Future<void> init() async {
    try {
      InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      );
      await flutterLocalNotificationsPlugin.initialize(
        settings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap,
      );
    } catch (e) {
      Logger().e("Error initializing local notifications: $e");
    }
  }

  /// Show basic notification
  static void showBasicNotification(RemoteMessage message) async {
    try {
      if (message.notification != null) {
        AndroidNotificationDetails android = const AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );
        NotificationDetails details = NotificationDetails(
          android: android,
        );
        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          details,
        );
      }
    } catch (e) {
      Logger().e("Error showing notification: $e");
    }
  }
}
