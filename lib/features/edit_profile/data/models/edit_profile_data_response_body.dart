import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_data_response_body.g.dart';

@JsonSerializable()
class EditProfileDataResponseBody {
  @JsonKey(name: 'patient_id')
  final int? patientId;
  final String? name;
  final String? username;
  final int? age;
  final String? email;
  @JsonKey(name: 'phone_number')
  final int? phoneNumber;
  final String? address;
  @JsonKey(name: 'featured_image')
  final String? featuredImage;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  final String? history;
  final String? dob;
  final String? nid;
  @JsonKey(name: 'serial_number')
  final String? serialNumber;
  @JsonKey(name: 'login_status')
  final String? loginStatus;
  final int? user;

  EditProfileDataResponseBody({
    this.patientId,
    this.name,
    this.username,
    this.age,
    this.email,
    this.phoneNumber,
    this.address,
    this.featuredImage,
    this.bloodGroup,
    this.history,
    this.dob,
    this.nid,
    this.serialNumber,
    this.loginStatus,
    this.user,
  });

  factory EditProfileDataResponseBody.fromJson(Map<String, dynamic> json) =>
      _$EditProfileDataResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileDataResponseBodyToJson(this);
}