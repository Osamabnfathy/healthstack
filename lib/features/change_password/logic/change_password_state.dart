import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState<T> with _$ChangePasswordState<T> {
  const factory ChangePasswordState.initial() = _Initial;
  
  const factory ChangePasswordState.changePasswordLoading() = ChangePasswordLoading;
  const factory ChangePasswordState.changePasswordSuccess(T data) = ChangePasswordSuccess<T>;
  const factory ChangePasswordState.changePasswordError({required String error}) = ChangePasswordError;
}