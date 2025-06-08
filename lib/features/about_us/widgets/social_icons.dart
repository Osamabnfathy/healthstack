import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Us on Social Media',
          style: TextStyles.font20DarkBlueBold,
        ),
        verticalSpace(10),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(FontAwesomeIcons.facebook, color: ColorsManager.mainBlue, size: 35.sp),
            horizontalSpace(15),
            
            Icon(FontAwesomeIcons.twitter, color: ColorsManager.mainBlue, size: 35.sp),
            horizontalSpace(15),
            
            Icon(FontAwesomeIcons.linkedin, color: ColorsManager.mainBlue, size: 35.sp),
            horizontalSpace(15),
          
            Icon(FontAwesomeIcons.instagram, color: ColorsManager.mainBlue, size: 35.sp),
          ],
        ),
      ],
    );
  }
}
