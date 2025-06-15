import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/icon_text_row.dart';


class ConfirmationDoctorInfoCard extends StatelessWidget {
  final Map<String, dynamic> doctorInfo;
  final Map<String, dynamic> bookingInfo;

  const ConfirmationDoctorInfoCard({
    super.key,
    required this.doctorInfo,
    required this.bookingInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Doctor Information",
          style: TextStyles.font16DarkBlueBold,
        ),
        verticalSpace(5),
        
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorsManager.moreLightGray,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1200.r),
                child: Image.network(
                  width: 110.w,
                  height: 110.h,
                  fit: BoxFit.cover,
                  doctorInfo['Doctor Image'] ?? "",
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/icons/doctor.png",
                    width: 110.w,
                    height: 110.h,
                    fit: BoxFit.cover,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.moreLighterGray,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorsManager.mainBlue,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              horizontalSpace(12),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. ${getDisplayText(doctorInfo['Doctor Name'])}",
                      style: TextStyles.font16DarkBlueBold,
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis, 
                    ),
                    verticalSpace(4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.mainBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        getDisplayText(doctorInfo['Department Name']),
                        style: TextStyles.font15DarkBlueMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),     
                    verticalSpace(8),
                    buildInfoRow(Icons.local_hospital_sharp, getDisplayText(doctorInfo['Hospital Name'])),
                    // // Fees
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.payment,
                    //       size: 14.sp,
                    //       color: ColorsManager.gray,
                    //     ),
                    //     horizontalSpace(4),
                    //     Text(
                    //       'Fees: ${getDisplayText(bookingInfo[''].toString())} EGP',
                    //       style: TextStyles.font12GrayMedium,
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatReviewCount(int count) {
    if (count < 1000) return count.toString();
    return "${(count / 1000).toStringAsFixed(1)}k";
  }
}
