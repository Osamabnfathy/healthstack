import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_list_view.dart';

class DoctorsDepartmentBlocBuilder extends StatelessWidget {
  final int? selectedDepartmentId;
  
  const DoctorsDepartmentBlocBuilder({
    super.key, 
    this.selectedDepartmentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => 
        current is DoctorsLoading ||
        current is DoctorsSuccess ||
        current is DoctorsError,
      
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        final List<HospitalsResponseModel> hospitalsDataList = homeCubit.hospitalsDataList ?? [];
        final List<DepartmentsResponseModel> departmentsDataList = homeCubit.departmentsDataList ?? [];
        return state.maybeWhen(
          doctorsLoading: () {
            return setupLoading();
          },
          
          doctorsSuccess: (doctorsResponseModel) {
            // Filter doctors based on the selected department
            final filteredDoctors = selectedDepartmentId != null
                ? doctorsResponseModel
                    .where((doctor) => doctor.departmentName == selectedDepartmentId)
                    .toList()
                : doctorsResponseModel;
            
            if (filteredDoctors.isEmpty) {
              return Column(
                children:[
                  verticalSpace(130),
                  Center(
                    child: Text(
                      "No doctors found in this department.",
                      style: TextStyles.font14DarkBlueMedium,
                    ),
                  ),
                ]
              );
            }
                
            return Expanded(
              child: DoctorsDepartmentListView(
                doctorsDataList: filteredDoctors,
                hospitalsDataList: hospitalsDataList,
                departmentsDataList: departmentsDataList,
                departmentId: selectedDepartmentId,
              )
            );
          },
          
          doctorsError: (errorHandler) {
            return const SizedBox.shrink();
          },
          
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
  
  Widget setupLoading() {
    return const SizedBox.shrink();
  }
}