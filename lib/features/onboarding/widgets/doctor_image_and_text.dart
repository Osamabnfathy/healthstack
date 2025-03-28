// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';


class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/healthstack_logo_lowopacity.png',),
        
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.14, 0.4],
            ),
          ),
          
          child: Image.asset('assets/images/onboarding_doctor.png'),
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
