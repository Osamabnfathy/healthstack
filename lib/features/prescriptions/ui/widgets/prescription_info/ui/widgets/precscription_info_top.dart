import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PrescriptionsInfoTopBar extends StatelessWidget {
  const PrescriptionsInfoTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h), 
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
              color: ColorsManager.mainBlue),
          ),
          
          horizontalSpace(20), 
          Expanded(
            child: Text(
              'Prescription Information',
              style: TextStyles.font18DarkBlueBold, 
              textAlign: TextAlign.center,
            ),
          ),
          horizontalSpace(20.w + 20.sp), 
        ],
      ),
    );
  }
}