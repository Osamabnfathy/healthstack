// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_appointments_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAppointmentResponseModel _$MyAppointmentResponseModelFromJson(
        Map<String, dynamic> json) =>
    MyAppointmentResponseModel(
      id: (json['id'] as num?)?.toInt(),
      appointmentStatus: json['appointment_status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      patient: json['patient'] as String?,
      serialNumber: json['serial_number'] as String?,
      transactionId: json['transaction_id'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      appointmentType: json['appointment_type'] as String?,
      message: json['message'] as String?,
      doctor: (json['doctor'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyAppointmentResponseModelToJson(
        MyAppointmentResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_status': instance.appointmentStatus,
      'payment_status': instance.paymentStatus,
      'patient': instance.patient,
      'serial_number': instance.serialNumber,
      'transaction_id': instance.transactionId,
      'date': instance.date,
      'time': instance.time,
      'appointment_type': instance.appointmentType,
      'message': instance.message,
      'doctor': instance.doctor,
    };
