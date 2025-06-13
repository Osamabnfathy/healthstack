import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';


class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
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
          
          Expanded(
            child: Text(
              'Edit Profile',
              style: TextStyles.font18DarkBlueBold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
