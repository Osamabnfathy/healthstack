import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointments_list.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointments_taps.dart';
import 'package:healthstack/features/my_appointment/logic/cubit/my_appointments_cubit.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointments_top_bar.dart';

class MyAppointmentScreen extends StatefulWidget {
  final List<DoctorsResponseModel>? doctors;
  final List<HospitalsResponseModel>? hospitals;
  final List<DepartmentsResponseModel>? departments;
  
  const MyAppointmentScreen({
    super.key,
    this.doctors,
    this.hospitals,
    this.departments,
  });

  @override
  State<MyAppointmentScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<MyAppointmentScreen> {
  int selectedTabIndex = 0;
  
  late List<DoctorsResponseModel>? doctors;
  late List<HospitalsResponseModel>? hospitals;
  late List<DepartmentsResponseModel>? departments;
  
  @override
  void initState() {
    super.initState();
    context.read<MyAppointmentsCubit>().getMyAppointments();
  }
  
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    doctors = widget.doctors ?? [];
    hospitals = widget.hospitals ?? [];
    departments = widget.departments ?? [];
    print('Doctors appointments: $doctors');
    print('Hospitals appointments: $hospitals');
    print('Departments appointments: $departments');
  }

  void _onTabChanged(int index) {
    if (mounted) {
      setState(() {
        selectedTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              verticalSpace(10),
              const MyAppointmentTopBar(),
              verticalSpace(24),
              
              MyAppointmentTaps(
                selectedIndex: selectedTabIndex,
                onTabChanged: _onTabChanged,
              ),
              verticalSpace(20),
              
              Expanded(
                child: MyAppointmentList(
                  selectedTab: selectedTabIndex,
                  doctors: doctors,
                  hospitals: hospitals,
                  departments: departments,  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
