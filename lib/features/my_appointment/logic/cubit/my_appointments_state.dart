import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_appointments_state.freezed.dart';

@freezed
class MyAppointmentsState<T> with _$MyAppointmentsState<T> {
  const factory MyAppointmentsState.initial() = _Initial;
  
  const factory MyAppointmentsState.loading() = MyAppointmentsLoading;
  const factory MyAppointmentsState.success(T data) = MyAppointmentsSuccess<T>;
  const factory MyAppointmentsState.error({required String error}) = MyAppointmentsError;
}