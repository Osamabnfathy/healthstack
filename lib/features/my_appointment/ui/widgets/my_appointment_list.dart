import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/my_appointment/data/models/upcoming_models.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointment_card.dart';

class MyAppointmentList extends StatelessWidget {
  final int selectedTab; // 0: Upcoming, 1: Completed, 2: Cancelled

  const MyAppointmentList({
    super.key,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    final appointments = _getFilteredAppointments();

    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
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
      itemCount: appointments.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return MyAppintmentCard(
          appointment: AppointmentData(
            doctorImage: appointment.doctorImage,
            doctorName: appointment.doctorName,
            specialty: appointment.specialty,
            hospitalName: appointment.hospitalName,
            date: appointment.date,
            time: appointment.time,
            type: appointment.type,
            amount: appointment.amount,
            status: appointment.status,
            paymentStatus: appointment.paymentStatus,
          ),
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

  List<MyAppointmentsModels> _getFilteredAppointments() {
    final allAppointments = _getAllAppointmentsData();

    switch (selectedTab) {
      case 0:
        return allAppointments
            .where((apt) => apt.status.toLowerCase() == 'pending')
            .toList();
      case 1:
        return allAppointments
            .where((apt) =>
                apt.status.toLowerCase() == 'confirmed' &&
                apt.paymentStatus.toLowerCase() == 'paid')
            .toList();
      case 2:
        return allAppointments
            .where((apt) =>
                apt.status.toLowerCase() == 'unconfirmed' &&
                apt.paymentStatus.toLowerCase() == 'unpaid')
            .toList();
      default:
        return [];
    }
  }

  List<MyAppointmentsModels> _getAllAppointmentsData() {
    return [
      MyAppointmentsModels(
        doctorImage: 'assets/svgs/general_speciality.svg',
        doctorName: 'Dr. Randy Wigham',
        specialty: 'Dentistry',
        hospitalName: 'City Hospital',
        date: 'Mon, 20 May',
        time: '09:00 AM',
        type: 'Checkup',
        amount: '200 EGP',
        status: 'Pending',
        paymentStatus: 'Unpaid',
      ),
      MyAppointmentsModels(
        doctorImage: 'assets/svgs/neurology_speciality.svg',
        doctorName: 'Dr. Eva Core',
        specialty: 'Neurology',
        hospitalName: 'Central Clinic',
        date: 'Tue, 21 May',
        time: '11:30 AM',
        type: 'Consultation',
        amount: '250 EGP',
        status: 'Pending',
        paymentStatus: 'Paid',
      ),
      MyAppointmentsModels(
        doctorImage: 'assets/svgs/cardiology_speciality.svg',
        doctorName: 'Dr. Hanna Stanton',
        specialty: 'Cardiology',
        hospitalName: 'Qena Hospital',
        date: 'Wed, 15 May',
        time: '08:30 AM',
        type: 'Follow-up',
        amount: '150 EGP',
        status: 'Confirmed',
        paymentStatus: 'Paid',
      ),
      MyAppointmentsModels(
        doctorImage: 'assets/svgs/orthopedics_speciality.svg',
        doctorName: 'Dr. Omar Yassin',
        specialty: 'Orthopedics',
        hospitalName: 'Hope Medical',
        date: 'Thu, 16 May',
        time: '02:00 PM',
        type: 'Surgery Consultation',
        amount: '500 EGP',
        status: 'Confirmed',
        paymentStatus: 'Paid',
      ),
      MyAppointmentsModels(
        doctorImage: 'assets/svgs/pediatrics_speciality.svg',
        doctorName: 'Dr. Jack Sulivan',
        specialty: 'Pediatrics',
        hospitalName: 'Marzoqy Hospital',
        date: 'Fri, 10 May',
        time: '10:00 AM',
        type: 'Vaccination',
        amount: '100 EGP',
        status: 'Unconfirmed',
        paymentStatus: 'Unpaid',
      ),
      MyAppointmentsModels(
        doctorImage: 'assets/svgs/general_speciality.svg',
        doctorName: 'Dr. Test Filter1',
        specialty: 'General',
        hospitalName: 'Test Hospital',
        date: 'Sat, 11 May',
        time: '01:00 PM',
        type: 'Checkup',
        amount: '50 EGP',
        status: 'Confirmed',
        paymentStatus: 'Unpaid',
      ),
      MyAppointmentsModels(
        doctorImage: 'assets/svgs/general_speciality.svg',
        doctorName: 'Dr. Test Filter2',
        specialty: 'General',
        hospitalName: 'Test Hospital',
        date: 'Sun, 12 May',
        time: '03:00 PM',
        type: 'Checkup',
        amount: '70 EGP',
        status: 'Unconfirmed',
        paymentStatus: 'Paid',
      ),
    ];
  }
}
