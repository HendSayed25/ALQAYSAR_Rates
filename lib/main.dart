import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/resource/colors_manager.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/app.dart';
import 'core/config/supabase/supabase_client.dart';
import 'core/helper/language/language_helper.dart';
import 'features/data/local/app_prefs.dart';

// import 'firebase_options.dart';
import 'service_locator.dart';

late final WidgetsBinding engine;

void main() async {
  engine = WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        statusBarColor: AppColors.backgroundColor[0]),
  );

  // OneSignal.initialize("f6a7e440-16d2-4005-8ba5-4d1642d87573");
// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission

  await Future.wait([
    SupabaseClientProvider.initialize(),
    // LocalNotificationService.init(),
    EasyLocalization.ensureInitialized(),
    setupServiceLocator(),
  ]);

  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("5e042f07-a3df-4c5b-b10d-9aee5845dd73");
  OneSignal.Notifications.requestPermission(true).then((granted) {
    fetchPlayerId();
  });
  //
  // OneSignal.Notifications.addClickListener((event) {
  //   var data = event.notification.additionalData;
  //
  //   if (data != null) {
  //     Logger().i("Notification Clicked: $data");
  //
  //     String? screen = data["screen"];
  //     int? customerId = data["id"];
  //     String? customerName = data["name"];
  //     if (screen != null && screen.isNotEmpty) {
  //       navigatorKey.currentState?.pushNamed(Routes.commentScreen, arguments: {
  //         "customerName": customerName,
  //         "customerId": customerId,
  //       });
  //     } else {
  //       navigatorKey.currentState?.pushNamed(Routes.homeScreenAdminRoute);
  //     }
  //   } else {
  //     Logger().w("No additional data found in notification");
  //   }
  // });
  // OneSignal.Notifications.addClickListener((event){
  //   handleNotificationClick(event.notification.additionalData);
  // });

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguages.locals,
      path: AppLanguages.translationsPath,
      fallbackLocale: AppLanguages.fallBackLocal,
      child: const MyApp(),
    ),
  );


}

//get Token when app run
void fetchPlayerId() async {
  await Future.delayed(Duration(seconds: 5)); //delay for response
  String? playerId = await OneSignal.User.pushSubscription.id;
  Logger().i("Fetched Player ID: $playerId");

  if (playerId != null) {
    sl<AppPrefs>().setString("token", playerId);
  } else {
    Logger().i("Player ID is still null. Waiting...");
  }
}
// void handleNotificationClick(Map<String, dynamic>? data) {
//   if (data != null) {
//     Logger().i("Notification Clicked: $data");
//
//     String? screen = data["screen"];
//     int? customerId = data["id"];
//     String? customerName = data["name"];
//
//     if (screen != null && screen.isNotEmpty) {
//       //save data
//       sl<AppPrefs>().setString("pending_screen", screen);
//       sl<AppPrefs>().setInt("pending_customerId", customerId ?? 0);
//       sl<AppPrefs>().setString("pending_customerName", customerName ?? "");
//
//     }
//   }
// }
// void checkForPendingNotification() {
//   Future.delayed(Duration(seconds: 1), () {
//     String? screen = sl<AppPrefs>().getString("pending_screen");
//     int customerId = sl<AppPrefs>().getInt("pending_customerId") ?? 0;
//     String? customerName = sl<AppPrefs>().getString("pending_customerName");
//
//     if (screen != null && screen.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         navigatorKey.currentState?.pushNamed(screen, arguments: {
//           "customerName": customerName,
//           "customerId": customerId,
//         });
//         //delete the data after going to it
//         sl<AppPrefs>().setString("pending_screen", "");
//       });
//     }
//   });
// }