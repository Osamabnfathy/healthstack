import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/features/change_password/logic/change_password_cubit.dart';
import 'package:healthstack/features/change_password/ui/change_password_screen.dart';
import 'package:healthstack/features/home/ui/home_screen.dart';
import 'package:healthstack/core/di/dependency_injection.dart';
import 'package:healthstack/features/login/ui/login_screen.dart';
import 'package:healthstack/features/doctors/ui/doctors_screen.dart';
import 'package:healthstack/features/profile/ui/profile_screen.dart';
import 'package:healthstack/features/sign_up/ui/sign_up_screen.dart';
import 'package:healthstack/features/sign_up/logic/sign_up_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/onboarding/onboarding_screen.dart';
import 'package:healthstack/features/login/logic/cubit/login_cubit.dart';
import 'package:healthstack/features/hospitals/ui/hospitals_screen.dart';
import 'package:healthstack/features/appointment/ui/apointment_screen.dart';
import 'package:healthstack/features/medical_record/ui/medical_record_screen.dart';
import 'package:healthstack/features/forget_password/ui/forget_password_screen.dart';
import 'package:healthstack/features/book_appointment/ui/first_appointment_screen.dart';
import 'package:healthstack/features/book_appointment/ui/second_appointment_screen.dart';
import 'package:healthstack/features/book_appointment/logic/book_appointment_cubit.dart';
import 'package:healthstack/features/book_appointment/ui/third_booking_confirmation_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
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
         
         
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(getIt())..getDoctorsList()..getHospitalList()..getDepartments(),
            child: const HomeScreen(),
          ),
        );
      
    
      case Routes.doctorsScreen:
        if (arguments is HomeCubit) {
          final homeCubitInstance = arguments;
          return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: homeCubitInstance, 
              child: const DoctorsScreen(), 
            ),
          );
        } 
        else {
          print("ERROR: Incorrect arguments passed to Doctors Screen route.");
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: Center(child: Text("Error: Missing data for Doctors screen.")))
          );
        }
      
      
      case Routes.hospitalsScreen:
        if (arguments is HomeCubit) {
          final homeCubitInstance = arguments;
          return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: homeCubitInstance, 
              child: const HospitalsScreen(), 
            ),
          );
        } 
        else {
          print("ERROR: Incorrect arguments passed to Hospitals Screen route.");
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: Center(child: Text("Error: Missing data for Hospitals screen.")))
          );
        }

      
      case Routes.firstAppointmentScreen:
        final Map<String, dynamic>? screenArgs = arguments is Map<String, dynamic> ? arguments : null;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<BookAppointmentCubit>(),
            child: FirstAppointmentScreen(
              doctorId: screenArgs?['doctorId'],
              doctorName: screenArgs?['doctorName'],
              doctorImage: screenArgs?['doctorImage'],
              hospitalName: screenArgs?['hospitalName'],
              departmentName: screenArgs?['departmentName'],
              visitingHour: screenArgs?['visitingHour'],
            ),
          ),
        );


      case Routes.secondAppointmentScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final cubit = args['cubit'] as BookAppointmentCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,  
            child: SecondAppointmentScreen(
              selectedDate: args['selectedDate'],
              selectedTime: args['selectedTime'],
              selectedAppointmentType: args['selectedAppointmentType'],
              doctorId: args['doctorId'],
              doctorName: args['doctorName'],
              doctorImage: args['doctorImage'],
              hospitalName: args['hospitalName'],
              departmentName: args['departmentName'],
            ),
          ),
        );
         
      
      case Routes.summaryScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SummaryScreen(
            bookingInfoData: args['bookingInfo'],
            doctorInfoData: args['doctorInfo'],
          )
        );  
        
        
      case Routes.changePasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ChangePasswordCubit>(),
            child: const ChangePasswordScreen(),
          ),
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
      
      
      default:
        return null;
    }
  }
}
