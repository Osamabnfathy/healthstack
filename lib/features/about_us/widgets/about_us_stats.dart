import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class AboutUsStats extends StatelessWidget {
  const AboutUsStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorsManager.darkBlue,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Our Impact',
           style: TextStyles.font24BlackBold.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            'Making a difference in healthcare delivery',
            style: TextStyles.font14LightGrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('50+', 'Partner\nHospitals'),
              _buildDivider(),
              _buildStatItem('1000+', 'Happy\nPatients'),
              _buildDivider(),
              _buildStatItem('24/7', 'Emergency\nSupport'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyles.font24BlackBold.copyWith(color: Colors.white),
        ),
        verticalSpace(4),
        Text(
          label,
          style: TextStyles.font14LightGrayRegular,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40.h,
      width: 1.w,
      color: ColorsManager.white.withOpacity(0.3),
    );
  }
}
