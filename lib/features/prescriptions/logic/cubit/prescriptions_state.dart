import 'package:freezed_annotation/freezed_annotation.dart';

part 'prescriptions_state.freezed.dart';

@freezed
class PrescriptionsState<T> with _$PrescriptionsState<T> {
  const factory PrescriptionsState.initial() = _Initial;
  
  const factory PrescriptionsState.loading() = PrescriptionsLoading;
  const factory PrescriptionsState.success(T data) = PrescriptionsSuccess<T>;
  const factory PrescriptionsState.error({required String error}) = PrescriptionsError;
}