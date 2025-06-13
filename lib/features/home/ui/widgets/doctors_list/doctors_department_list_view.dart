import 'package:flutter/material.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_list_view_item.dart';

class DoctorsDepartmentListView extends StatelessWidget {
  final List<DoctorsResponseModel>? doctorsDataList; 
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  final int? departmentId; // Pass this to the "See All" screen

  const DoctorsDepartmentListView({
    super.key, 
    this.doctorsDataList,
    this.hospitalsDataList,
    this.departmentsDataList,
    this.departmentId,
  });

  @override
  Widget build(BuildContext context) {
    final doctors = doctorsDataList ?? [];
    final showSeeAll = doctors.length > 2;
    final displayDoctors = showSeeAll ? doctors.take(2).toList() : doctors;

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: displayDoctors.length,
            itemBuilder: (context, index) {
              return DoctorsDepartmentListViewItem(
                itemIndex: index,
                doctorsData: displayDoctors[index],
                hospitalsDataList: hospitalsDataList,
                departmentsDataList: departmentsDataList,
              );
            },
          ),
        ],
      ),
    );
  }
}