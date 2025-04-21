import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/hospitals/data/apis/hospital_api_services.dart';
import 'package:healthstack/features/hospitals/data/models/hospitals_response_model.dart';

class HospitalRepo {
  final HospitalApiServices _hospitalApiServices;
  
  HospitalRepo(this._hospitalApiServices);

  // Fetches Hospital data from the API
  Future<ApiResult<List<HospitalData>>> getHospitalList() async {
    try {
      final response = await _hospitalApiServices.getHospitalList();
      return ApiResult.success(response);
    } 
    catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}