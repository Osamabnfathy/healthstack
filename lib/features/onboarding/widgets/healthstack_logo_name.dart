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
        Image.asset('assets/icons/healthstack_logo.png',),
        SizedBox(width: 10.w,),
        Text(
          'Health Stack',
          style: TextStyles.font24BlackBold,
        ),
      ],
    );
  }
}