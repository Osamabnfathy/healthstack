import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/styles.dart';


class PrescriptionsTopBar extends StatelessWidget {
  const PrescriptionsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: ColorsManager.darkBlue,
          ),
        ),
        horizontalSpace(20),
        
        Expanded(
          child: Text(
            'Prescriptions',
            style: TextStyles.font18DarkBlueBold,
            textAlign: TextAlign.center,
          ),
        ),
        horizontalSpace(20),
      ],
    );
  }
}
