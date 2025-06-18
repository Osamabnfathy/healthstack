import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/medical_reports/ui/widgets/medical_report_card.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/medical_reports/logic/cubit/medical_reports_cubit.dart';
import 'package:healthstack/features/medical_reports/logic/cubit/medical_reports_state.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';

class MedicalReportList extends StatelessWidget {
  final List<DoctorsResponseModel>? doctors;
  final List<HospitalsResponseModel>? hospitals;
  final List<DepartmentsResponseModel>? departments;
  final PatientProfileResponseModel? patientProfileData;
  
  const MedicalReportList({
    super.key,
    this.doctors,
    this.hospitals,
    this.departments,
    this.patientProfileData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalReportsCubit, MedicalReportsState<MedicalReportsResponseModel>>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator(color: ColorsManager.mainBlue,)),
        
          loading: () => const Center(child: CircularProgressIndicator(color: ColorsManager.mainBlue,)),
        
          success: (medicalReports) {
            if (medicalReports.report!.isEmpty) {
              return _buildEmptyState();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: medicalReports.report!.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors?.firstWhere(
                        (d) => d.doctorId == medicalReports.report![index].doctor,
                        orElse: () => DoctorsResponseModel(),
                      );

                      // Find hospital
                      final hospital = hospitals?.firstWhere(
                        (h) => h.hospitalId == doctor?.hospitalName,
                        orElse: () => HospitalsResponseModel(),
                      );

                      // Find department
                      final department = departments?.firstWhere(
                        (d) => d.hospitalDepartmentId == doctor?.departmentName,
                        orElse: () => DepartmentsResponseModel(),
                      );

                      return MedicalReportCard(
                        medicalReportsData: medicalReports,
                        medicalReport: medicalReports.report![index],
                        doctorImage: doctor?.featuredImage ?? "",
                        doctorName: doctor?.name ?? "",
                        doctorEmail: doctor?.email ?? "",
                        hospitalName: hospital?.name ?? "",
                        departmentName: department?.hospitalDepartmentName ?? "",
                        patientProfileData: patientProfileData,
                      );
                    },
                  ),
                ),
              ],
            );
          },
          
          error: (error) {
            print('Error fetching prescriptions list: $error');
            return Center(
              child: Text(
                'Error fetching prescriptions',
                style: TextStyles.font15DarkBlueMedium,
              ),
            );
          },
        );
      },    
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64.sp,
            color: ColorsManager.lightGray,
          ),
          verticalSpace(16),
          
          Text(
            'No medical reports found',
            style: TextStyles.font15DarkBlueMedium,
          ),
        ],
      ),
    );
  }
}