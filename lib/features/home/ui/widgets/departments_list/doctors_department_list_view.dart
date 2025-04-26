import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/departments_list/doctors_speciality_list_view_item.dart';

class DoctorsDepartmentListView extends StatelessWidget {
  final List<DepartmentsResponseModel>? departmentsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;
  
  const DoctorsDepartmentListView({
    super.key, 
    this.departmentsDataList,
    this.hospitalsDataList  
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: departmentsDataList?.length, 
        itemBuilder: (context, index) {
          return DoctorsDepartmentListViewItem(
            itemIndex: index,
            departmentsData: departmentsDataList?[index],
            hospitalsDataList: hospitalsDataList,
          );
        },
      ),
    );
  }
}

