import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';

class DepartmentsAndSeeAll extends StatelessWidget {
  final List<DepartmentsResponseModel>? departmentsDataList;
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;

  const DepartmentsAndSeeAll({
    super.key,
    this.departmentsDataList,
    this.doctorsDataList,
    this.hospitalsDataList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Medical Departments',
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.pushNamed(
              Routes.medicalDepartmentsScreen,
              arguments: {
                'departmentsDataList': departmentsDataList,
                'doctorsDataList': doctorsDataList,
                'hospitalsDataList': hospitalsDataList,
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See All',
                style: TextStyles.font12BlueRegular,
              ),
              horizontalSpace(3),
              Icon(
                Icons.arrow_forward_ios,
                size: 10.sp,
                color: TextStyles.font12BlueRegular.color,
              ),
            ],
          ),
        )
      ],
    );
  }
}
