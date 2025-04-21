import 'package:json_annotation/json_annotation.dart';

part 'hospitals_response_model.g.dart';

@JsonSerializable()
class HospitalsResponseModel {
  @JsonKey(name: 'hospital_id')
  final int? hospitalId;
  final String? name;
  final String? address;
  @JsonKey(name: 'featured_image')
  final String? featuredImage;
  final String? description;
  final String? email;
  @JsonKey(name: 'phone_number')
  final int? phoneNumber;
  @JsonKey(name: 'hospital_type')
  final String? hospitalType;
  @JsonKey(name: 'general_bed_no')
  final int? generalBedNo;
  @JsonKey(name: 'available_icu_no')
  final int? availableIcuNo;
  @JsonKey(name: 'regular_cabin_no')
  final int? regularCabinNo;
  @JsonKey(name: 'emergency_cabin_no')
  final int? emergencyCabinNo;
  @JsonKey(name: 'vip_cabin_no')
  final int? vipCabinNo;

  HospitalsResponseModel({
    this.hospitalId,
    this.name,
    this.address,
    this.featuredImage,
    this.description,
    this.email,
    this.phoneNumber,
    this.hospitalType,
    this.generalBedNo,
    this.availableIcuNo,
    this.regularCabinNo,
    this.emergencyCabinNo,
    this.vipCabinNo,
  });

  // Factory method to parse JSON into a HospitalData object
  factory HospitalsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HospitalsResponseModelFromJson(json);

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() => _$HospitalsResponseModelToJson(this);
}