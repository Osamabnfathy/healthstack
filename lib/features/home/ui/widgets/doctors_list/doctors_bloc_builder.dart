import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_list_view.dart';

class DoctorsListBlocBuilder extends StatelessWidget {
  const DoctorsListBlocBuilder({super.key});

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
            return setupLoading();
          },
          
          doctorsSuccess: (doctorsList) {
            return Expanded(
              child: DoctorsListView(doctorsDataList: doctorsList,)
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
    return const SizedBox(
      height: 100,
      child: CircularProgressIndicator(
        color: ColorsManager.mainBlue,
      ),
    );
  }
}