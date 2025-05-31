import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/font_weight_helper.dart';
import 'package:healthstack/core/theming/styles.dart';

class MyAppointmentTaps extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const MyAppointmentTaps({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTab('Upcoming', 0, context), // Pass context
        horizontalSpace(30),
        
        _buildTab('Completed', 1, context), // Pass context
        horizontalSpace(30),
        
        _buildTab('Cancelled', 2, context), // Pass context
      ],
    );
  }

  Widget _buildTab(String title, int index, BuildContext context) {
    final bool isActive = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        onTabChanged(index);
      },
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: isActive
                ? TextStyles.font15BlueBold
                : TextStyles.font14GrayRegular.copyWith(
                    fontWeight: FontWeightHelper.semiBold,
                    color: ColorsManager.gray),
          ),
          verticalSpace(8),
          
          if (isActive)
            Container(
              width: 66.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: ColorsManager.mainBlue,
                borderRadius: BorderRadius.circular(1.5.r),
              ),
            )
          else
            Container(
              width: 65.w,
              height: 3.h,
              color: Colors.transparent,
            ),
        ],
      ),
    );
  }
}
