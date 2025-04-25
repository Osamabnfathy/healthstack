import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctors_list_view_item.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

class DoctorsListView extends StatelessWidget {
  final String searchQuery;
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<SpecializationsResponseModel>? specializationsDataList;

  const DoctorsListView({
    super.key, 
    required this.searchQuery,
    required this.doctorsDataList,
    required this.hospitalsDataList,
    required this.specializationsDataList,
  });
  
   @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctorsDataList?.where((doctor) {
      final name = doctor.name?.toLowerCase() ?? '';
      return name.contains(searchQuery);
    }).toList();

    return filteredDoctors == null || filteredDoctors.isEmpty
        ? Center(child: Text('Nothing Match', style: TextStyles.font18DarkBlueSemiBold,))
        : ListView.builder(
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              return DoctorsListViewItem(
                doctorsData: filteredDoctors[index],
                hospitalsDataList: hospitalsDataList,
                specializationsDataList: specializationsDataList,
              );
            },
          );
  }
}