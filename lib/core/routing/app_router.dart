import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/health_stack_app.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/features/login/ui/login_screen.dart';
import 'package:healthstack/features/onboarding/onboarding_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
        
        
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      // case Routes.loginScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: const LoginScreen(),
      //     ),
      //   );
         
      // case Routes.homeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeScreen(),
      //   );
         
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("no route define for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
