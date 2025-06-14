import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class AboutUsTeam extends StatelessWidget {
  const AboutUsTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorsManager.lightBlue.withOpacity(0.3),
            ColorsManager.lightBlue.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            'Meet Our Team',
            style: TextStyles.font20DarkBlueBold,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            'Dedicated professionals working to improve healthcare',
            style: TextStyles.font14GrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(20),
          Row(
            children: [
              Expanded(
                child: _buildTeamMember(
                  'Medical Experts',
                  'Qualified doctors and healthcare professionals',
                  Icons.medical_services_outlined,
                ),
              ),
              horizontalSpace(15),
              Expanded(
                child: _buildTeamMember(
                  'Tech Team',
                  'Innovative developers and engineers',
                  Icons.computer_outlined,
                ),
              ),
            ],
          ),
          verticalSpace(15),
          _buildTeamMember(
            'Support Staff',
            'Dedicated customer service and administrative team',
            Icons.support_agent_outlined,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(
    String title,
    String description,
    IconData icon, {
    bool isFullWidth = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isFullWidth
          ? Row(
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
                    size: 20.sp,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyles.font14DarkBlueMedium,
                      ),
                      Text(
                        description,
                        style: TextStyles.font12GrayRegular,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
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
                    size: 20.sp,
                  ),
                ),
                verticalSpace(8),
                Text(
                  title,
                  style: TextStyles.font14DarkBlueMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(4),
                Text(
                  description,
                  style: TextStyles.font12GrayRegular,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}