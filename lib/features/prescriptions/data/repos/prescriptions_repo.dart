import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';

class PrescriptionsRepo {
  final ApiService _apiServices;

  PrescriptionsRepo(this._apiServices);

  Future<ApiResult<PrescriptionsResponseModel>> getMyPrescriptions() async {
    try {
      final response = await _apiServices.getMyPrescriptions();
      return ApiResult.success(response);
    } 
    catch (error) {
      print('Error fetching prescriptions repo: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}