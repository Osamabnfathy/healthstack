import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/medical_reports/ui/widgets/medical_report_list.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/medical_reports/logic/cubit/medical_reports_cubit.dart';
import 'package:healthstack/features/medical_reports/ui/widgets/medical_report_top_bar.dart';

class MedicalReportScreen extends StatelessWidget {
  final List<DoctorsResponseModel>? doctors;
  final List<HospitalsResponseModel>? hospitals;
  final List<DepartmentsResponseModel>? departments;
  final PatientProfileResponseModel? patientProfileData;

  const MedicalReportScreen({
    super.key,
    this.doctors,
    this.hospitals,
    this.departments,
    this.patientProfileData,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MedicalReportsCubit>().getMyMedicalReports();
    });
    
    return Scaffold(
        backgroundColor: ColorsManager.lightBlue,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              children: [
                const MedicalReportTopBar(),
                verticalSpace(30),
                
                Expanded(
                  child: MedicalReportList(
                    doctors: doctors,
                    hospitals: hospitals,
                    departments: departments,
                    patientProfileData: patientProfileData,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
