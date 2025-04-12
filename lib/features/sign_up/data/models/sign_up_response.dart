import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';

@JsonSerializable()
class SignupResponse {
  String? message;
  String? username;
  String? email;

  SignupResponse({
    this.message,
    this.username,
    this.email, 
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return _$SignupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

