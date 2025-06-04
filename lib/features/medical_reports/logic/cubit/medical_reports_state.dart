import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_reports_state.freezed.dart';

@freezed
class MedicalReportsState<T> with _$MedicalReportsState<T> {
  const factory MedicalReportsState.initial() = _Initial;
  
  const factory MedicalReportsState.loading() = MedicalReportsLoading;
  const factory MedicalReportsState.success(T data) = MedicalReportsSuccess<T>;
  const factory MedicalReportsState.error({required String error}) = MedicalReportsError;
}