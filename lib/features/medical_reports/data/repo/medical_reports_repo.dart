import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';

class MedicalReportsRepo {
  final ApiService _apiServices;

  MedicalReportsRepo(this._apiServices);

  Future<ApiResult<MedicalReportsResponseModel>> getMyMedicalReports() async {
    try {
      final response = await _apiServices.getMyMedicalReports();
      return ApiResult.success(response);
    } 
    catch (error) {
      print('Error fetching medical reports repo: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}