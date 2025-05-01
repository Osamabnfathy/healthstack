import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StepsNumbers extends StatelessWidget {
  const StepsNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            _stepCircle(1, true),
            verticalSpace(6),
            Text(
              "Date & Time",
              style: TextStyles.font13BlueRegular.copyWith(fontSize: 11.sp),
            ),
          ],
        ),
        
        Baseline(
          baseline: -8.h,
          baselineType: TextBaseline.alphabetic,
          child: Row(
            children: [
              // horizontalSpace(10),
              _line(),
              _line(),
              _line(),
              horizontalSpace(10),
            ],
          ),
        ),
        
        Column(
          children: [
            _stepCircle(2, false),
            verticalSpace(6),
            Text(
              "Booking",
              style: TextStyles.font13GrayRegular.copyWith(fontSize: 11.sp),
            ),
          ],
        ),
      ],
    );
  }

  Widget _stepCircle(int number, bool active) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: active ? ColorsManager.mainBlue : ColorsManager.lighterGray,
      
      child: Text(
        "$number",
        style: TextStyle(color: active ? ColorsManager.lightBlue : ColorsManager.darkBlue),
      ),
    );
  }

  Widget _line() {
    return Container(
      width: 55.w,
      height: 2.h,
      color: Colors.grey.shade300,
    );
  }
}
