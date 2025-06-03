import 'package:json_annotation/json_annotation.dart';

part 'prescriptions_response_model.g.dart';

@JsonSerializable()
class PrescriptionsResponseModel {
  final List<PrescriptionModel>? prescriptions;
  @JsonKey(name: 'prescriptions_medicine')
  final List<PrescriptionMedicineModel>? prescriptionsMedicine;
  @JsonKey(name: 'prescriptions_test')
  final List<PrescriptionTestModel>? prescriptionsTest;

  PrescriptionsResponseModel({
    this.prescriptions,
    this.prescriptionsMedicine,
    this.prescriptionsTest,
  });

  factory PrescriptionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionsResponseModelToJson(this);
}

@JsonSerializable()
class PrescriptionModel {
  @JsonKey(name: 'prescription_id')
  final int? prescriptionId;
  @JsonKey(name: 'create_date')
  final String? createDate;
  @JsonKey(name: 'extra_information')
  final String? extraInformation;
  final int? doctor;
  final int? patient;

  PrescriptionModel({
    this.prescriptionId,
    this.createDate,
    this.extraInformation,
    this.doctor,
    this.patient,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);
}

@JsonSerializable()
class PrescriptionMedicineModel {
  @JsonKey(name: 'medicine_id')
  final int? medicineId;
  @JsonKey(name: 'medicine_name')
  final String? medicineName;
  final String? quantity;
  final String? duration;
  final String? frequency;
  @JsonKey(name: 'relation_with_meal')
  final String? relationWithMeal;
  final String? instruction;
  final int? prescription;

  PrescriptionMedicineModel({
    this.medicineId,
    this.medicineName,
    this.quantity,
    this.duration,
    this.frequency,
    this.relationWithMeal,
    this.instruction,
    this.prescription,
  });

  factory PrescriptionMedicineModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionMedicineModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionMedicineModelToJson(this);
}

@JsonSerializable()
class PrescriptionTestModel {
  @JsonKey(name: 'test_id')
  final int? testId;
  @JsonKey(name: 'test_name')
  final String? testName;
  @JsonKey(name: 'test_description')
  final String? testDescription;
  @JsonKey(name: 'test_info_id')
  final String? testInfoId;
  @JsonKey(name: 'test_info_price')
  final String? testInfoPrice;
  @JsonKey(name: 'test_info_pay_status')
  final String? testInfoPayStatus;
  final int? prescription;

  PrescriptionTestModel({
    this.testId,
    this.testName,
    this.testDescription,
    this.testInfoId,
    this.testInfoPrice,
    this.testInfoPayStatus,
    this.prescription,
  });

  factory PrescriptionTestModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionTestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionTestModelToJson(this);
}