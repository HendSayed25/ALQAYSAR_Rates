import 'package:alqaysar_rates/features/ui/pages/rate_screen/rate_screen_user.dart';
import 'package:alqaysar_rates/features/ui/pages/search_screen/search_screen.dart';
import 'package:alqaysar_rates/features/ui/cubit/customer_cubit.dart';
import 'package:alqaysar_rates/features/ui/pages/user_over_view/user_overView_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/ui/cubit/login_cubit.dart';
import '../../../features/ui/pages/home_admin_screen/home_admin_screen.dart';
import '../../../features/ui/pages/home_user_screen/home_screen.dart';
import '../../../features/ui/pages/login_screen/login_screen.dart';
import '../../../features/ui/pages/show_all_for_admin_screen/show_all_for_admin.dart';
import '../../../service_locator.dart';
import 'route_constants.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splashScreenRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => const SplashScreen(),
      //   );

      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
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
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>(),
            child: const HomeAdminScreen(),
          ),
        );

      case Routes.showAllForAdminRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>(),
            child: const ShowAllForAdminScreen(),
          ),
        );

      case Routes.searchScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<CustomerCubit>()..fetchCustomers(),
            child: const SearchScreen(),
          ),
        );
      case Routes.userOverviewScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const UserOverViewScreen(),
        );
      case Routes.rateScreenUserRoute:
        return MaterialPageRoute(
          builder: (context) => const RateScreenUser(),
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
