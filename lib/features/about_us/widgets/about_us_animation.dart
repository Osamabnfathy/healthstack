import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:lottie/lottie.dart';

class AboutUsHero extends StatelessWidget {
  const AboutUsHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.mainBlue,
            ColorsManager.mainBlue.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Animation Container
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Lottie.asset(
                'assets/animations/about_us.json',
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
          ),
          verticalSpace(20),
          
          // Welcome Text
          Text(
            'Welcome to MediCare',
            style: TextStyles.font24BlueBold,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            'Connecting Healthcare, Caring for Lives',
            style: TextStyles.font14LightGrayRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}