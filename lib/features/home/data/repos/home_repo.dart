import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/features/home/data/apis/home_api_services.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';

class HomeRepo {
  final HomeApiServices _homeApiServices;
  
  HomeRepo(this._homeApiServices);

  // Fetches home data from the API
  Future<ApiResult<HospitalsResponseModel>> getHospitalList() async {
    try {
      final response = await _homeApiServices.getHospitalList();
      return ApiResult.success(response);
    } 
    catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  
  Future<ApiResult<DoctorsResponseModel>> getDoctorList() async {
    try {
      final response = await _homeApiServices.getDoctorList();
      return ApiResult.success(response);
    } 
    catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}