import 'package:alqaysar_rates/core/config/supabase/supabase_client.dart';
import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/config/routes/route_constants.dart';
import '../core/config/routes/router.dart';
import '../core/helper/language/language_helper.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initializeFCM();
    _setupTokenRefreshListener();
    _setupMessageListener();
  }

  Future<void> _initializeFCM() async {
    await FirebaseMessaging.instance.requestPermission();

    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      await _updateFcmToken(fcmToken);
    }
  }

  void _setupTokenRefreshListener() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _updateFcmToken(newToken);
    });
  }

  void _setupMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${notification.title}: ${notification.body}'),
          ),
        );
      }
    });
  }

  Future<void> _updateFcmToken(String fcmToken) async {
    final userId = SupabaseClientProvider.client.auth.currentUser?.id;
    if (userId != null) {
      await SupabaseClientProvider.client.from('users').upsert({
        'uid': userId,
        'token': fcmToken,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLanguages.init(context);//get the language of app when start
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName.tr(),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: ThemeData(fontFamily: AppLanguages.getPrimaryFont(context)),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.userOverviewScreenRoute,
      ),
    );
  }
}