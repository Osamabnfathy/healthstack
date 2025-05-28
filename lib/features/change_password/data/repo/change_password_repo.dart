
import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/change_password/data/models/change_password_request_body.dart';
import 'package:healthstack/features/change_password/data/models/change_password_response_body.dart';


class ChangePasswordRepo {
  final ApiService _apiService;

  ChangePasswordRepo(this._apiService);

  Future<ApiResult<ChangePasswordResponseBody>> changePassword(
      ChangePasswordRequestBody changePasswordRequestBody) async {
    try {
      final response = await _apiService.changePassword(changePasswordRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}