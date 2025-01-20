import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/app.dart';
import 'core/config/notifications/local_notifications_service.dart';
import 'core/config/notifications/one_signal_service.dart';
import 'core/config/notifications/push_notification_service.dart';
import 'core/config/supabase/supabase_client.dart';
import 'core/helper/language/language_helper.dart';
import 'firebase_options.dart';
import 'service_locator.dart';

late final WidgetsBinding engine;

void main() async {
  engine = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
//   //Remove this method to stop OneSignal Debugging
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//
//   OneSignal.initialize("f6a7e440-16d2-4005-8ba5-4d1642d87573");
// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.Notifications.requestPermission(true);

  await Future.wait([
    SupabaseClientProvider.initialize(),
    LocalNotificationService.init(),
    EasyLocalization.ensureInitialized(),
    setupServiceLocator(),
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguages.locals,
      path: AppLanguages.translationsPath,
      fallbackLocale: AppLanguages.fallBackLocal,
      child: const MyApp(),
    ),
  );
}
