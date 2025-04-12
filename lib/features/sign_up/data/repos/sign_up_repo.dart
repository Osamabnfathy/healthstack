import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/sign_up/data/models/sign_up_response.dart';
import 'package:healthstack/features/sign_up/data/models/sign_up_request_body.dart';


class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.signup(signupRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}