import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/styles.dart';


class ContactHeader extends StatelessWidget {
  const ContactHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          
          child: Image.asset("assets/images/contactUs.jpg", 
            height: 260.h,
            width: 380.w,
          ),
        ),
        
        Positioned(
          bottom: 10, left: 0, right: 0,
          child: Text(
            'GET IN TOUCH!\nWe\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
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
