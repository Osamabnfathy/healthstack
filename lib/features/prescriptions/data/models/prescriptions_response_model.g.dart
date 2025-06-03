// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescriptions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionsResponseModel _$PrescriptionsResponseModelFromJson(
        Map<String, dynamic> json) =>
    PrescriptionsResponseModel(
      prescriptions: (json['prescriptions'] as List<dynamic>?)
          ?.map((e) => PrescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      prescriptionsMedicine: (json['prescriptions_medicine'] as List<dynamic>?)
          ?.map((e) =>
              PrescriptionMedicineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      prescriptionsTest: (json['prescriptions_test'] as List<dynamic>?)
          ?.map(
              (e) => PrescriptionTestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionsResponseModelToJson(
        PrescriptionsResponseModel instance) =>
    <String, dynamic>{
      'prescriptions': instance.prescriptions,
      'prescriptions_medicine': instance.prescriptionsMedicine,
      'prescriptions_test': instance.prescriptionsTest,
    };

PrescriptionModel _$PrescriptionModelFromJson(Map<String, dynamic> json) =>
    PrescriptionModel(
      prescriptionId: (json['prescription_id'] as num?)?.toInt(),
      createDate: json['create_date'] as String?,
      extraInformation: json['extra_information'] as String?,
      doctor: (json['doctor'] as num?)?.toInt(),
      patient: (json['patient'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PrescriptionModelToJson(PrescriptionModel instance) =>
    <String, dynamic>{
      'prescription_id': instance.prescriptionId,
      'create_date': instance.createDate,
      'extra_information': instance.extraInformation,
      'doctor': instance.doctor,
      'patient': instance.patient,
    };

PrescriptionMedicineModel _$PrescriptionMedicineModelFromJson(
        Map<String, dynamic> json) =>
    PrescriptionMedicineModel(
      medicineId: (json['medicine_id'] as num?)?.toInt(),
      medicineName: json['medicine_name'] as String?,
      quantity: json['quantity'] as String?,
      duration: json['duration'] as String?,
      frequency: json['frequency'] as String?,
      relationWithMeal: json['relation_with_meal'] as String?,
      instruction: json['instruction'] as String?,
      prescription: (json['prescription'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PrescriptionMedicineModelToJson(
        PrescriptionMedicineModel instance) =>
    <String, dynamic>{
      'medicine_id': instance.medicineId,
      'medicine_name': instance.medicineName,
      'quantity': instance.quantity,
      'duration': instance.duration,
      'frequency': instance.frequency,
      'relation_with_meal': instance.relationWithMeal,
      'instruction': instance.instruction,
      'prescription': instance.prescription,
    };

PrescriptionTestModel _$PrescriptionTestModelFromJson(
        Map<String, dynamic> json) =>
    PrescriptionTestModel(
      testId: (json['test_id'] as num?)?.toInt(),
      testName: json['test_name'] as String?,
      testDescription: json['test_description'] as String?,
      testInfoId: json['test_info_id'] as String?,
      testInfoPrice: json['test_info_price'] as String?,
      testInfoPayStatus: json['test_info_pay_status'] as String?,
      prescription: (json['prescription'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PrescriptionTestModelToJson(
        PrescriptionTestModel instance) =>
    <String, dynamic>{
      'test_id': instance.testId,
      'test_name': instance.testName,
      'test_description': instance.testDescription,
      'test_info_id': instance.testInfoId,
      'test_info_price': instance.testInfoPrice,
      'test_info_pay_status': instance.testInfoPayStatus,
      'prescription': instance.prescription,
    };
