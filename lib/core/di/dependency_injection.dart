import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/login/data/repos/login_repo.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import 'package:healthstack/core/networking/dio_factory.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/features/home/data/repos/home_repo.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/sign_up/logic/sign_up_cubit.dart';
import 'package:healthstack/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:healthstack/features/home/data/apis/home_api_services.dart';
import 'package:healthstack/features/change_password/logic/change_password_cubit.dart';
import 'package:healthstack/features/book_appointment/logic/book_appointment_cubit.dart';
import 'package:healthstack/features/change_password/data/repo/change_password_repo.dart';
import 'package:healthstack/features/forget_password/data/repos/forget_password_repo.dart';
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:healthstack/features/book_appointment/data/repos/book_appointment_repo.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // Reset Password
  getIt.registerLazySingleton<ForgetPasswordRepo>(() =>ForgetPasswordRepo(getIt()));
  getIt.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt()));  
  
  // Home
  getIt.registerLazySingleton<HomeApiServices>(() => HomeApiServices(dio));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt<HomeApiServices>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
  
  // Book Appointment
  getIt.registerLazySingleton<BookAppointmentRepo>(() => BookAppointmentRepo(getIt()));
  getIt.registerFactory<BookAppointmentCubit>(() => BookAppointmentCubit(getIt()));
  
  // Change Password
  getIt.registerLazySingleton<ChangePasswordRepo>(() => ChangePasswordRepo(getIt()));
  getIt.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(getIt()));
}
