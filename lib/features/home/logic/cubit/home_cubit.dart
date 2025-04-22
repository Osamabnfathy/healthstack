import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

import 'home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/data/repos/home_repo.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';



class HomeCubit extends Cubit<HomeState> {
  List<HospitalsResponseModel>? hospitalsDataList;
  List<DoctorsResponseModel>? doctorsDataList;
  List<SpecializationsResponseModel>? specializationsDataList;
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeState.initial());
  
  void getSpecializations() async {
    emit(const HomeState.specializationsLoading());
    final response = await _homeRepo.getSpecializations();
    response.when(
      success: (specializationsResponseModel) {
        specializationsDataList = specializationsResponseModel;
        emit(HomeState.specializationsSuccess(specializationsResponseModel));
      },
      failure: (error) {
        emit(HomeState.specializationsError(error));
      },
    );
  }
  
  void getDoctorsList() async {
    emit(const HomeState.doctorsLoading());
    final response = await _homeRepo.getDoctors();
    response.when(
      success: (doctorsResponseModel) {
        doctorsDataList = doctorsResponseModel;
        emit(HomeState.doctorsSuccess(doctorsResponseModel));
      },
      failure: (error) {
        emit(HomeState.doctorsError(error));
      },
    );
  }
  
  void getHospitalList() async {
    emit(const HomeState.hospitalsLoading());
    final response = await _homeRepo.getHospitals();
    response.when(
      success: (hospitalsResponseModel) {
        hospitalsDataList = hospitalsResponseModel; 
        emit(HomeState.hospitalsSuccess(hospitalsResponseModel));
      },
      failure: (error) {
        emit(HomeState.hospitalsError(error));
      },
    );
  }
}