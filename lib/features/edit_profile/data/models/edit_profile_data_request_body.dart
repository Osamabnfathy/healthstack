import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_data_request_body.g.dart';

@JsonSerializable()
class EditProfileDataRequestBody {
  final String? name;
  final String? username;
  final String? email;
  final String? dob;
  final int? age;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  @JsonKey(name: 'phone_number')
  final String? phone;
  final String? address;
  final String? nid;

  EditProfileDataRequestBody({
    this.name,
    this.username,
    this.email,
    this.dob,
    this.age,
    this.bloodGroup,
    this.phone,
    this.address,
    this.nid,
  });

  Map<String, dynamic> toJson() => _$EditProfileDataRequestBodyToJson(this);

  factory EditProfileDataRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EditProfileDataRequestBodyFromJson(json);
}