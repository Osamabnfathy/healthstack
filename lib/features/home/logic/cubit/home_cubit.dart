import 'home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/data/repos/home_repo.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  int? selectedDepartmentId;
  List<DoctorsResponseModel>? doctorsDataList;
  List<HospitalsResponseModel>? hospitalsDataList;
  List<DepartmentsResponseModel>? departmentsDataList;
  PatientProfileResponseModel? patientProfileData;
  HomeCubit(this._homeRepo) : super(HomeState.initial());
  
  void getDepartmentId(int departmentId) {
    selectedDepartmentId = departmentId;
    emit(HomeState.departmentSelected(departmentId));
  }
  
  void getDepartments() async {
    emit(const HomeState.departmentsLoading());
    final response = await _homeRepo.getDepartments();
    response.when(
      success: (departmentsResponseModel) {
        departmentsDataList = departmentsResponseModel;
        emit(HomeState.departmentsSuccess(departmentsResponseModel));
      },
      failure: (error) {
        emit(HomeState.departmentsError(error));
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
  
  void getPatientProfile() async {
    emit(const HomeState.patientProfileLoading());
    final response = await _homeRepo.getPatientProfile();
    response.when(
      success: (patientProfileResponseModel) {
        patientProfileData = patientProfileResponseModel;
        emit(HomeState.patientProfileSuccess(patientProfileResponseModel));
      },
      failure: (error) {
        emit(HomeState.patientProfileError(error));
      },
    );
  }
}