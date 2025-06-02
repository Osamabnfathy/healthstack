// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_data_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileDataRequestBody _$EditProfileDataRequestBodyFromJson(
        Map<String, dynamic> json) =>
    EditProfileDataRequestBody(
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      dob: json['dob'] as String?,
      age: (json['age'] as num?)?.toInt(),
      bloodGroup: json['blood_group'] as String?,
      phone: json['phone_number'] as String?,
      address: json['address'] as String?,
      nid: json['nid'] as String?,
    );

Map<String, dynamic> _$EditProfileDataRequestBodyToJson(
        EditProfileDataRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'dob': instance.dob,
      'age': instance.age,
      'blood_group': instance.bloodGroup,
      'phone_number': instance.phone,
      'address': instance.address,
      'nid': instance.nid,
    };
