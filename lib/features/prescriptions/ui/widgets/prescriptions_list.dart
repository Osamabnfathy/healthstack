import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescriptions_card.dart';
import 'package:healthstack/features/prescriptions/logic/cubit/prescriptions_cubit.dart';
import 'package:healthstack/features/prescriptions/logic/cubit/prescriptions_state.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';

class PrescriptionsList extends StatelessWidget {
  final List<DoctorsResponseModel>? doctors;
  final List<HospitalsResponseModel>? hospitals;
  final List<DepartmentsResponseModel>? departments;
  final PatientProfileResponseModel? patientProfileData;

  const PrescriptionsList({
    super.key,
    this.doctors,
    this.hospitals,
    this.departments,
    this.patientProfileData,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrescriptionsCubit, PrescriptionsState<PrescriptionsResponseModel>>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          
          loading: () => const Center(child: CircularProgressIndicator()),
          
          success: (prescriptions) {
            if (prescriptions.prescriptions!.isEmpty) {
              return _buildEmptyState();
            }
            
            return Column(
              children: [
                _buildHeaderRow(),
                verticalSpace(16),
            
                Expanded(
                  child: ListView.builder(
                    itemCount: prescriptions.prescriptions!.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors?.firstWhere(
                        (d) => d.doctorId == prescriptions.prescriptions![index].doctor,
                        orElse: () => DoctorsResponseModel(),
                      );
                      
                      // Find hospital
                      final hospital = hospitals?.firstWhere(
                        (h) => h.hospitalId == doctor?.hospitalName,
                        orElse: () => HospitalsResponseModel(),
                      );
                      
                      // Find department
                      final department = departments?.firstWhere(
                        (dep) => dep.hospitalDepartmentId == doctor?.departmentName,
                        orElse: () => DepartmentsResponseModel(),
                      );
                    
                      return PrescriptionCard(
                        prescriptionsData: prescriptions,
                        prescriptions: prescriptions.prescriptions![index],
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

  Widget _buildHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.gray.withOpacity(0.2)),
        
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkBlue.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'ID',
              style: TextStyles.font16DarkBlueBold,
            ),
          ),
          horizontalSpace(16),
          
          Expanded(
            flex: 3,
            child: Text(
              'Doctor ',
              style: TextStyles.font16DarkBlueBold,
            ),
          ),
          horizontalSpace(60),
        ],
      ),
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
            'No prescriptions found',
            style: TextStyles.font15DarkBlueMedium,
          ),
        ],
      ),
    );
  }
}