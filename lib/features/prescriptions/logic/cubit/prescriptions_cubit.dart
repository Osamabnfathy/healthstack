import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/prescriptions/data/repos/prescriptions_repo.dart';
import 'package:healthstack/features/prescriptions/logic/cubit/prescriptions_state.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';

class PrescriptionsCubit extends Cubit<PrescriptionsState<PrescriptionsResponseModel>> {
  final PrescriptionsRepo prescriptionsRepo;

  PrescriptionsCubit(this.prescriptionsRepo) : super(const PrescriptionsState.initial());

  Future<void> getMyPrescriptions() async {
    emit(const PrescriptionsState.loading());
    final result = await prescriptionsRepo.getMyPrescriptions();
    result.when(
      success: (data) {
        emit(PrescriptionsState.success(data));
      },
      failure: (error) {
        print('Error fetching prescriptions cubit: ${error.apiErrorModel.message}');
        emit(PrescriptionsState.error(error: error.apiErrorModel.message ?? 'Unknown error'));
      }
    );
  }
}