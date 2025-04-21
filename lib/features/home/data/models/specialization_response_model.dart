import 'package:json_annotation/json_annotation.dart';

part 'specialization_response_model.g.dart';

@JsonSerializable()
class SpecializationsResponseModel {
  @JsonKey(name: "hospital_department_id")
  int? hospitalDepartmentId;
  @JsonKey(name: "hospital_department_name")
  String? hospitalDepartmentName;
  @JsonKey(name: "featured_image")
  String? featuredImage;
  int? hospital;
  
  SpecializationsResponseModel({
    this.hospitalDepartmentId,
    this.hospitalDepartmentName,
    this.featuredImage,
    this.hospital,
  });

  // Factory method to parse JSON into a HospitalData object
  factory SpecializationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SpecializationsResponseModelFromJson(json);

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() => _$SpecializationsResponseModelToJson(this);
}