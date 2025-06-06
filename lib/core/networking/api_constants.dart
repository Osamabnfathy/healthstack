class ApiConstants {
  static const String apiBaseUrl = "https://medicare.pythonanywhere.com/api/";

  static const String login = "login/";
  static const String signup = "patient_register/";
  static const String resetPassword = "password_reset/";
  static const String logout = "logout/";
  static const String changePassword = "change_password/";
  static const String hospitals = "hospital/";
  static const String doctors = "doctor/";
  static const String departments = "hospital_department/";
  static const String appointments = "appointment/";
  static const String patientProfile = "patient_profile/";
  static const String medicalReports = "report/";
  static const String allPrescriptionsData = "all_prescription_data/";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
