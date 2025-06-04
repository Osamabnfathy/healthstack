// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_reports_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalReportsResponseModel _$MedicalReportsResponseModelFromJson(
        Map<String, dynamic> json) =>
    MedicalReportsResponseModel(
      report: (json['report'] as List<dynamic>?)
          ?.map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      specimen: (json['specimen'] as List<dynamic>?)
          ?.map((e) => SpecimenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      test: (json['test'] as List<dynamic>?)
          ?.map((e) => TestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MedicalReportsResponseModelToJson(
        MedicalReportsResponseModel instance) =>
    <String, dynamic>{
      'report': instance.report,
      'specimen': instance.specimen,
      'test': instance.test,
    };

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      reportId: (json['report_id'] as num?)?.toInt(),
      deliveryDate: json['delivery_date'] as String?,
      otherInformation: json['other_information'] as String?,
      doctor: (json['doctor'] as num?)?.toInt(),
      patient: (json['patient'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'report_id': instance.reportId,
      'delivery_date': instance.deliveryDate,
      'other_information': instance.otherInformation,
      'doctor': instance.doctor,
      'patient': instance.patient,
    };

SpecimenModel _$SpecimenModelFromJson(Map<String, dynamic> json) =>
    SpecimenModel(
      specimenId: (json['specimen_id'] as num?)?.toInt(),
      specimenType: json['specimen_type'] as String?,
      collectionDate: json['collection_date'] as String?,
      receivingDate: json['receiving_date'] as String?,
      report: (json['report'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpecimenModelToJson(SpecimenModel instance) =>
    <String, dynamic>{
      'specimen_id': instance.specimenId,
      'specimen_type': instance.specimenType,
      'collection_date': instance.collectionDate,
      'receiving_date': instance.receivingDate,
      'report': instance.report,
    };

TestModel _$TestModelFromJson(Map<String, dynamic> json) => TestModel(
      testId: (json['test_id'] as num?)?.toInt(),
      testName: json['test_name'] as String?,
      result: json['result'] as String?,
      unit: json['unit'] as String?,
      referredValue: json['referred_value'] as String?,
      report: (json['report'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'test_id': instance.testId,
      'test_name': instance.testName,
      'result': instance.result,
      'unit': instance.unit,
      'referred_value': instance.referredValue,
      'report': instance.report,
    };
