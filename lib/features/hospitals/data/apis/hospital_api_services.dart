import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:healthstack/core/networking/api_constants.dart';
import 'package:healthstack/features/hospitals/data/models/hospitals_response_model.dart';

part 'hospital_api_services.g.dart';

@RestApi(baseUrl : ApiConstants.apiBaseUrl)
abstract class HospitalApiServices {
  factory HospitalApiServices(Dio dio) = _HospitalApiServices;
  
  @GET(ApiConstants.hospitals)
  Future<List<HospitalData>> getHospitalList();
}