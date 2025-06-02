// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_data_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileDataResponseBody _$EditProfileDataResponseBodyFromJson(
        Map<String, dynamic> json) =>
    EditProfileDataResponseBody(
      patientId: (json['patient_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      username: json['username'] as String?,
      age: (json['age'] as num?)?.toInt(),
      email: json['email'] as String?,
      phoneNumber: (json['phone_number'] as num?)?.toInt(),
      address: json['address'] as String?,
      featuredImage: json['featured_image'] as String?,
      bloodGroup: json['blood_group'] as String?,
      history: json['history'] as String?,
      dob: json['dob'] as String?,
      nid: json['nid'] as String?,
      serialNumber: json['serial_number'] as String?,
      loginStatus: json['login_status'] as String?,
      user: (json['user'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EditProfileDataResponseBodyToJson(
        EditProfileDataResponseBody instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'name': instance.name,
      'username': instance.username,
      'age': instance.age,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'featured_image': instance.featuredImage,
      'blood_group': instance.bloodGroup,
      'history': instance.history,
      'dob': instance.dob,
      'nid': instance.nid,
      'serial_number': instance.serialNumber,
      'login_status': instance.loginStatus,
      'user': instance.user,
    };
