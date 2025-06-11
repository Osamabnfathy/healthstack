import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctors_list_view.dart';

class DoctorsListBlocBuilder extends StatelessWidget {
  final String searchQuery;
  final bool isSorted;

  const DoctorsListBlocBuilder({
    super.key, 
    required this.searchQuery, 
    required this.isSorted
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        List<DoctorsResponseModel> doctorsDataList = homeCubit.doctorsDataList ?? [];
        final List<HospitalsResponseModel> hospitalsDataList = homeCubit.hospitalsDataList ?? [];
        final List<DepartmentsResponseModel> departmentsDataList = homeCubit.departmentsDataList ?? [];

        if (doctorsDataList.isEmpty && state is! DoctorsError) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorsError) {
          return Center(child: Text('Error loading doctors: ${state.error}'));
        }

        if (doctorsDataList.isNotEmpty) {
            doctorsDataList = List<DoctorsResponseModel>.from(doctorsDataList)
              ..sort((a, b) => isSorted
                  ? (a.name ?? '').compareTo(b.name ?? '')
                  : (b.name ?? '').compareTo(a.name ?? ''));
                
          return DoctorsListView(
            searchQuery: searchQuery,
            doctorsDataList: doctorsDataList,
            hospitalsDataList: hospitalsDataList,
            departmentsDataList: departmentsDataList,
          );
        }

        return const Center(child: Text('No doctors found.'));
      },
    );
  }
}