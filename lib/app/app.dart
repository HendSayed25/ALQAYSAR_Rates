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
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ALQYSAR',
        locale: context.locale,
        supportedLocales: AppLanguages.locals,
        localizationsDelegates: [EasyLocalization.of(context)!.delegate],
        theme: ThemeData(fontFamily: AppLanguages.getPrimaryFont(context)),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.homeScreenUserRoute,
      ),
    );
  }
}