import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/features/about_us/widgets/about_text.dart';
import 'package:healthstack/features/about_us/widgets/contact_info.dart';
import 'package:healthstack/features/about_us/widgets/social_icons.dart';
import 'package:healthstack/features/about_us/widgets/about_us_animation.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomTopBar(title: 'About Us'),
              verticalSpace(30),    
              AboutUsAnimation(),
              verticalSpace(20),
              AboutText(),
              verticalSpace(20),
              ContactInfo(),
              verticalSpace(20),
              SocialIcons(),
            ]),
          ),
        ),
      ),
    );
  }
}