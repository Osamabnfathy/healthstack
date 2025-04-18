import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/features/home/ui/home_screen.dart';
import 'package:healthstack/core/di/dependency_injection.dart';
import 'package:healthstack/features/login/ui/login_screen.dart';
import 'package:healthstack/features/doctors/ui/doctors_screen.dart';
import 'package:healthstack/features/profile/ui/profile_screen.dart';
import 'package:healthstack/features/sign_up/ui/sign_up_screen.dart';
import 'package:healthstack/features/sign_up/logic/sign_up_cubit.dart';
import 'package:healthstack/features/onboarding/onboarding_screen.dart';
import 'package:healthstack/features/login/logic/cubit/login_cubit.dart';
import 'package:healthstack/features/hospitals/ui/hospitals_screen.dart';
import 'package:healthstack/features/appointment/ui/apointment_screen.dart';
import 'package:healthstack/features/medical_record/ui/medical_record_screen.dart';
import 'package:healthstack/features/forget_password/ui/forget_password_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          // ignore: deprecated_member_use
          builder: (_) => WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop(); // Exit the app when back is pressed on OnBoarding
              return false;
            },
            child: const OnBoardingScreen(),
          ),
        );
        
        
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
         
         
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
         
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
        
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );
        
      case Routes.appointmentScreen:
        return MaterialPageRoute(
          builder: (_) => const AppointmentScreen(),
      );
        
      case Routes.medicalRecordScreen:
        return MaterialPageRoute(
          builder: (_) => const MedicalRecordScreen(),
      );
      
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
      );
      
      case Routes.doctorsScreen:
        return MaterialPageRoute(
          builder: (_) => const DoctorsScreen(),
      );
      
      case Routes.hospitalsScreen:
        return MaterialPageRoute(
          builder: (_) => const HospitalsScreen(),
      );
      
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
