import 'package:json_annotation/json_annotation.dart';

part 'medical_reports_response_model.g.dart';

@JsonSerializable()
class MedicalReportsResponseModel {
  final List<ReportModel>? report;
  final List<SpecimenModel>? specimen;
  final List<TestModel>? test;

  MedicalReportsResponseModel({
    this.report,
    this.specimen,
    this.test,
  });

  factory MedicalReportsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalReportsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalReportsResponseModelToJson(this);
}

@JsonSerializable()
class ReportModel {
  @JsonKey(name: 'report_id')
  final int? reportId;
  @JsonKey(name: 'delivery_date')
  final String? deliveryDate;
  @JsonKey(name: 'other_information')
  final String? otherInformation;
  final int? doctor;
  final int? patient;

  ReportModel({
    this.reportId,
    this.deliveryDate,
    this.otherInformation,
    this.doctor,
    this.patient,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}

@JsonSerializable()
class SpecimenModel {
  @JsonKey(name: 'specimen_id')
  final int? specimenId;
  @JsonKey(name: 'specimen_type')
  final String? specimenType;
  @JsonKey(name: 'collection_date')
  final String? collectionDate;
  @JsonKey(name: 'receiving_date')
  final String? receivingDate;
  final int? report;

  SpecimenModel({
    this.specimenId,
    this.specimenType,
    this.collectionDate,
    this.receivingDate,
    this.report,
  });

  factory SpecimenModel.fromJson(Map<String, dynamic> json) =>
      _$SpecimenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecimenModelToJson(this);
}

@JsonSerializable()
class TestModel {
  @JsonKey(name: 'test_id')
  final int? testId;
  @JsonKey(name: 'test_name')
  final String? testName;
  final String? result;
  final String? unit;
  @JsonKey(name: 'referred_value')
  final String? referredValue;
  final int? report;

  TestModel({
    this.testId,
    this.testName,
    this.result,
    this.unit,
    this.referredValue,
    this.report,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) =>
      _$TestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TestModelToJson(this);
}