import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';

class DepartmentDoctorsAndSeeall extends StatelessWidget {
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  final int? departmentId;
  
  const DepartmentDoctorsAndSeeall({
    super.key,
    this.doctorsDataList,
    this.hospitalsDataList,
    this.departmentsDataList,
    this.departmentId,
  });

  // Helper method to get department name
  String _getDepartmentName() {
    if (departmentId == null || departmentsDataList == null) {
      return 'Department Doctors';
    }
    
    try {
      final department = departmentsDataList!
          .firstWhere((dept) => dept.hospitalDepartmentId == departmentId);
      return '${department.hospitalDepartmentName} Doctors';
    } catch (e) {
      return 'Department Doctors';
    }
  }

  bool _hasDoctorsInDepartment() {
    if (departmentId == null || doctorsDataList == null) return false;
    
    return doctorsDataList!
        .any((doctor) => doctor.departmentName == departmentId);
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasDoctorsInDepartment()) {
      return const SizedBox.shrink();
    }
    return Row(
        children: [
          Expanded(
            child: Text(
              _getDepartmentName(),
              style: TextStyles.font18DarkBlueSemiBold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: () {
              context.pushNamed(
                Routes.departmentDoctorsScreen,
                arguments: {
                  'departmentId': departmentId,
                  'doctorsDataList': doctorsDataList,
                  'hospitalsDataList': hospitalsDataList,
                  'departmentsDataList': departmentsDataList,
                },
              );
            },
            borderRadius: BorderRadius.circular(4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See All',
                  style: TextStyles.font13BlueRegular,
                ),
                horizontalSpace(3),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 10.sp,
                  color: TextStyles.font13BlueRegular.color,
                ),
              ],
            ),
          ),
        ],
    );
  }
}