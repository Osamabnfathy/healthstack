import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_appointment_state.freezed.dart';

@freezed
class BookAppointmentState<T> with _$BookAppointmentState<T> {
  const factory BookAppointmentState.initial() = _Initial;
  
  const factory BookAppointmentState.loading() = BookAppointmentLoading;
  const factory BookAppointmentState.success(T data) = BookAppointmentSuccess<T>;
  const factory BookAppointmentState.error({required String error}) = BookAppointmentError;
}