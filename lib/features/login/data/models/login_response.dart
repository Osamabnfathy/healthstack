import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? refresh;
  String? access;
  @JsonKey(name: 'user')
  UserData? userData;

  LoginResponse({this.refresh, this.access, this.userData,});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  int? id;
  @JsonKey(name: 'username')
  String? userName;
  String? email;
  @JsonKey(name: 'is_doctor')
  bool? isDoctor;

  UserData({this.id, this.userName, this.email, this.isDoctor});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
