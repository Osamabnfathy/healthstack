// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/styles.dart';


class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset('assets/images/healthstack_logo_lowopacity.png',),
        verticalSpace(50),
        
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.14, 0.6],
            ),
          ),
          
          child: Image.asset('assets/images/doctors.png', 
            height: 480.h,
            width: 380.w,
          ),
        ),
        
        Positioned(
          bottom: 10, left: 0, right: 0,
          child: Text(
            'Best Doctors\nAppointment App',
            textAlign: TextAlign.center,
            style: TextStyles.font32BlueBold.copyWith(
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
