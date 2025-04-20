// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorsResponseModel _$DoctorsResponseModelFromJson(
        Map<String, dynamic> json) =>
    DoctorsResponseModel(
      doctors: (json['doctors'] as List<dynamic>?)
          ?.map((e) => DoctorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorsResponseModelToJson(
        DoctorsResponseModel instance) =>
    <String, dynamic>{
      'doctors': instance.doctors,
    };

DoctorData _$DoctorDataFromJson(Map<String, dynamic> json) => DoctorData(
      id: (json['doctor_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      username: json['username'] as String?,
      gender: json['gender'] as String?,
      description: json['description'] as String?,
      department: json['department'] as String?,
      featuredImage: json['featured_image'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      degree: json['degree'] as String?,
      certificateImage: json['certificate_image'] as String?,
      nid: json['nid'] as String?,
      visitingHour: json['visiting_hour'] as String?,
      consultationFee: (json['consultation_fee'] as num?)?.toInt(),
      reportFee: (json['report_fee'] as num?)?.toInt(),
      dob: json['dob'] as String?,
      user: (json['user'] as num?)?.toInt(),
      departmentName: (json['department_name'] as num?)?.toInt(),
      specialization: (json['specialization'] as num?)?.toInt(),
      hospitalName: (json['hospital_name'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DoctorDataToJson(DoctorData instance) =>
    <String, dynamic>{
      'doctor_id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'gender': instance.gender,
      'description': instance.description,
      'department': instance.department,
      'featured_image': instance.featuredImage,
      'certificate_image': instance.certificateImage,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'degree': instance.degree,
      'nid': instance.nid,
      'visiting_hour': instance.visitingHour,
      'consultation_fee': instance.consultationFee,
      'report_fee': instance.reportFee,
      'dob': instance.dob,
      'user': instance.user,
      'department_name': instance.departmentName,
      'specialization': instance.specialization,
      'hospital_name': instance.hospitalName,
    };
