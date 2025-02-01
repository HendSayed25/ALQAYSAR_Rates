import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/resource/colors_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/app.dart';
import 'core/config/supabase/supabase_client.dart';
import 'core/helper/language/language_helper.dart';
import 'features/data/local/app_prefs.dart';

import 'service_locator.dart';

late final WidgetsBinding engine;

void main() async {
  engine = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        statusBarColor: AppColors.backgroundColor[0]),
  );

  await Future.wait([
    SupabaseClientProvider.initialize(),
    EasyLocalization.ensureInitialized(),
    setupServiceLocator(),
  ]);

  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("5e042f07-a3df-4c5b-b10d-9aee5845dd73");
  OneSignal.Notifications.requestPermission(true).then((granted) {
    fetchPlayerId();
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
  await Future.delayed(Duration(seconds: 5)); //delay for response
  String? playerId = await OneSignal.User.pushSubscription.id;
  Logger().i("Fetched Player ID: $playerId");

  if (playerId != null) {
    sl<AppPrefs>().setString("token", playerId);
  } else {
    Logger().i("Player ID is still null. Waiting...");
  }
}