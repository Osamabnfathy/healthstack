import 'package:json_annotation/json_annotation.dart';
part 'forget_password_request_body.g.dart';

@JsonSerializable()
class ForgetPasswordRequestBody{
  final String email;

  ForgetPasswordRequestBody({required this.email});

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestBodyToJson(this);
}