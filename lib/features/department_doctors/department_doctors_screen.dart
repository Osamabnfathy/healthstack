import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
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
    final filteredDoctors = (doctorsDataList ?? [])
        .where((doc) => doc.departmentName == departmentId)
        .toList();
        
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              const CustomTopBar(title: 'Doctors'),
              verticalSpace(30),
              if (filteredDoctors.isEmpty)
                const Text('No doctors available for this department.'),
              if (filteredDoctors.isNotEmpty)
                Expanded(
                  child: ListView.builder(
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}