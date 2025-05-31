import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';

class MyAppointmentsRepo {
  final ApiService _apiServices;

  MyAppointmentsRepo(this._apiServices);

  Future<ApiResult<List<MyAppointmentResponseModel>>> getMyAppointments() async {
    try {
      final response = await _apiServices.getMyAppointments();
      return ApiResult.success(response);
    } 
    catch (error) {
      print('Error fetching appointments repo: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}