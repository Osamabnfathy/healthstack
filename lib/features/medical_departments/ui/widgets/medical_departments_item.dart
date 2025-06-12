// lib/features/doctor_speciality/ui/widgets/speciality_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class MedicalDepartmentsItem extends StatelessWidget {
  final String iconAsset;
  final String name;
  final VoidCallback onTap;

  const MedicalDepartmentsItem({
    super.key,
    required this.iconAsset,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: ColorsManager.lightBlue,
            child: SvgPicture.asset(
              iconAsset,
              width: 42.w,
              height: 42.h,
            ),
          ),
          verticalSpace(8),
          Text(
            name,
            style: TextStyles.font13DarkBlueMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}