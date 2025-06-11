import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_view.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';

class HospitalsListBlocBuilder extends StatelessWidget {
  final String searchQuery;
  final bool isSorted; 

  const HospitalsListBlocBuilder({
    super.key, 
    required this.searchQuery,
    required this.isSorted,
  });
  
  @override
    Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        final List<DoctorsResponseModel> doctorsDataList = homeCubit.doctorsDataList ?? [];
        List<HospitalsResponseModel> hospitalsDataList = homeCubit.hospitalsDataList ?? [];
        final List<DepartmentsResponseModel> departmentsDataList = homeCubit.departmentsDataList ?? [];

        if (hospitalsDataList.isEmpty && state is! HospitalsError) {
          print("Showing Loading (Hospitals empty, not error, fetch incomplete)");
          return const Center(child: CircularProgressIndicator(color: ColorsManager.mainBlue,));
        }

        if (state is HospitalsError) {
          print("Showing Hospitals Error: ${state.error}");
          return Center(child: Text('Error loading hospitals: ${state.error}'));
        }

        if (hospitalsDataList.isNotEmpty) {
          hospitalsDataList = List<HospitalsResponseModel>.from(hospitalsDataList)
            ..sort((a, b) => isSorted
                ? (a.name ?? '').compareTo(b.name ?? '')
                : (b.name ?? '').compareTo(a.name ?? ''));
          
          return HospitalsListView(
            searchQuery: searchQuery,
            doctorsDataList: doctorsDataList,
            hospitalsDataList: hospitalsDataList,
            departmentsDataList: departmentsDataList,
          );
        }

        print("Showing 'No Hospitals found' (Fetch complete or error state not matched)");
        return const Center(child: Text('No Hospitals found.'));
      },
    );
  }
}