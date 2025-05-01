import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryStepsNumbers extends StatelessWidget {
  final int currentStep;

  const SummaryStepsNumbers({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            _stepCircle(1, currentStep >= 1, ColorsManager.green),
            verticalSpace(6),
            Text(
              "Date & Time",
              style: TextStyles.font13GreenRegular.copyWith(fontSize: 11.sp),
            ),
          ],
        ),
        
        Baseline(
          baseline: -8.h,
          baselineType: TextBaseline.alphabetic,
          child: Row(
            children: [
              // horizontalSpace(10),
              _line(true),
              _line(true),
              _line(true),
              horizontalSpace(10),
            ],
          ),
        ),
        
        Column(
          children: [
            _stepCircle(2, currentStep >= 2, ColorsManager.mainBlue),
            verticalSpace(6),
            Text(
              "Booking",
              style: TextStyles.font13BlueRegular.copyWith(fontSize: 11.sp),
            ),
          ],
        ),
      ],
    );
  }

  Widget _stepCircle(int number, bool active, Color activeColor) {
    return CircleAvatar(
      backgroundColor: active
          ? activeColor
          : number == 2
              ? ColorsManager.mainBlue
                  .withOpacity(0.3) // Light blue for inactive state
              : ColorsManager.lighterGray,
      radius: 16.r,
      
      child: Text(
        "$number",
        style: TextStyle(
          color: active ? Colors.white : ColorsManager.darkBlue,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _line(bool active) {
    return Container(
      width: 55.w,
      height: 2.h,
      color: active ? ColorsManager.green : ColorsManager.mainBlue,
    );
  }
}
