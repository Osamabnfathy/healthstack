// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospitals_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalsResponseModel _$HospitalsResponseModelFromJson(
        Map<String, dynamic> json) =>
    HospitalsResponseModel(
      hospitals: (json['hospitals'] as List<dynamic>?)
          ?.map((e) => HospitalData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HospitalsResponseModelToJson(
        HospitalsResponseModel instance) =>
    <String, dynamic>{
      'hospitals': instance.hospitals,
    };

HospitalData _$HospitalDataFromJson(Map<String, dynamic> json) => HospitalData(
      hospitalId: (json['hospital_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      featuredImage: json['featured_image'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      phoneNumber: (json['phone_number'] as num?)?.toInt(),
      hospitalType: json['hospital_type'] as String?,
      generalBedNo: (json['general_bed_no'] as num?)?.toInt(),
      availableIcuNo: (json['available_icu_no'] as num?)?.toInt(),
      regularCabinNo: (json['regular_cabin_no'] as num?)?.toInt(),
      emergencyCabinNo: (json['emergency_cabin_no'] as num?)?.toInt(),
      vipCabinNo: (json['vip_cabin_no'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HospitalDataToJson(HospitalData instance) =>
    <String, dynamic>{
      'hospital_id': instance.hospitalId,
      'name': instance.name,
      'address': instance.address,
      'featured_image': instance.featuredImage,
      'description': instance.description,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'hospital_type': instance.hospitalType,
      'general_bed_no': instance.generalBedNo,
      'available_icu_no': instance.availableIcuNo,
      'regular_cabin_no': instance.regularCabinNo,
      'emergency_cabin_no': instance.emergencyCabinNo,
      'vip_cabin_no': instance.vipCabinNo,
    };
