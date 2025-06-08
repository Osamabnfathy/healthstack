import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:lottie/lottie.dart';

class AboutUsAnimation extends StatelessWidget {
  const AboutUsAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        height: 250.h,
        decoration: BoxDecoration(
          color: ColorsManager.mainBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Lottie.asset(
          'assets/animations/about_us.json',
          repeat: true, 
        ),
      ),
    );
  }
}