import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/hospitals/logic/cubit/hospital_cubit.dart';
import 'package:healthstack/features/hospitals/logic/cubit/hospital_state.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_view.dart';

class HospitalsListBlocBuilder extends StatelessWidget {
  const HospitalsListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalCubit, HospitalState>(
      buildWhen: (previous, current) => 
        current is HospitalsLoading ||
        current is HospitalsSuccess ||
        current is HospitalsError,
        
      builder: (context, state) {
        return state.maybeWhen(
          hospitalsLoading: () {
            return setupLoading();
          },
          
          hospitalsSuccess: (hospitalsList) {
            return Column(
              children: [       
                HospitalsListView(hospitalsDataList: hospitalsList,),
              ]
            );
          },
          
          hospitalsError: (errorHandler) {
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