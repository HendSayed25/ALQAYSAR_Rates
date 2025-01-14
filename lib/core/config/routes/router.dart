import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/domain/usecases/login_usecase.dart';
import '../../../features/presentation/cubit/login_cubit.dart';
import '../../../features/presentation/pages/login_screen/login_screen.dart';
import '../../../features/presentation/pages/splash_screen/splash_screen.dart';
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
            create: (_) => LoginCubit(sl<LoginUseCase>()),
            child: const LoginScreen(),
          ),
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
