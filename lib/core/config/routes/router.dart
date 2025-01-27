import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/ui/cubit/customer_cubit.dart';
import '../../../features/ui/cubit/login_cubit.dart';
import '../../../features/ui/pages/comments/comments_screen.dart';
import '../../../features/ui/pages/home/show_all_screen.dart';
import '../../../features/ui/pages/home_admin/home_admin_screen.dart';
import '../../../features/ui/pages/login/login_screen.dart';
import '../../../features/ui/pages/negative_rate/negative_rate_screen.dart';
import '../../../features/ui/pages/rate/rate_screen_user.dart';
import '../../../features/ui/pages/search/search_screen.dart';
import '../../../features/ui/pages/splash/splash_screen.dart';
import '../../../features/ui/pages/user_over_view/user_overView_screen.dart';
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
          builder: (context) => BlocProvider<AuthCubit>(
            create: (_) => AuthCubit(login: sl()),
            child: LoginScreen(),
          ),
        );

      case Routes.homeScreenAdminRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>(),
            child: const HomeAdminScreen(),
          ),
        );

      case Routes.showAllRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>()..fetchCustomers(),
            child: const ShowAllScreen(),
          ),
        );

      case Routes.searchScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>()..fetchCustomers(),
            child: const SearchScreen(),
          ),
        );

      case Routes.userOverviewScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>(),
            child: const UserOverViewScreen(),
          ),
        );

      case Routes.rateScreenUserRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>(),
            child: RateScreenUser(),
          ),
        );

      case Routes.commentScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CustomerCubit>(
            create: (_) => sl<CustomerCubit>()..fetchCustomerRates(args["customerId"]),
            child: CommentsScreen(data: args),
          ),
        );

      case Routes.negativeScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<CustomerCubit>(
                  create: (_) => sl<CustomerCubit>(),
                  child: NegativeScreen(),
                ));
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
