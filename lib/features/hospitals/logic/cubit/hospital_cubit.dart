import 'hospital_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/hospitals/data/repos/hospital_repo.dart';


class HospitalCubit extends Cubit<HospitalState> {
  final HospitalRepo _hospitalRepo;
  HospitalCubit(this._hospitalRepo) : super(HospitalState.initial());
  
  void getHospitalList() async {
    emit(const HospitalState.hospitalsLoading());
    final response = await _hospitalRepo.getHospitalList();
    response.when(
      success: (hospitalsList) {
        emit(HospitalState.hospitalsSuccess(hospitalsList));
      },
      failure: (error) {
        emit(HospitalState.hospitalsError(error));
      },
    );
  }
  
}