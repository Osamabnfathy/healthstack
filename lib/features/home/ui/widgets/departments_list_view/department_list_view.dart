import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/departments_list_view/department_list_view_item.dart';

class DepartmentsListView extends StatelessWidget {
  final int? selectedIndex;
  final Function(int departmentId)? onDepartmentSelected;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  
  const DepartmentsListView({
    super.key, 
    this.selectedIndex,
    this.hospitalsDataList,
    this.departmentsDataList,
    this.onDepartmentSelected,  
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      width: double.infinity,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: departmentsDataList!.length > 20 ? 20 : departmentsDataList!.length, 
        itemBuilder: (context, index) {
          return DepartmentsListViewItem(
            itemIndex: index,
            selectedIndex: selectedIndex,
            hospitalsDataList: hospitalsDataList,
            onDepartmentSelected: onDepartmentSelected,
            departmentsData: departmentsDataList?[index],
          );
        },
      ),
    );
  }
}

