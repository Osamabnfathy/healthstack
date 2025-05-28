import 'package:json_annotation/json_annotation.dart';
part 'change_password_request_body.g.dart';

@JsonSerializable()
class ChangePasswordRequestBody {
  @JsonKey(name: 'old_password')
  final String oldPassword;
  @JsonKey(name: 'new_password')
  final String newPassword;
  @JsonKey(name: 'confirm_password')
  final String confirmPassword;


  ChangePasswordRequestBody({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordRequestBodyToJson(this);
}