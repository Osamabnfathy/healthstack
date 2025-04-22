import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';


class DoctorsListViewItem extends StatelessWidget {
  final DoctorsResponseModel? doctorsData;
  final int? itemIndex;

  const DoctorsListViewItem({
    super.key,
    this.doctorsData,
    this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final Widget placeholderImage = Image.asset(
      'assets/icons/doctor.png', 
      height: 110.h, 
      width: 120.w,
      fit: BoxFit.fill, 
    );
    
    return InkWell(
      onTap: () {
        // Handle tap event here, e.g., navigate to doctor details page
      },
    
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.gray.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: doctorsData?.featuredImage != null && doctorsData!.featuredImage!.isNotEmpty
                  ? Image.network(
                    doctorsData!.featuredImage!, 
                    width: 110.w, 
                    height: 120.h, 
                    fit: BoxFit.fill,
                    
                    errorBuilder: (context, error, stackTrace) => placeholderImage,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                  )
                  : placeholderImage,
            ),
            horizontalSpace(10.w),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorsData?.name ?? 'Doctor',
                    style: TextStyles.font18DarkBlueBold,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                  
                  Text(
                    'Phone: ${getDisplayText(doctorsData?.phoneNumber)}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                  
                  Text(
                    'Email: ${getDisplayText(doctorsData?.email)}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                  
                  Text(
                    'Working Hours: ${getDisplayText(doctorsData?.visitingHour)}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}