import 'package:dio/dio.dart';
import 'package:healthstack/core/helpers/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:healthstack/core/helpers/shared_pref_helper.dart';


class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    String? userToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': userToken != null && userToken.isNotEmpty ? 'Bearer $userToken' : '',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String acessToken) {
    dio?.options.headers['Authorization'] = 'Bearer $acessToken';
  }

  static void addDioInterceptor() {    
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
