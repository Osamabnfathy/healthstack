import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/ui/widgets/departments_list/doctors_department_list_view.dart';

class DepartmentsBlocBuilder extends StatelessWidget {
  const DepartmentsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => 
        current is DepartmentsLoading ||
        current is DepartmentsSuccess ||
        current is DepartmentsError,
        
      builder: (context, state) {
        return state.maybeWhen(
          departmentsLoading: () {
            return SizedBox.shrink();
            // return setupLoading();
          },
          
          departmentsSuccess: (departmentsResponseModel) {
            return Column(
              children: [       
                DoctorsDepartmentListView(
                  departmentsDataList: departmentsResponseModel,
                  hospitalsDataList: context.read<HomeCubit>().hospitalsDataList,
                ),
              ]
            );
          },
          
          departmentsError: (errorHandler) {
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
    return const SizedBox(
      height: 50,
      child: CircularProgressIndicator(
        color: ColorsManager.mainBlue,
      ),
    );
  }
}