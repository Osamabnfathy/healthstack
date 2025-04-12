// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      message: json['message'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'username': instance.username,
      'email': instance.email,
    };
