import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/hospitals/data/models/hospitals_response_model.dart';

part 'hospital_state.freezed.dart';

@freezed
class HospitalState with _$HospitalState {
  const factory HospitalState.initial() = _Initial;
  
  const factory HospitalState.hospitalsLoading() = HospitalsLoading;
  const factory HospitalState.hospitalsSuccess(List<HospitalData> hospitalsList) = HospitalsSuccess;
  const factory HospitalState.hospitalsError(ErrorHandler error) = HospitalsError;
}
