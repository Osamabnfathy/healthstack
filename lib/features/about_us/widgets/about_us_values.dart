import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/styles.dart';

class AboutUsValues extends StatelessWidget {
  const AboutUsValues({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Core Values',
            style: TextStyles.font20DarkBlueBold,
          ),
          verticalSpace(8),
          Text(
            'The principles that guide everything we do',
            style: TextStyles.font14GrayRegular,
          ),
          verticalSpace(20),
          Row(
            children: [
              Expanded(
                child: _buildValueCard(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Quality Care',
                  description: 'Ensuring the highest standards of medical care and patient safety',
                  color: Colors.red,
                ),
              ),
              horizontalSpace(15),
              Expanded(
                child: _buildValueCard(
                  icon: Icons.access_time_outlined,
                  title: 'Accessibility',
                  description: '24/7 availability and easy access to healthcare services',
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          verticalSpace(15),
          Row(
            children: [
              Expanded(
                child: _buildValueCard(
                  icon: Icons.security_outlined,
                  title: 'Privacy',
                  description: 'Protecting patient data with advanced security measures',
                  color: Colors.green,
                ),
              ),
              horizontalSpace(15),
              Expanded(
                child: _buildValueCard(
                  icon: Icons.lightbulb_outline,
                  title: 'Innovation',
                  description: 'Leveraging technology to improve healthcare delivery',
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          verticalSpace(8),
          Text(
            title,
           style: TextStyles.font16DarkBlueSemiBold,
          ),
          verticalSpace(4),
          Text(
            description,
            style: TextStyles.font12GrayRegular,
          ),
        ],
      ),
    );
  }
}