
import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/styles.dart';

class AboutText extends StatelessWidget {
  const AboutText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who We Are',
          style: TextStyles.font20DarkBlueBold,
        ),
        verticalSpace(5),
        
        Text(
          'MediCare is an online platform connecting multiple hospitals, '
          'offering emergency medical assistance. It allows tracking, '
          'monitoring, and sharing of patient health records across hospitals. '
          'Patients can access information about hospitals and doctors, and '
          'schedule appointments online.',
          style: TextStyles.font16GrayRegular,
        ),
        verticalSpace(20),
        
        Text(
          'Our Vision',
          style: TextStyles.font20DarkBlueBold,
        ),
        verticalSpace(5),
        
        Text(
          'To provide high-quality healthcare services to patients from all over the Country.',
          style: TextStyles.font16GrayRegular,
        ),
        verticalSpace(20),
        
        Text(
          'Our Mission',
          style: TextStyles.font20DarkBlueBold,
        ),
        verticalSpace(10),
        
        Text(
          "To provide high-quality healthcare services through a qualified medical staff and a safe environment for patients.",
          style: TextStyles.font16GrayRegular,
        ),
      ],
    );
  }
}
