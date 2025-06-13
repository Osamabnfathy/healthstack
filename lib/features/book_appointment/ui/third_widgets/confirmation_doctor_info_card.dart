import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/styles.dart';

class ConfirmationDoctorInfoCard extends StatelessWidget {
  final Map<dynamic, dynamic> doctorInfo;

  const ConfirmationDoctorInfoCard({
    super.key,
    required this.doctorInfo,
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
        verticalSpace(15),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  width: 90.w,
                  height: 100.h,
                  doctorInfo['Doctor Image'] ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/icons/doctor.png",
                    width: 90.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorInfo['Doctor Name'] ?? "",
                      style: TextStyles.font16DarkBlueBold,
                    ),
                    verticalSpace(5),
                    Text(
                      getDisplayText(doctorInfo['Department Name']),
                      style: TextStyles.font13GrayRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(4),
                    Text(
                      getDisplayText(doctorInfo['Hospital Name']),
                      style: TextStyles.font13GrayRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(4),
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
