import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeTopBar extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const HomeTopBar({
    super.key,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi,Osama ',
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
