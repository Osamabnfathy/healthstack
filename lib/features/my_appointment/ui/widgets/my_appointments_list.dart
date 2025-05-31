import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointments_card.dart';
import 'package:healthstack/features/my_appointment/logic/cubit/my_appointments_cubit.dart';
import 'package:healthstack/features/my_appointment/logic/cubit/my_appointments_state.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';

class MyAppointmentList extends StatelessWidget {
  final int selectedTab; // 0: Upcoming, 1: Completed, 2: Cancelled
  final List<DoctorsResponseModel>? doctors;
  final List<HospitalsResponseModel>? hospitals;
  final List<DepartmentsResponseModel>? departments;

  const MyAppointmentList({
    super.key,
    required this.selectedTab,
    this.doctors,
    this.hospitals,
    this.departments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsCubit, MyAppointmentsState<List<MyAppointmentResponseModel>>>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          
          loading: () => const Center(child: CircularProgressIndicator()),
          
          success: (appointments) {
            final filtered = _getFilteredAppointments(appointments, selectedTab);
            if (filtered.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 65,
                      color: ColorsManager.lightGray,
                    ),
                    verticalSpace(16),
                    
                    Text(
                      _getEmptyListMessage(),
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorsManager.gray,
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              key: ValueKey(selectedTab),
              itemCount: filtered.length,
              physics: const BouncingScrollPhysics(),
              
              itemBuilder: (context, index) {
                final appointment = filtered[index];
                
                final doctor = doctors?.firstWhere(
                  (d) => d.doctorId == appointment.doctor,
                  orElse: () => DoctorsResponseModel(), 
                );
                
                final hospital = hospitals?.firstWhere(
                  (h) => h.hospitalId == doctor?.hospitalName,
                  orElse: () => HospitalsResponseModel(),
                );
                
                final department = departments?.firstWhere(
                  (dep) => dep.hospitalDepartmentId == doctor?.departmentName,
                  orElse: () => DepartmentsResponseModel(),
                );
                
                String doctorFee = '';
                if (appointment.appointmentType?.toLowerCase() == 'checkup') {
                  doctorFee = doctor?.consultationFee?.toString() ?? '';
                } else if (appointment.appointmentType?.toLowerCase() == 'report') {
                  doctorFee = doctor?.reportFee?.toString() ?? '';
                } else {
                  doctorFee = '';
                }

                return MyAppintmentCard(
                  data: AppointmentData(
                    doctorImage: doctor?.featuredImage ?? "",
                    doctorName: doctor?.name ?? "",
                    specialty: department?.hospitalDepartmentName ?? "",
                    hospitalName: hospital?.name ?? "",
                    date: appointment.date,
                    time: appointment.time,
                    type: appointment.appointmentType,
                    amount: doctorFee,
                    status: appointment.appointmentStatus,
                    paymentStatus: appointment.paymentStatus,
                  ),
                );
              },
            );
          },
          
          error: (error) => Center(child: Text("error is $error")),
        );
      },
    );
  }

  String _getEmptyListMessage() {
    switch (selectedTab) {
      case 0:
        return 'No pending appointments found';
      case 1:
        return 'No completed appointments found';
      case 2:
        return 'No cancelled appointments found';
      default:
        return 'No appointments found';
    }
  }

  List<MyAppointmentResponseModel> _getFilteredAppointments(List<MyAppointmentResponseModel> allAppointments, int selectedTab) {
    List<MyAppointmentResponseModel> filteredAppointments;
    
    switch (selectedTab) {
      case 0:
        filteredAppointments = allAppointments.where((apt) =>
          (apt.appointmentStatus?.toLowerCase() == 'pending') &&
          (apt.date != null && apt.date!.compareTo(DateTime.now().toString().substring(0, 10)) >= 0)
        ).toList();
        break;
  
      case 1:
      filteredAppointments = allAppointments.where((apt) =>
          (apt.paymentStatus?.toLowerCase() == 'confirmed') ||
          (apt.appointmentStatus?.toLowerCase() == 'confirmed') &&
          (apt.date != null && apt.date!.compareTo(DateTime.now().toString().substring(0, 10)) < 0)
        ).toList();
        break;
  
      case 2:
        filteredAppointments = allAppointments.where((apt) =>
          (apt.appointmentStatus?.toLowerCase() == 'cancelled') ||
          (apt.appointmentStatus?.toLowerCase() == 'pending') &&
          (apt.date != null && apt.date!.compareTo(DateTime.now().toString().substring(0, 10)) < 0)
        ).toList();
        break;
        
      default:
        filteredAppointments = [];
    }
    
    filteredAppointments.sort((a, b) {
      DateTime dateTimeA = _parseDateTime(a.date, a.time);
      DateTime dateTimeB = _parseDateTime(b.date, b.time);
      return dateTimeA.compareTo(dateTimeB);
    });
    
    return filteredAppointments;
  }
  
  DateTime _parseDateTime(String? date, String? time) {
    try {
      return DateTime.parse('${date ?? ''}T${time ?? ''}');
    } catch (_) {
      return DateTime(2100);
    }
  }
}