import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <-- Add this
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/about_us/widgets/about_text.dart';
import 'package:healthstack/features/about_us/widgets/contact_info.dart';
import 'package:healthstack/features/about_us/widgets/social_icons.dart';
import 'package:healthstack/features/about_us/widgets/about_us_animation.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, 
        child: Scaffold(
          appBar: AppBar(
            title: Text('About Us', style: TextStyles.font20BlueBold,),
            backgroundColor: Colors.white, 
            centerTitle: true,
            
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.sp,
                color: ColorsManager.mainBlue,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AboutUsAnimation(),
                  verticalSpace(20), 
                  
                  AboutText(),
                  verticalSpace(20), 
                  
                  ContactInfo(),
                  verticalSpace(20), 
                  
                  SocialIcons(),
                ]  
              ),    
            ),
          ),
        ),
      ),
    );
  }
}