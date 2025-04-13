import 'package:json_annotation/json_annotation.dart';
part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  String? message;
  String? error;

  ForgetPasswordResponse({this.message, this.error});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);
  
  // Helper to know if the response indicates success based *only* on the model fields
  bool get isSuccess => message != null && error == null;
}

