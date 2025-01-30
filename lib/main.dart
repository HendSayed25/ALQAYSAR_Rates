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

  OneSignal.Notifications.addClickListener((event) {
    var data = event.notification.additionalData;

    if (data != null) {
      Logger().i("Notification Clicked: $data");

      String? screen = data["screen"];
      int? customerId = data["id"];
      String? customerName = data["name"];
      if (screen != null && screen.isNotEmpty) {
        navigatorKey.currentState?.pushNamed(Routes.commentScreen, arguments: {
          "customerName": customerName,
          "customerId": customerId,
        });
      } else {
        navigatorKey.currentState?.pushNamed(Routes.homeScreenAdminRoute);
      }
    } else {
      Logger().w("No additional data found in notification");
    }
  });

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
  String? playerId = await OneSignal.User.pushSubscription.id;
  print("Fetched Player ID: $playerId");

  if (playerId != null) {
    sl<AppPrefs>().setString("token", playerId);
  } else {
    print("Player ID is still null. Waiting...");
  }
}
