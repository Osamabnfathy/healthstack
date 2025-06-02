import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_data_state.freezed.dart';

@freezed
class EditProfileDataState<T> with _$EditProfileDataState<T> {
  const factory EditProfileDataState.initial() = _Initial;
  
  const factory EditProfileDataState.loading() = Loading;
  const factory EditProfileDataState.success(T data) = Success<T>;
  const factory EditProfileDataState.error({required String error}) = Error;
}
