import 'package:flutter/material.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_list_view_item.dart';

class DepartmentDoctorsScreen extends StatelessWidget {
  final int departmentId;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  final List<DoctorsResponseModel>? doctorsDataList; 

  const DepartmentDoctorsScreen({
    super.key,
    required this.departmentId,
    this.hospitalsDataList,
    this.departmentsDataList,
    this.doctorsDataList,
  });

  @override
  Widget build(BuildContext context) {
    // You should fetch or receive the doctors list for this department
    final filteredDoctors = (doctorsDataList ?? [])
        .where((doc) => doc.departmentName == departmentId)
        .toList();
        
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: ListView.builder(
        itemCount: filteredDoctors.length,
        itemBuilder: (context, index) {
          return DoctorsDepartmentListViewItem(
            itemIndex: index,
            doctorsData: filteredDoctors[index],
            hospitalsDataList: hospitalsDataList,
            departmentsDataList: departmentsDataList,
          );
        },
      ),
    );
  }
}