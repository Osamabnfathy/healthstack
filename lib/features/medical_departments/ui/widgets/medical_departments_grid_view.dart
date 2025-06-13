import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/medical_departments/ui/widgets/medical_departments_item.dart';

class MedicalDepartmentsGridView extends StatelessWidget {
  final List<DepartmentsResponseModel>? departmentsDataList;
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;

  const MedicalDepartmentsGridView({
    super.key,
    this.departmentsDataList,
    this.doctorsDataList,
    this.hospitalsDataList,
  });

  @override
  Widget build(BuildContext context) {
    if (departmentsDataList == null || departmentsDataList!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_hospital_outlined,
              size: 64.sp,
              color: Colors.grey[400],
            ),
            verticalSpace(20),
            Text(
              'No departments available',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.61.h,
      ),
      itemCount: departmentsDataList!.length,
      itemBuilder: (context, index) {
        final department = departmentsDataList![index];
        
        final doctorsCount = (doctorsDataList ?? [])
            .where((doc) => doc.departmentName == department.hospitalDepartmentId)
            .length;
            
        final hospitalName = (hospitalsDataList ?? [])
            .where((h) => h.hospitalId == department.hospital)
            .firstOrNull?.name ?? 'Unknown Hospital';
        return MedicalDepartmentsItem(
          iconAsset: department.featuredImage ?? '', 
          name: department.hospitalDepartmentName ?? 'Unknown Department',
          hospitalName: hospitalName,
          doctorsCount: doctorsCount, 
          onTap: () {
            context.pushNamed(
              Routes.departmentDoctorsScreen,
              arguments: {
                'departmentId': department.hospitalDepartmentId,
                'doctorsDataList': doctorsDataList,
                'hospitalsDataList': hospitalsDataList,
                'departmentsDataList': departmentsDataList,
              },
            );
          },
        );
      },
    );
  }
}