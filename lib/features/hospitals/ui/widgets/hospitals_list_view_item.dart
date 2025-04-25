import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospital_details/hospital_details_screen.dart';

class HospitalsListViewItem extends StatelessWidget {
  final int? itemIndex;
  final HospitalsResponseModel? hospitalsData;
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<SpecializationsResponseModel>? specializationsDataList;

  const HospitalsListViewItem({
    super.key,
    this.itemIndex,
    this.hospitalsData,
    this.doctorsDataList,
    this.specializationsDataList,
  });

  @override
  Widget build(BuildContext context) {
    final Widget placeholderImage = Image.asset(
      'assets/icons/hospital.png', 
      height: 110.h, 
      width: 120.w,
      fit: BoxFit.fill, 
    );
    
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HospitalDetailsScreen(
              hospitalsData: hospitalsData,
              doctorsData: doctorsDataList,
              specializationsData: specializationsDataList,
            ),
          ),
        );
      },
    
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorsManager.lightBlue,
          boxShadow: [
            BoxShadow(
              color: ColorsManager.gray.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: hospitalsData?.featuredImage != null && hospitalsData!.featuredImage!.isNotEmpty
                  ? Image.network(
                    hospitalsData!.featuredImage!, 
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
                    hospitalsData?.name ?? 'Hospital',
                    style: TextStyles.font18DarkBlueBold,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                  
                  Text(
                    'Phone: ${getDisplayText(hospitalsData?.phoneNumber.toString())}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                  
                  Text(
                    'Email: ${getDisplayText(hospitalsData?.email)}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                  
                  Text(
                    'Address: ${getDisplayText(hospitalsData?.address)}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}