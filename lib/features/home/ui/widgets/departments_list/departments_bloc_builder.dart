import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/departments_list/department_list_view.dart';
import 'package:healthstack/features/home/ui/widgets/departments_list/departments_shimmer_loading.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_shimmer_loading.dart';

class DepartmentsBlocBuilder extends StatelessWidget {
  final int? selectedIndex;
  final Function(int departmentId)? onDepartmentSelected;
  final Function(List<DepartmentsResponseModel> departments)? onDepartmentsLoaded;

  const DepartmentsBlocBuilder({
    super.key, 
    this.selectedIndex,
    this.onDepartmentsLoaded,
    this.onDepartmentSelected,
  });

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
            return setupLoading();
          },
          
          departmentsSuccess: (departmentsResponseModel) {
            onDepartmentsLoaded?.call(departmentsResponseModel);
            return Column(
              children: [       
                DepartmentsListView(
                  selectedIndex: selectedIndex,
                  onDepartmentSelected: onDepartmentSelected,
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
    return Expanded(
      child: Column(
        children: [
          DepartmentsShimmerLoading(),
          verticalSpace(10),
          DoctorsShimmerLoading(),
        ]
      )      
    );
  }
}