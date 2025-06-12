import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTopBar extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final String? patientName;

  const HomeTopBar({
    super.key,
    required this.onMenuPressed,
    this.patientName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${patientName?.split(' ').first ?? patientName} 👋',
              style: TextStyles.font18DarkBlueBold,
            ),
            Text(
              'How Are you Today?',
              style: TextStyles.font12GrayRegular,
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onMenuPressed,
          child: CircleAvatar(
            radius: 24.0,
            backgroundColor: ColorsManager.moreLighterGray,
            child: Image.asset(
              'assets/icons/drawer.png',
              height: 40.h,
              width: 40.w,
              color: ColorsManager.darkBlue,
            ),
          ),
        )
      ],
    );
  }
}
