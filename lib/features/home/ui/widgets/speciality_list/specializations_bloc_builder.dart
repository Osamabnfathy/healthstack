import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/ui/widgets/speciality_list/doctors_speciality_list_view.dart';

class SpecializationsBlocBuilder extends StatelessWidget {
  const SpecializationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => 
        current is SpecializationsLoading ||
        current is SpecializationsSuccess ||
        current is SpecializationsError,
        
      builder: (context, state) {
        return state.maybeWhen(
          specializationsLoading: () {
            return setupLoading();
          },
          
          specializationsSuccess: (specializationsResponseModel) {
            return Column(
              children: [       
                DoctorsSpecialityListView(specializationsDataList: specializationsResponseModel,),
              ]
            );
          },
          
          specializationsError: (errorHandler) {
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