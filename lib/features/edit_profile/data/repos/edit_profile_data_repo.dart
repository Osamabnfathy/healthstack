import 'dart:io';
import 'package:dio/dio.dart';
import 'package:healthstack/core/networking/api_constants.dart';
import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/core/networking/dio_factory.dart';
import 'package:healthstack/features/edit_profile/data/models/edit_profile_data_request_body.dart';
import 'package:healthstack/features/edit_profile/data/models/edit_profile_data_response_body.dart';

class EditProfileDataRepo {
  final ApiService _apiService;

  EditProfileDataRepo(this._apiService);

  Future<ApiResult<EditProfileDataResponseBody>> editProfile(
      EditProfileDataRequestBody editProfileDataRequestBody) async {
    try {
      final response = await _apiService.editProfile(editProfileDataRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  
   Future<ApiResult<String>> updateProfilePhoto(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'featured_image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final dio = DioFactory.getDio();
      final response = await dio.put(
        ApiConstants.apiBaseUrl + ApiConstants.patientProfile, 
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return ApiResult.success(response.data['featured_image'] ?? '');
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
