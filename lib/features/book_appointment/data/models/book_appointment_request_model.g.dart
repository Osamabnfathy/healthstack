// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_appointment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAppointmentRequestModel _$BookAppointmentRequestModelFromJson(
        Map<String, dynamic> json) =>
    BookAppointmentRequestModel(
      date: json['date'] as String,
      time: json['time'] as String,
      appointmentType: json['appointment_type'] as String,
      message: json['message'] as String,
      doctor: (json['doctor'] as num).toInt(),
    );

Map<String, dynamic> _$BookAppointmentRequestModelToJson(
        BookAppointmentRequestModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'appointment_type': instance.appointmentType,
      'message': instance.message,
      'doctor': instance.doctor,
    };
