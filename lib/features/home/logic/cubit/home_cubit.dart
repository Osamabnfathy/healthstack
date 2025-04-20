import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/repos/home_repo.dart';
import 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeState.initial());
  
  void getHospitalList() async {
    emit(const HomeState.hospitalsLoading());
    final response = await _homeRepo.getHospitalList();
    response.when(
      success: (hospitalsResponseModel) {
        emit(HomeState.hospitalsSuccess(hospitalsResponseModel));
      },
      failure: (error) {
        emit(HomeState.hospitalsError(error));
      },
    );
  }
  
  void getDoctorList() async {
    emit(const HomeState.doctorsLoading());
    final response = await _homeRepo.getDoctorList();
    response.when(
      success: (doctorsResponseModel) {
        emit(HomeState.doctorsSuccess(doctorsResponseModel));
      },
      failure: (error) {
        emit(HomeState.doctorsError(error));
      },
    );
  }
}