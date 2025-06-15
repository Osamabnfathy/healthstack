import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class AboutUsContent extends StatelessWidget {
  const AboutUsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Who We Are Section
          _buildContentCard(
            icon: Icons.business_outlined,
            title: 'Who We Are',
            content: 'MediCare is a revolutionary online healthcare platform that bridges the gap between multiple hospitals and healthcare providers. \n\nWe specialize in emergency medical assistance, comprehensive patient record management, and seamless healthcare coordination across medical institutions.\n\nOur platform empowers patients with instant access to hospital information, qualified medical professionals, and convenient online appointment scheduling, making quality healthcare accessible to everyone.',
            gradient: LinearGradient(
              colors: [
                ColorsManager.mainBlue.withOpacity(0.1),
                ColorsManager.mainBlue.withOpacity(0.05),
              ],
            ),
          ),
          verticalSpace(20),
          // Mission & Vision Row
          _buildContentCard(
            icon: Icons.visibility_outlined,
            title: 'Our Vision',
            content: 'To provide high-quality healthcare services to patients from all over the country, ensuring no one is left behind in accessing quality medical care.',
            isCompact: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green.withOpacity(0.05),
                Colors.green.withOpacity(0.1),
              ],
            ),
          ),
          verticalSpace(20),
          _buildContentCard(
            icon: Icons.flag_outlined,
            title: 'Our Mission',
            content: 'To provide high-quality healthcare services through qualified medical staff and a safe environment for patients, leveraging technology for better healthcare outcomes.',
            isCompact: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.withOpacity(0.05),
                Colors.orange.withOpacity(0.1),
              ],
            ),
          ),
              
        ],
      ),
    );
  }

  Widget _buildContentCard({
    required IconData icon,
    required String title,
    required String content,
    required Gradient gradient,
    bool isCompact = false,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.lightGray.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorsManager.mainBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: ColorsManager.mainBlue,
                  size: isCompact ? 20.sp : 24.sp,
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: Text(
                  title,
                  style: isCompact 
                      ? TextStyles.font18DarkBlueBold
                      : TextStyles.font20DarkBlueBold,
                ),
              ),
            ],
          ),
          verticalSpace(10),
          Text(
            content,
            style: isCompact 
                ? TextStyles.font14GrayRegular
                : TextStyles.font16GrayRegular,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}