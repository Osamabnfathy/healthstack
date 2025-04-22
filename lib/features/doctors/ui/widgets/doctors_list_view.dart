import 'package:flutter/material.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctors_list_view_item.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';


class DoctorsListView extends StatelessWidget {
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<SpecializationsResponseModel>? specializationsDataList;

  const DoctorsListView({
    super.key,
    this.doctorsDataList,
    this.hospitalsDataList,
    this.specializationsDataList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: doctorsDataList?.length,
        itemBuilder: (context, index) {
          return DoctorsListViewItem(
            itemIndex: index,
            doctorsData: doctorsDataList?[index],
            hospitalsDataList: hospitalsDataList,
            specializationsDataList: specializationsDataList,
          );
        },
    );
  }
}