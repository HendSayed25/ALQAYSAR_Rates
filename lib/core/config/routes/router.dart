import 'package:alqaysar_rates/features/ui/pages/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/ui/cubit/login_cubit.dart';
import '../../../features/ui/pages/home_admin_screen/home_admin_screen.dart';
import '../../../features/ui/pages/home_user_screen/home_screen.dart';
import '../../../features/ui/pages/login_screen/login_screen.dart';
import '../../../features/ui/pages/show_all_for_admin/show_all_for_admin.dart';
import '../../../features/ui/pages/splash_screen/splash_screen.dart';
import '../../../service_locator.dart';
import 'route_constants.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => AuthCubit(login: sl()),
            child: LoginScreen(),
          ),
        );

      case Routes.homeScreenUserRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeUserScreen(),
        );

      case Routes.homeScreenAdminRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeAdminScreen(),
        );

      case Routes.showAllForAdminRoute:
        return MaterialPageRoute(
          builder: (context) => const ShowAllForAdminScreen(),
        );
      case Routes.searchScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );


      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(child: Text("No Route Found")),
      ),
    );
  }
}
