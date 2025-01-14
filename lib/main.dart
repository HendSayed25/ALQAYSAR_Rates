import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/routes/route_constants.dart';
import 'core/config/routes/router.dart' as router;
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black
      )
  );


  await setupServiceLocator();

  runApp(const MyApp());
}

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
        onGenerateRoute: router.RouteGenerator.getRoute,
        initialRoute: Routes.splashScreenRoute,
      ),
    );
  }
}
