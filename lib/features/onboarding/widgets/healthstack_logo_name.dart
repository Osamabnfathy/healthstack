import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/styles.dart';

class HealthstackLogoAndName extends StatelessWidget {
  const HealthstackLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Baseline(
          baseline: 25.h,
          baselineType: TextBaseline.alphabetic,
          child: Image.asset('assets/icons/medicare.png',)
        ),
        SizedBox(width: 10.w,),
        
        Text(
          'MediCare',
          style: TextStyles.font24BlackBold,
        ),
      ],
    );
  }
}