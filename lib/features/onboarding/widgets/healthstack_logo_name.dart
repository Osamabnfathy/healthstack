import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/styles.dart';

class HealthstackLogoAndName extends StatelessWidget {
  const HealthstackLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svgs/health_stack.svg',),
        SizedBox(width: 10.w,),
        Text(
          'Health Stack',
          style: TextStyles.font24BlackBold,
        ),
      ],
    );
  }
}