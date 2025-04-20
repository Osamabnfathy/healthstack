import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  
  const factory HomeState.hospitalsLoading() = HospitalsLoading;
  const factory HomeState.hospitalsSuccess(List<HospitalData> hospitalsList) = HospitalsSuccess;
  const factory HomeState.hospitalsError(ErrorHandler error) = HospitalsError;
  
  const factory HomeState.doctorsLoading() = DoctorsLoading;
  const factory HomeState.doctorsSuccess(List<DoctorData> doctorsList) = DoctorsSuccess;
  const factory HomeState.doctorsError(ErrorHandler error) = DoctorsError;
}
