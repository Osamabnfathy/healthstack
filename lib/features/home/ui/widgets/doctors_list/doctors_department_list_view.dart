import 'package:flutter/material.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_list_view_item.dart';

class DoctorsDepartmentListView extends StatelessWidget {
  final List<DoctorsResponseModel>? doctorsDataList; 
  const DoctorsDepartmentListView({super.key, this.doctorsDataList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctorsDataList?.length, // widget.specializationDataList.length,
      itemBuilder: (context, index) {
        return DoctorsDepartmentListViewItem(
          itemIndex: index,
          doctorsData: doctorsDataList?[index], // Replace with actual data model
        );
      },
    );
  }
}
