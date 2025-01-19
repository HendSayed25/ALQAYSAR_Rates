import 'package:alqaysar_rates/core/resource/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/config/routes/route_constants.dart';
import '../core/config/routes/router.dart';
import '../core/helper/language/language_helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        initialRoute: Routes.homeScreenAdminRoute
      ),
    );
  }
}