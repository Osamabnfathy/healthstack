import 'package:json_annotation/json_annotation.dart';

part 'my_appointments_response_model.g.dart';

@JsonSerializable()
class MyAppointmentResponseModel {
  final int? id;
  @JsonKey(name: 'appointment_status')
  final String? appointmentStatus;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  final String? patient;
  @JsonKey(name: 'serial_number')
  final String? serialNumber;
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  final String? date;
  final String? time;
  @JsonKey(name: 'appointment_type')
  final String? appointmentType;
  final String? message;
  final int? doctor;

  MyAppointmentResponseModel({
    this.id,
    this.appointmentStatus,
    this.paymentStatus,
    this.patient,
    this.serialNumber,
    this.transactionId,
    this.date,
    this.time,
    this.appointmentType,
    this.message,
    this.doctor,
  });

  factory MyAppointmentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyAppointmentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyAppointmentResponseModelToJson(this);
}