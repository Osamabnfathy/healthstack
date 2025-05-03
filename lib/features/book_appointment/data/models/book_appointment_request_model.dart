import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_request_model.g.dart';

@JsonSerializable()
class BookAppointmentRequestModel {
  final String date;
  final String time;
  @JsonKey(name: 'appointment_type')
  final String appointmentType;
  final String message;
  final int doctor;

  BookAppointmentRequestModel({
    required this.date,
    required this.time,
    required this.appointmentType,
    required this.message,
    required this.doctor,
  });

  factory BookAppointmentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentRequestModelToJson(this);
}