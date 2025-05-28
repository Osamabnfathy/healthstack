import 'package:json_annotation/json_annotation.dart';
part 'change_password_response_body.g.dart';

@JsonSerializable()
class ChangePasswordResponseBody {
  String? message;


  ChangePasswordResponseBody({
    this.message,
  });

  factory ChangePasswordResponseBody.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordResponseBodyFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangePasswordResponseBodyToJson(this);
}