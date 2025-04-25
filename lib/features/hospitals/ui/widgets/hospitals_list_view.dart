import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_view_item.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

class HospitalsListView extends StatelessWidget {
  final String searchQuery;
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<SpecializationsResponseModel>? specializationsDataList;
  
  const HospitalsListView({
    super.key, 
    required this.searchQuery,
    required this.doctorsDataList,
    required this.hospitalsDataList,
    required this.specializationsDataList,
  });
  
  @override
  Widget build(BuildContext context) {
    final filteredHospitals = hospitalsDataList?.where((hospital) {
      final name = hospital.name?.toLowerCase() ?? '';
      return name.contains(searchQuery);
    }).toList();

    return filteredHospitals == null || filteredHospitals.isEmpty
        ? Center(child: Text('Nothing Match', style: TextStyles.font18DarkBlueSemiBold,))
        : ListView.builder(
            itemCount: filteredHospitals.length,
            itemBuilder: (context, index) {
              return HospitalsListViewItem(
                doctorsDataList: doctorsDataList,
                hospitalsData: filteredHospitals[index],
                specializationsDataList: specializationsDataList,
              );
            },
          );
  }
}

