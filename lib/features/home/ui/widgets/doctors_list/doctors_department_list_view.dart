import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_list_view_item.dart';

class DoctorsDepartmentListView extends StatelessWidget {
  final List<DoctorsResponseModel>? doctorsDataList; 
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  final int? departmentId; 

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
            physics: ScrollPhysics(),
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
          if (showSeeAll)
            Padding(
              padding: EdgeInsets.fromLTRB(0.w, 10.h, 0, 10.w),
              child: AppTextButton(
              buttonText: "See All",
              textStyle: TextStyles.font16WhiteSemiBold,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.departmentDoctorsScreen,
                  arguments: {
                    'departmentId': departmentId,
                    'hospitalsDataList': hospitalsDataList,
                    'departmentsDataList': departmentsDataList,
                    'doctorsDataList': doctorsDataList,
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}