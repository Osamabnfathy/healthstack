import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/medical_reports/data/repo/medical_reports_repo.dart';
import 'package:healthstack/features/medical_reports/logic/cubit/medical_reports_state.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';

class MedicalReportsCubit extends Cubit<MedicalReportsState<MedicalReportsResponseModel>> {
  final MedicalReportsRepo medicalReportsRepo;

  MedicalReportsCubit(this.medicalReportsRepo) : super(const MedicalReportsState.initial());

  Future<void> getMyMedicalReports() async {
    emit(const MedicalReportsState.loading());
    final result = await medicalReportsRepo.getMyMedicalReports();
    result.when(
      success: (data) {
        emit(MedicalReportsState.success(data));
      },
      failure: (error) {
        print('Error fetching prescriptions cubit: ${error.apiErrorModel.message}');
        emit(MedicalReportsState.error(error: error.apiErrorModel.message ?? 'Unknown error'));
      }
    );
  }
}