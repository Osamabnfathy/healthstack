import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:healthstack/core/networking/api_constants.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

part 'home_api_services.g.dart';

@RestApi(baseUrl : ApiConstants.apiBaseUrl)
abstract class HomeApiServices {
  factory HomeApiServices(Dio dio) = _HomeApiServices;
  
  @GET(ApiConstants.specializations)
  Future<List<SpecializationsResponseModel>> getSpecializations();
  
  @GET(ApiConstants.doctors)
  Future<List<DoctorsResponseModel>> getDoctors();
  
  @GET(ApiConstants.hospitals)
  Future<List<HospitalsResponseModel>> getHospitals();
}