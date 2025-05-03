import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_service.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/book_appointment/data/models/book_appointment_request_model.dart';
import 'package:healthstack/features/book_appointment/data/models/book_appointment_response_model.dart';

class BookAppointmentRepo {
  final ApiService _apiService;

  BookAppointmentRepo(this._apiService);

  Future<ApiResult<BookAppointmentResponseModel>> bookAppointment(
      BookAppointmentRequestModel bookAppointmentRequestModel) async{
    try {
      final response = await _apiService.bookAppointment(bookAppointmentRequestModel);
      return ApiResult.success(response);
    }
    catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}