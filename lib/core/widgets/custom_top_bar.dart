import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class CustomTopBar extends StatelessWidget {
  final String title;

  const CustomTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              size: 20.sp,
              color: ColorsManager.darkBlue,
            ),
          ),
          horizontalSpace(20),
          Expanded(
            child: Text(
              title,
              style: TextStyles.font18DarkBlueBold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}