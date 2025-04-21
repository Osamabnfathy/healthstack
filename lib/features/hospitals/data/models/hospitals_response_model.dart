import 'package:json_annotation/json_annotation.dart';

part 'hospitals_response_model.g.dart';

@JsonSerializable()
class HospitalsResponseModel {
  // The list of hospitals in the response
  List<HospitalData>? hospitals;

  HospitalsResponseModel({
    this.hospitals,
  });

  // Factory method to parse JSON into a HospitalsResponseModel object
  factory HospitalsResponseModel.fromJson(Map<String, dynamic> json) {
    // The API response is a list, so we map it to a list of HospitalData objects
    final List<dynamic> hospitalList = json as List;
    return HospitalsResponseModel(
      hospitals: hospitalList.map((item) => HospitalData.fromJson(item)).toList(),
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() => {
        'hospitals': hospitals?.map((e) => e.toJson()).toList(),
      };
}

@JsonSerializable()
class HospitalData {
  @JsonKey(name: 'hospital_id')
  int? hospitalId;
  String? name;
  String? address;
  @JsonKey(name: 'featured_image')
  String? featuredImage;
  String? description;
  String? email;
  @JsonKey(name: 'phone_number')
  int? phoneNumber;
  @JsonKey(name: 'hospital_type')
  String? hospitalType;
  @JsonKey(name: 'general_bed_no')
  int? generalBedNo;
  @JsonKey(name: 'available_icu_no')
  int? availableIcuNo;
  @JsonKey(name: 'regular_cabin_no')
  int? regularCabinNo;
  @JsonKey(name: 'emergency_cabin_no')
  int? emergencyCabinNo;
  @JsonKey(name: 'vip_cabin_no')
  int? vipCabinNo;

  HospitalData({
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
  factory HospitalData.fromJson(Map<String, dynamic> json) =>
      _$HospitalDataFromJson(json);

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() => _$HospitalDataToJson(this);
}