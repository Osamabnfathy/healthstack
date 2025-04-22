import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctors_list_view.dart';

class DoctorsListBlocBuilder extends StatelessWidget {
  final String searchQuery;
  const DoctorsListBlocBuilder({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => 
        current is DoctorsLoading ||
        current is DoctorsSuccess ||
        current is DoctorsError,
      builder: (context, state) {
        return state.maybeWhen(
          doctorsLoading: () {
            return const SizedBox.shrink();
            // return setupLoading();
          },
          
          doctorsSuccess: (doctorsResponseModel) {
            // Filter doctors based on the search query
            final filteredDoctors = doctorsResponseModel.where((doctor) {
              final name = doctor.name?.toLowerCase() ?? '';
              return name.contains(searchQuery);
            }).toList();

            return DoctorsListView(
              doctorsDataList: filteredDoctors,
              hospitalsDataList: context.read<HomeCubit>().hospitalsDataList, 
              specializationsDataList: context.read<HomeCubit>().specializationsDataList, 
            );
          },
          
          doctorsError: (errorHandler) {
            return const SizedBox.shrink();
          },
          
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      }  
    );
  }
  
  Widget setupLoading() {
    return const SizedBox(
      height: 100,
      child: CircularProgressIndicator(
        color: ColorsManager.mainBlue,
      ),
    );
  }
}