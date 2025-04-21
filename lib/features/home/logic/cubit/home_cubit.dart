import 'home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/data/repos/home_repo.dart';



class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeState.initial());
  
  void getSpecializations() async {
    emit(const HomeState.specializationsLoading());
    final response = await _homeRepo.getSpecializations();
    response.when(
      success: (specializationsResponseModel) {
        emit(HomeState.specializationsSuccess(specializationsResponseModel));
      },
      failure: (error) {
        emit(HomeState.specializationsError(error));
      },
    );
  }
  
  void getDoctors() async {
    emit(const HomeState.doctorsLoading());
    final response = await _homeRepo.getDoctors();
    response.when(
      success: (doctorsList) {
        emit(HomeState.doctorsSuccess(doctorsList));
      },
      failure: (error) {
        emit(HomeState.doctorsError(error));
      },
    );
  }
}