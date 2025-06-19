import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:healthstack/core/networking/api_constants.dart';
import 'package:healthstack/features/login/data/models/login_response.dart';
import 'package:healthstack/features/sign_up/data/models/sign_up_response.dart';
import 'package:healthstack/features/login/data/models/login_request_body.dart';
import 'package:healthstack/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:healthstack/features/forget_password/data/models/forget_password_response.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';
import 'package:healthstack/features/edit_profile/data/models/edit_profile_data_request_body.dart';
import 'package:healthstack/features/edit_profile/data/models/edit_profile_data_response_body.dart';
import 'package:healthstack/features/change_password/data/models/change_password_request_body.dart';
import 'package:healthstack/features/forget_password/data/models/forget_password_request_body.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';
import 'package:healthstack/features/change_password/data/models/change_password_response_body.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';
import 'package:healthstack/features/book_appointment/data/models/book_appointment_request_model.dart';
import 'package:healthstack/features/book_appointment/data/models/book_appointment_response_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );
  
  @POST(ApiConstants.resetPassword) 
  Future<ForgetPasswordResponse> requestPasswordReset(
    @Body() ForgetPasswordRequestBody forgetPasswordRequestBody,
  );
  
  @POST(ApiConstants.appointments)
  Future<BookAppointmentResponseModel> bookAppointment(
    @Body() BookAppointmentRequestModel bookAppointmentRequestBody,
  );
  
  @PUT(ApiConstants.changePassword)
  Future<ChangePasswordResponseBody> changePassword(
    @Body() ChangePasswordRequestBody changePasswordRequestBody,
  );
  
  @GET(ApiConstants.appointments)
  Future<List<MyAppointmentResponseModel>> getMyAppointments();
  
  @PUT(ApiConstants.patientProfile)
  Future<EditProfileDataResponseBody> editProfile(
    @Body() EditProfileDataRequestBody editProfileDataRequestBody,
  );
  
  @GET(ApiConstants.allPrescriptionsData)
  Future<PrescriptionsResponseModel> getMyPrescriptions();
  
  @GET(ApiConstants.medicalReports)
  Future<MedicalReportsResponseModel> getMyMedicalReports();

  // ========== NEW FCM TOKEN ENDPOINTS ==========
  /// Update FCM token for push notifications
  @POST('/api/fcm-token/') // Adjust the endpoint based on your backend
  Future<Map<String, dynamic>> updateFCMToken(
    @Body() Map<String, String> tokenData, // {"fcm_token": "token_string"}
  );

  /// Delete FCM token (for logout)
  @DELETE('/api/fcm-token/') // Adjust the endpoint based on your backend
  Future<Map<String, dynamic>> deleteFCMToken();
}

/*
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:healthstack/core/networking/api_constants.dart';
import 'package:healthstack/features/login/data/models/login_response.dart';
import 'package:healthstack/features/sign_up/data/models/sign_up_response.dart';
import 'package:healthstack/features/login/data/models/login_request_body.dart';
import 'package:healthstack/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:healthstack/features/forget_password/data/models/forget_password_response.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';
import 'package:healthstack/features/edit_profile/data/models/edit_profile_data_request_body.dart';
import 'package:healthstack/features/edit_profile/data/models/edit_profile_data_response_body.dart';
import 'package:healthstack/features/change_password/data/models/change_password_request_body.dart';
import 'package:healthstack/features/forget_password/data/models/forget_password_request_body.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';
import 'package:healthstack/features/change_password/data/models/change_password_response_body.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';
import 'package:healthstack/features/book_appointment/data/models/book_appointment_request_model.dart';
import 'package:healthstack/features/book_appointment/data/models/book_appointment_response_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );
  
  @POST(ApiConstants.resetPassword) 
  Future<ForgetPasswordResponse> requestPasswordReset(
    @Body() ForgetPasswordRequestBody forgetPasswordRequestBody,
  );
  
  @POST(ApiConstants.appointments)
  Future<BookAppointmentResponseModel> bookAppointment(
    @Body() BookAppointmentRequestModel bookAppointmentRequestBody,
  );
  
  @PUT(ApiConstants.changePassword)
  Future<ChangePasswordResponseBody> changePassword(
    @Body() ChangePasswordRequestBody changePasswordRequestBody,
  );
  
  @GET(ApiConstants.appointments)
  Future<List<MyAppointmentResponseModel>> getMyAppointments();
  
  @PUT(ApiConstants.patientProfile)
  Future<EditProfileDataResponseBody> editProfile(
    @Body() EditProfileDataRequestBody editProfileDataRequestBody,
  );
  
  @GET(ApiConstants.allPrescriptionsData)
  Future<PrescriptionsResponseModel> getMyPrescriptions();
  
  @GET(ApiConstants.medicalReports)
  Future<MedicalReportsResponseModel> getMyMedicalReports();
}
*/