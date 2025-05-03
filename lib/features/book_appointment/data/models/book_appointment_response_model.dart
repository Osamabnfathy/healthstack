import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_response_model.g.dart';

@JsonSerializable()
class BookAppointmentResponseModel {
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

  BookAppointmentResponseModel({
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

  factory BookAppointmentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentResponseModelToJson(this);
}