// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class NotificationModel {
//   final String title;
//   final String body;
//   final String senderUid;
//   final String receiverUid;
//   final DateTime timestamp;
//
//   NotificationModel({
//     required this.title,
//     required this.body,
//     required this.senderUid,
//     required this.receiverUid,
//     required this.timestamp,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'title': title,
//     'body': body,
//     'sender_uid': senderUid,
//     'receiver_uid': receiverUid,
//     'timestamp': timestamp.toIso8601String(),
//   };
// }
//
// // 3. إنشاء خدمة الإشعارات
// class NotificationService {
//   final SupabaseClient supabase;
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   NotificationService(this.supabase);
//
//   // تهيئة FCM
//   Future<void> initNotifications() async {
//
//     // طلب إذن الإشعارات
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // الحصول على FCM token
//     String? token = await _fcm.getToken();
//     if (token != null) {
//       // تخزين الـ token في Supabase
//       await supabase.from('user_tokens').upsert({
//         'user_id': supabase.auth.currentUser!.id,
//         'fcm_token': token,
//       });
//     }
//   }
//
//   // إرسال إشعار
//   Future<void> sendNotification({
//     required String title,
//     required String body,
//     required String adminUid,
//   }) async {
//     final currentUser = supabase.auth.currentUser;
//     if (currentUser == null) return;
//
//     // إنشاء الإشعار
//     final notification = NotificationModel(
//       title: title,
//       body: body,
//       senderUid: currentUser.id,
//       receiverUid: adminUid,
//       timestamp: DateTime.now(),
//     );
//
//     // حفظ الإشعار في Supabase
//     await supabase.from('notifications').insert(notification.toJson());
//
//     // الحصول على token الخاص بالـ admin
//     final adminToken = await supabase
//         .from('user_tokens')
//         .select('fcm_token')
//         .eq('user_id', adminUid)
//         .single();
//
//     // إرسال الإشعار عبر Cloud Function في Supabase
//     await supabase.functions.invoke('pushNotification',
//       body: {
//         'token': adminToken['fcm_token'],
//         'title': title,
//         'body': body,
//       },
//     );
//   }
// }
//
//
//
// // import 'package:alqaysar_rates/core/config/supabase/supabase_client.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// //
// // class NotificationService {
// //   static const String backendUrl = 'https://skvflslnqzgxihhocwrs.supabase.co/functions/v1/pushNotification';
// //
// //   static Future<void> sendNotification({
// //     required String userId,
// //     required String title,
// //     required String message,
// //   }) async {
// //     try {
// //       final payload = {
// //         'type': 'INSERT',
// //         'table': 'users',
// //         'record': {
// //           'id': "56ba3a93-df99-437f-a266-ae1f720c279b",
// //           'title': title,
// //           'message': message,
// //         },
// //       };
// //
// //       final response = await http.post(
// //         Uri.parse(backendUrl),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer ${SupabaseClientProvider.SUPABASE_ANON_KEY}',
// //         },
// //         body: jsonEncode(payload),
// //       );
// //
// //       // Check the response status code
// //       if (response.statusCode == 200) {
// //         print('Notification sent successfully!');
// //       } else {
// //         print('Failed to send notification: ${response.body}');
// //       }
// //     } catch (e) {
// //       print('Error sending notification: $e');
// //     }
// //   }
// // }
// //
// //
// //
// // // import 'package:alqaysar_rates/features/data/local/app_prefs.dart';
// // // import 'package:googleapis_auth/auth_io.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // //
// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:logger/logger.dart';
// // // import '../../../service_locator.dart';
// // // import 'local_notifications_service.dart';
// // //
// // // class PushNotificationService {
// // //   static FirebaseMessaging messaging = FirebaseMessaging.instance;
// // //
// // //   /// Initialize Firebase Messaging and configure listeners
// // //   static Future<void> init() async {
// // //     try {
// // //       // Request notification permissions
// // //       await messaging.requestPermission(
// // //         alert: true,
// // //         badge: true,
// // //         sound: true,
// // //       );
// // //
// // //       // Retrieve FCM token for this device
// // //       String? token = await messaging.getToken();
// // //       sl<AppPrefs>().setString("token", token ?? "");
// // //       if (token != null) {
// // //         Logger().i("FCM Token: $token");
// // //       } else {
// // //         Logger().w("FCM Token is null");
// // //       }
// // //
// // //       // Configure background message handler
// // //       FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
// // //
// // //       // Configure foreground message handler
// // //       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// // //         if (message.notification != null) {
// // //           // Show local notification when app is in foreground
// // //           LocalNotificationService.showBasicNotification(message);
// // //           Logger().i("Message received: ${message.notification?.title}");
// // //         }
// // //       });
// // //     } catch (e) {
// // //       Logger().e("Error during Firebase initialization: $e");
// // //     }
// // //   }
// // //
// // //   /// Background message handler
// // //   static Future<void> handleBackgroundMessage(RemoteMessage message) async {
// // //     try {
// // //       await Firebase.initializeApp();
// // //       Logger().i("Background message received: ${message.notification?.title}");
// // //       // Handle background notification here if needed
// // //     } catch (e) {
// // //       Logger().e("Error in background message handler: $e");
// // //     }
// // //   }
// // //
// // //   /// Get Access Token using OAuth 2.0
// // //   static Future<String> getAccessToken() async {
// // //     final clientId = ClientId(
// // //       '312100610811-fbs1oeemj2b1b66926ueq0avpcnn669u.apps.googleusercontent.com',
// // //       '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',
// // //     );
// // //     final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
// // //
// // //     // Prompt user to authenticate
// // //     void prompt(String url) {
// // //       print('Please visit the following URL to authenticate:');
// // //       print(url);
// // //     }
// // //
// // //     try {
// // //       // Start OAuth 2.0 authentication to get access token
// // //       final authClient = await clientViaUserConsent(clientId, scopes, prompt);
// // //
// // //       // Return the access token
// // //       final credentials = authClient.credentials;
// // //       return credentials.accessToken.data;
// // //     } catch (e) {
// // //       Logger().e("Error getting access token: $e");
// // //       rethrow;
// // //     }
// // //   }
// // //
// // //   /// Send push notification to a device
// // //   static Future<void> sendNotification(String token) async {
// // //     try {
// // //       // Get the access token using OAuth 2.0
// // //       final accessToken = await getAccessToken();
// // //       const String url =
// // //           'https://fcm.googleapis.com/v1/projects/alqaysar-22f21/messages:send';
// // //
// // //       // Send push notification via Firebase Cloud Messaging API
// // //       final response = await http.post(
// // //         Uri.parse(url),
// // //         headers: {
// // //           'Authorization': 'Bearer $accessToken',
// // //           'Content-Type': 'application/json',
// // //         },
// // //         body: json.encode({
// // //           "message": {
// // //             "token": token,
// // //             "notification": {
// // //               "title": "عنوان الإشعار",
// // //               "body": "محتوى الإشعار",
// // //             },
// // //             "android": {
// // //               "priority": "high",
// // //             }
// // //           }
// // //         }),
// // //       );
// // //
// // //       if (response.statusCode == 200) {
// // //         Logger().i('Notification sent successfully!');
// // //       } else {
// // //         Logger().e('Failed to send notification: ${response.statusCode}');
// // //       }
// // //     } catch (e) {
// // //       Logger().e("Error sending notification: $e");
// // //     }
// // //   }
// // // }
