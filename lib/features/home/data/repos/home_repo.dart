import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/features/home/data/apis/home_api_services.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';


class HomeRepo {
  final HomeApiServices _homeApiServices;
  
  HomeRepo(this._homeApiServices);

  // Fetches home data from the API
  Future<ApiResult<List<SpecializationsResponseModel>>> getSpecializations() async {
    try {
      final response = await _homeApiServices.getSpecializations();
      return ApiResult.success(response);
    } 
    catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  
  Future<ApiResult<List<DoctorsResponseModel>>> getDoctors() async {
    try {
      final response = await _homeApiServices.getDoctors();
      return ApiResult.success(response);
    } 
    catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  
  Future<ApiResult<List<HospitalsResponseModel>>> getHospitals() async {
    try {
      final response = await _homeApiServices.getHospitals();
      return ApiResult.success(response);
    } 
    catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}