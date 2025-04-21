import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  
  const factory HomeState.specializationsLoading() = SpecializationsLoading;
  const factory HomeState.specializationsSuccess(List<SpecializationsResponseModel> specializationsResponseModel) = SpecializationsSuccess;
  const factory HomeState.specializationsError(ErrorHandler error) = SpecializationsError;
  
  const factory HomeState.doctorsLoading() = DoctorsLoading;
  const factory HomeState.doctorsSuccess(List<DoctorsResponseModel> doctorsResponseModel) = DoctorsSuccess;
  const factory HomeState.doctorsError(ErrorHandler error) = DoctorsError;
}
