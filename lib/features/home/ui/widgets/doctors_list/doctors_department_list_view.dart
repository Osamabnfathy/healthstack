import 'package:flutter/material.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_list_view_item.dart';

class DoctorsDepartmentListView extends StatelessWidget {
  final List<DoctorsResponseModel>? doctorsDataList; 
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  
  const DoctorsDepartmentListView({
    super.key, 
    this.doctorsDataList,
    this.hospitalsDataList,
    this.departmentsDataList,  
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctorsDataList?.length, 
      itemBuilder: (context, index) {
        return DoctorsDepartmentListViewItem(
          itemIndex: index,
          doctorsData: doctorsDataList?[index],
          hospitalsDataList: hospitalsDataList,
          departmentsDataList: departmentsDataList, 
        );
      },
    );
  }
}
