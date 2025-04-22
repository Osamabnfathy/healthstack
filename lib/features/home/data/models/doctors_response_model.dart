import 'package:json_annotation/json_annotation.dart';

// Make sure this filename matches your file name
part 'doctors_response_model.g.dart';

String? _stringFromJson(dynamic jsonValue) {
  if (jsonValue == null) return null;
  // Handles cases where the JSON provides an int, double, or String
  return jsonValue.toString();
}

@JsonSerializable()
class DoctorsResponseModel {
  @JsonKey(name: 'doctor_id') 
  final int? doctorId; 
  final String? name;
  final String? username;
  final String? description;
  final String? department;
  @JsonKey(name: 'featured_image') // Maps JSON key to Dart field
  final String? featuredImage;
  @JsonKey(name: 'certificate_image')
  final String? certificateImage;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? degree;
  @JsonKey(name: 'visiting_hour')
  final String? visitingHour;
  @JsonKey(name: 'consultation_fee')
  final int? consultationFee;
  @JsonKey(name: 'report_fee')
  final int? reportFee;
  final String? dob; // Date of Birth, if applicable
  final int? user; // Represents the linked user ID
  @JsonKey(name: 'department_name')
  final int? departmentName;
  final int? specialization; // Note: Typo in original, kept for consistency with input
  @JsonKey(name: 'hospital_name')
  final int? hospitalName;

  DoctorsResponseModel({
    this.doctorId,
    this.name,
    this.username,
    this.description,
    this.department,
    this.featuredImage,
    this.email,
    this.phoneNumber,
    this.degree,
    this.certificateImage,
    this.visitingHour,
    this.consultationFee,
    this.reportFee,
    this.dob,
    this.user,
    this.departmentName,
    this.specialization,
    this.hospitalName,
  });

  // Factory constructor for creating a new DoctorsResponseModel instance from a map.
  factory DoctorsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorsResponseModelFromJson(json);

  // Method for converting a DoctorsResponseModel instance to a map.
  Map<String, dynamic> toJson() => _$DoctorsResponseModelToJson(this);
}