import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/onboarding/widgets/doctor_image_and_text.dart';
import 'package:healthstack/features/onboarding/widgets/get_started_button.dart';
import 'package:healthstack/features/onboarding/widgets/healthstack_logo_name.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
            
            child: Column(
              children: [
                const HealthstackLogoAndName(),
                
                // verticalSpace(70),
                SizedBox(height: 30.h,),
                
                const DoctorImageAndText(),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      // verticalSpace(20),
                      SizedBox(height: 20.h,),
                      Text(
                        'Manage and schedule all of your medical appointments easily with Us.\nWe\'ll help you to get a new experience.',
                        style: TextStyles.font13GrayRegular,
                        textAlign: TextAlign.center,
                      ),
                      // verticalSpace(30),
                      SizedBox(height: 30.h,),
                      const GetStartedButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
