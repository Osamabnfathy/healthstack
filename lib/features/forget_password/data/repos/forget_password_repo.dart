import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/forget_password/data/models/forget_password_request_body.dart';
import 'package:healthstack/features/forget_password/data/models/forget_password_response.dart';

class ForgetPasswordRepo {
  final ApiService _apiService;

  ForgetPasswordRepo(this._apiService);

  // Corrected method name
  Future<ApiResult<ForgetPasswordResponse>> requestPasswordReset(
      ForgetPasswordRequestBody forgetPasswordRequestBody) async {
        try {
          // Corrected ApiService method call
          final response = await _apiService.requestPasswordReset(forgetPasswordRequestBody);
    
          // Optional: If using Option A for Response Model, you could add specific checks here
          // if (response.error != null) {
          //   // Handle API-level logical errors returned in the response body if needed
          //   // This depends on how your API signals errors (HTTP status vs. JSON body)
          //   // Often, ErrorHandler handles HTTP errors, and this check handles 200 OK with error messages.
          //   return ApiResult.failure(ErrorHandler.handle(response.error)); // Or create a specific ApiErrorModel
          // }
    
          return ApiResult.success(response);
        } catch (error) {
          // Assumes ErrorHandler correctly parses network/server errors (like 404, 500)
          // and potentially JSON errors (like the 'error' key if configured to do so)
          return ApiResult.failure(ErrorHandler.handle(error));
        }
      }
}