import 'package:json_annotation/json_annotation.dart';

// Make sure this filename matches your file name
part 'doctors_response_model.g.dart';

@JsonSerializable()
class DoctorsResponseModel {
  List<DoctorData>? doctors; // This will hold the parsed list

  DoctorsResponseModel({
    this.doctors,
  });

  
  factory DoctorsResponseModel.fromJson(Map<String, dynamic> json) {
    // The API response is a list, so we map it to a list of HospitalData objects
    final List<dynamic> doctorList = json as List;
    return DoctorsResponseModel(
      doctors: doctorList.map((item) => DoctorData.fromJson(item)).toList(),
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() => {
        'doctors': doctors?.map((e) => e.toJson()).toList(),
      };
}


@JsonSerializable()
class DoctorData {
  @JsonKey(name: 'doctor_id') // Maps JSON key 'doctor_id' to Dart field 'id'
  final int? id; // Changed name to be consistent with data object naming
  final String? name;
  final String? username;
  final String? gender;
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
  final String? nid;
  @JsonKey(name: 'visiting_hour')
  final String? visitingHour;
  @JsonKey(name: 'consultation_fee')
  final int? consultationFee;
  @JsonKey(name: 'report_fee')
  final int? reportFee;
  final int? user; // Represents the linked user ID
  @JsonKey(name: 'department_name')
  final String? departmentName;
  final String? sepecialization; // Note: Typo in original, kept for consistency with input
  @JsonKey(name: 'hospital_name')
  final String? hospitalName;

  DoctorData({
    this.id,
    this.name,
    this.username,
    this.gender,
    this.description,
    this.department,
    this.featuredImage,
    this.email,
    this.phoneNumber,
    this.degree,
    this.certificateImage,
    this.nid,
    this.visitingHour,
    this.consultationFee,
    this.reportFee,
    this.user,
    this.departmentName,
    this.sepecialization,
    this.hospitalName,
  });

  // Factory constructor for creating a new DoctorData instance from a map.
  factory DoctorData.fromJson(Map<String, dynamic> json) =>
      _$DoctorDataFromJson(json);

  // Method for converting a DoctorData instance to a map.
  Map<String, dynamic> toJson() => _$DoctorDataToJson(this);
}