import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyles.font20DarkBlueBold,
        ),
        verticalSpace(10),
        
        Row(
          children: [
            Icon(Icons.location_on, color: ColorsManager.mainBlue),
            horizontalSpace(5),
            Expanded(
              child: Text(
                'Qena, Qena Government',
                style: TextStyles.font16GrayRegular,
              ),
            ),
          ],
        ),
        verticalSpace(5),
        
        Row(
          children: [
            Icon(Icons.phone, color: ColorsManager.mainBlue),
            horizontalSpace(5),
            Text(
              'Not Provided',
              style: TextStyles.font16GrayRegular,
            ),
          ],
        ),
        verticalSpace(5),
        
        Row(
          children: [
            Icon(Icons.email, color: ColorsManager.mainBlue),
            horizontalSpace(5),
            Text(
              'medicaresvu@gmail.com',
              style: TextStyles.font16GrayRegular,
            ),
          ],
        ),
      ],
    );
  }
}
