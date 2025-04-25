import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctors_list_view.dart';

class DoctorsListBlocBuilder extends StatelessWidget {
  final String searchQuery;

  const DoctorsListBlocBuilder({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        final List<DoctorsResponseModel> doctorsDataList = homeCubit.doctorsDataList ?? [];
        final List<HospitalsResponseModel> hospitalsDataList = homeCubit.hospitalsDataList ?? [];
        final List<SpecializationsResponseModel> specializationsDataList = homeCubit.specializationsDataList ?? [];

        if (doctorsDataList.isEmpty && state is! DoctorsError) {
          print("Showing Loading (Doctors empty, not error, fetch incomplete)");
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorsError) {
          print("Showing Doctors Error: ${state.error}");
          return Center(child: Text('Error loading doctors: ${state.error}'));
        }

        if (doctorsDataList.isNotEmpty) {
          print("Showing Filtered Doctors ListView with ${doctorsDataList.length} total doctors.");
          return DoctorsListView(
            searchQuery: searchQuery,
            doctorsDataList: doctorsDataList,
            hospitalsDataList: hospitalsDataList,
            specializationsDataList: specializationsDataList,
          );
        }

        print("Showing 'No doctors found' (Fetch complete or error state not matched)");
        return const Center(child: Text('No doctors found.'));
      },
    );
  }
}