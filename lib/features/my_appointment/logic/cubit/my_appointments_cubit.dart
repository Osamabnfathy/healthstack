import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/my_appointment/data/repos/my_appointments_repo.dart';
import 'package:healthstack/features/my_appointment/logic/cubit/my_appointments_state.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState<List<MyAppointmentResponseModel>>> {
  final MyAppointmentsRepo appointmentRepo;

  MyAppointmentsCubit(this.appointmentRepo) : super(const MyAppointmentsState.initial());

  Future<void> getMyAppointments() async {
    emit(const MyAppointmentsState.loading());
    final result = await appointmentRepo.getMyAppointments();
    result.when(
      success: (data) {
        emit(MyAppointmentsState.success(data));
      },
      failure: (error) {
        print('Error fetching appointments cubit: ${error.apiErrorModel.message}');
        emit(MyAppointmentsState.error(error: error.apiErrorModel.message ?? 'Unknown error'));
      }
    );
  }
}