import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescriptions_list.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/prescriptions/logic/cubit/prescriptions_cubit.dart';

class PrescriptionsScreen extends StatelessWidget {
  final List<DoctorsResponseModel>? doctors;
  final List<HospitalsResponseModel>? hospitals;
  final List<DepartmentsResponseModel>? departments;
  final PatientProfileResponseModel? patientProfileData;

  const PrescriptionsScreen({
    super.key,
    this.doctors,
    this.hospitals,
    this.departments,
    this.patientProfileData,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PrescriptionsCubit>().getMyPrescriptions();
    });

    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(children: [
            const CustomTopBar(title: 'Prescriptions'),
            verticalSpace(5),
            Expanded(
              child: PrescriptionsList(
                doctors: doctors,
                hospitals: hospitals,
                departments: departments,
                patientProfileData: patientProfileData,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
