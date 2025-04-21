// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialization_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecializationsResponseModel _$SpecializationsResponseModelFromJson(
        Map<String, dynamic> json) =>
    SpecializationsResponseModel(
      hospitalDepartmentId: (json['hospital_department_id'] as num?)?.toInt(),
      hospitalDepartmentName: json['hospital_department_name'] as String?,
      featuredImage: json['featured_image'] as String?,
      hospital: (json['hospital'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpecializationsResponseModelToJson(
        SpecializationsResponseModel instance) =>
    <String, dynamic>{
      'hospital_department_id': instance.hospitalDepartmentId,
      'hospital_department_name': instance.hospitalDepartmentName,
      'featured_image': instance.featuredImage,
      'hospital': instance.hospital,
    };
