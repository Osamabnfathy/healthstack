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

/// Uncomment the following code if you want to enrich doctor data with hospital and department information
// class EnrichedDoctor {
//   final String? name;
//   final String? email;
//   final String? image;
//   final String? hospitalName;
//   final String? departmentName;

//   EnrichedDoctor({
//     this.name,
//     this.email,
//     this.image,
//     this.hospitalName,
//     this.departmentName,
//   });
// }

// List<EnrichedDoctor> getEnrichedDoctors({
//   required List<DoctorsResponseModel> doctors,
//   required List<HospitalsResponseModel> hospitals,
//   required List<DepartmentsResponseModel> departments,
// }) {
//   return doctors.map((doctor) {
//     final hospital = hospitals.firstWhere(
//       (h) => h.hospitalId == doctor.hospitalName,
//       orElse: () => HospitalsResponseModel(),
//     );
//     final department = departments.firstWhere(
//       (d) => d.hospitalDepartmentId == doctor.departmentName,
//       orElse: () => DepartmentsResponseModel(),
//     );
//     return EnrichedDoctor(
//       name: doctor.name,
//       email: doctor.email,
//       image: doctor.featuredImage,
//       hospitalName: hospital.name,
//       departmentName: department.hospitalDepartmentName,
//     );
//   }).toList();
// }