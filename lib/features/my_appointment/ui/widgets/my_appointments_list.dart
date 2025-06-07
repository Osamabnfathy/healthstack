import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/networking/notification_service.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointments_card.dart';
import 'package:healthstack/features/my_appointment/logic/cubit/my_appointments_cubit.dart';
import 'package:healthstack/features/my_appointment/logic/cubit/my_appointments_state.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';

class MyAppointmentList extends StatefulWidget {
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
  State<MyAppointmentList> createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  bool _hasScheduledNotifications = false;
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsCubit, MyAppointmentsState<List<MyAppointmentResponseModel>>>(
      builder: (context, state) {
        List<MyAppointmentResponseModel>? _successAppointments;
        state.whenOrNull(
          success: (appointments) {
            _successAppointments = appointments;
          },
        );

        if (_successAppointments != null && widget.selectedTab == 0 && !_hasScheduledNotifications) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            for (final appointment in _successAppointments!) {
              _scheduleAppointmentNotification(appointment);
            }
            _hasScheduledNotifications = true;
          });
        }
      
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator(color: ColorsManager.mainBlue,)),
          
          loading: () => const Center(child: CircularProgressIndicator(color: ColorsManager.mainBlue,)),
          
          success: (appointments) {
            final filtered = _getFilteredAppointments(appointments, widget.selectedTab);
  
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
              key: ValueKey(widget.selectedTab),
              itemCount: filtered.length,
              physics: const BouncingScrollPhysics(),
              
              itemBuilder: (context, index) {
                final appointment = filtered[index];
                
                final doctor = widget.doctors?.firstWhere(
                  (d) => d.doctorId == appointment.doctor,
                  orElse: () => DoctorsResponseModel(), 
                );
                
                final hospital = widget.hospitals?.firstWhere(
                  (h) => h.hospitalId == doctor?.hospitalName,
                  orElse: () => HospitalsResponseModel(),
                );
                
                final department = widget.departments?.firstWhere(
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
    switch (widget.selectedTab) {
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

   // NEW: SCHEDULE NOTIFICATIONS METHOD
  Future<void> _scheduleAppointmentNotification(MyAppointmentResponseModel appointment) async {
  try {
    final aptDateTime = _parseDateTime(appointment.date, appointment.time);
    final notificationTime = aptDateTime.subtract(const Duration(minutes: 60));
    
    if (notificationTime.isAfter(DateTime.now())) {
      final doctor = widget.doctors?.firstWhere(
        (d) => d.doctorId == appointment.doctor,
        orElse: () => DoctorsResponseModel(),
      );

      await NotificationService.scheduleNotification(
        id: appointment.id ?? appointment.hashCode,
        title: 'Upcoming Appointment',
        body: 'With Dr. ${doctor?.name} at ${_formatTime(aptDateTime)}',
        scheduledTime: notificationTime,
      );
      
      await NotificationService.scheduleAppointmentNotification(
        appointment: appointment, 
        doctor: doctor
      );
    }
  } catch (e) {
    debugPrint('⚠️ Notification scheduling failed: $e');
  }
}

  // NEW: TIME FORMATTER
  String _formatTime(DateTime dt) {
  final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
  final period = dt.hour >= 12 ? 'PM' : 'AM';
  return '$hour:${dt.minute.toString().padLeft(2, '0')} $period';
}

  // UPDATED: ROBUST DATE PARSING
  DateTime _parseDateTime(String? date, String? time) {
    try {
      if (date == null || time == null) throw 'Missing date/time';
      
      final dateParts = date.split('-');
      final timeParts = time.split(':');
      
      return DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (e) {
      return DateTime.now().add(Duration(days: 1)); 
    }
  }

  // UPDATED FILTERING WITH ERROR HANDLING
  List<MyAppointmentResponseModel> _getFilteredAppointments(List<MyAppointmentResponseModel> allAppointments, int selectedTab) {
    final now = DateTime.now();
    
    return allAppointments.where((apt) {
      // Skip if no valid date/time
      if (apt.date == null || apt.time == null) return false;
      
      try {
        final aptTime = _parseDateTime(apt.date, apt.time);
        
        switch (selectedTab) {
          case 0: // Upcoming
            return apt.appointmentStatus?.toLowerCase() == 'pending' && 
                   aptTime.isAfter(now);
            
          case 1: // Completed
            return (apt.appointmentStatus?.toLowerCase() == 'confirmed' || 
                    apt.paymentStatus?.toLowerCase() == 'confirmed') &&
                   aptTime.isBefore(now);
                    
          case 2: // Cancelled
            return apt.appointmentStatus?.toLowerCase() == 'cancelled' || 
                   (apt.appointmentStatus?.toLowerCase() == 'pending' && 
                    aptTime.isBefore(now));
                    
          default: return false;
        }
      } catch (e) {
        return false;
      }
    }).toList()
    ..sort((a, b) {
      try {
        return _parseDateTime(a.date, a.time)
            .compareTo(_parseDateTime(b.date, b.time));
      } catch (_) {
        return 0;
      }
    });
  }
}