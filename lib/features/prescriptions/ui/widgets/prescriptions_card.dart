import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_models.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/prescription_info_screen.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionCard({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.lightGray),
        
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkBlue.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Row(
        children: [
          _buildIdBadge(),
          horizontalSpace(12),
        
          _buildAvatar(),
          horizontalSpace(12),
        
          Expanded(
            child: _buildDoctorInfo(),
          ),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildIdBadge() {
    return Container(
      width: 35.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      
      child: Center(
        child: Text(
          '${prescription.id}',
          style: TextStyles.font14BlueSemiBold,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 30.r,
      backgroundImage: AssetImage(prescription.avatarUrl),
      backgroundColor: ColorsManager.lightGray,
      onBackgroundImageError: (_, __) {},
      
      child: prescription.avatarUrl.isEmpty
          ? Icon(
              Icons.person,
              color: ColorsManager.gray,
              size: 20.sp,
            )
          : null,
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prescription.doctorName,
          style: TextStyles.font14DarkBlueBold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpace(2),
        
        Text(
          '${prescription.specialization} | ${prescription.hospital}',
          style: TextStyles.font12GrayMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrescriptionInfoScreen(),
          ),
        );
      },
      
      icon: Icon(
        Icons.visibility,
        color: ColorsManager.green,
        size: 20.sp,
      ),
      constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
      padding: EdgeInsets.zero,
    );
  }
}