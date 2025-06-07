import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.sp,
                color: ColorsManager.mainBlue,
              ),
            ),
            title: Text("About Us", style: TextStyles.font20BlueBold,),
          ),
          
          body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/medicare.png', 
                    width: 40,
                    height: 40,
                  ),
                  horizontalSpace(12),
                  
                  Baseline(
                    baseline: 36.sp,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      'MediCare',
                      style: TextStyles.font20BlueBold
                    ),
                  ),
                ],
              ),
              verticalSpace(15),
              
              Text(
                'MediCare is an online platform connecting multiple hospitals, '
                'offering emergency medical assistance. It allows tracking, '
                'monitoring, and sharing of patient health records across hospitals. '
                'Patients can access information about hospitals and doctors, and '
                'schedule appointments online.',
                style: TextStyles.font16GrayMedium
              ),
              verticalSpace(30),
              
                Divider(
                color: ColorsManager.gray,
                thickness: 1,
                height: 0.2,  
              ),
              verticalSpace(30),
    
              // Social Media Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(FontAwesomeIcons.facebook, color: ColorsManager.mainBlue,),
                  horizontalSpace(15),
                  
                  Icon(FontAwesomeIcons.twitter, color: ColorsManager.mainBlue,),
                  horizontalSpace(15),
                  
                  Icon(FontAwesomeIcons.linkedin, color: ColorsManager.mainBlue,),
                  horizontalSpace(15),
                
                  Icon(FontAwesomeIcons.instagram, color: ColorsManager.mainBlue,),
                  horizontalSpace(15),
                  
                  Icon(FontAwesomeIcons.dribbble, color: ColorsManager.mainBlue,),
                ],
              ),
              verticalSpace(33),
      
              Divider(
                color: ColorsManager.gray,
                thickness: 1,
                height: 0.2,  
              ),
              verticalSpace(33),
              
              // Contact Us Section
              Text(
                'Contact Us',
                style: TextStyles.font20BlueBold
              ),
              verticalSpace(16),
              
              Row(
                children: [
                  Icon(Icons.location_on, color: ColorsManager.gray),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Qena, Qena Government',
                      style: TextStyles.font18DarkBlueBold,
                    ),
                  ),
                ],
              ),
              verticalSpace(15),
              
              Row(
                children: [
                  Icon(Icons.phone, color: ColorsManager.gray),
                  SizedBox(width: 12.w),
                  Text(
                    'Not Provided',
                    style: TextStyles.font18DarkBlueBold
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              
              Row(
                children: [
                  Icon(Icons.email, color: ColorsManager.gray),
                  SizedBox(width: 12.w),
                  Text(
                    'medicaresvu@gmail.com',
                    style: TextStyles.font18DarkBlueBold
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
