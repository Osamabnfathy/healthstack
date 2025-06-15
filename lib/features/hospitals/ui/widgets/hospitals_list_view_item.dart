import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/icon_text_row.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospital_details/hospital_details_screen.dart';

class HospitalsListViewItem extends StatelessWidget {
  final int? itemIndex;
  final HospitalsResponseModel? hospitalsData;
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;

  const HospitalsListViewItem({
    super.key,
    this.itemIndex,
    this.hospitalsData,
    this.doctorsDataList,
    this.departmentsDataList,
  });

  @override
  Widget build(BuildContext context) {
    final Widget placeholderImage = Image.asset(
      'assets/icons/hospital.png', 
      height: 110.h, 
      width: 100.w,
      fit: BoxFit.fill, 
    );
    
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HospitalDetailsScreen(
              hospitalsData: hospitalsData,
              doctorsData: doctorsDataList,
              departmentsData: departmentsDataList,
            ),
          ),
        );
      },
    
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsManager.moreLightGray,
          borderRadius: BorderRadius.circular(16),
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
                    width: 100.w, 
                    height: 110.h, 
                    fit: BoxFit.fill,
                    
                    errorBuilder: (context, error, stackTrace) => placeholderImage,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 100.w,
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
                  )
                  : placeholderImage,
            ),
            horizontalSpace(12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospitalsData?.name ?? 'Hospital',
                    style: TextStyles.font16DarkBlueBold,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(4), 
                  // Department Badge
                  if (hospitalsData?.hospitalType != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.mainBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        getDisplayText(hospitalsData?.hospitalType),
                        style: TextStyles.font15DarkBlueMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),     
                  verticalSpace(8),
                  buildInfoRow(Icons.phone, getDisplayText(hospitalsData?.phoneNumber.toString())),
                  buildInfoRow(Icons.email_rounded, getDisplayText(hospitalsData?.email)),
                  buildInfoRow(Icons.location_on, getDisplayText(hospitalsData?.address)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 2.w),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorsManager.gray.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}