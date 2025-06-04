import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctor_details/doctor_details_screen.dart';

class DoctorsDepartmentListViewItem extends StatelessWidget {
  final DoctorsResponseModel? doctorsData;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  final int? itemIndex;
  
  const DoctorsDepartmentListViewItem({
    super.key,
    this.itemIndex,
    this.doctorsData,
    this.hospitalsDataList,
    this.departmentsDataList,
  });

  @override
  Widget build(BuildContext context) {
  
    final Widget placeholderImage = Image.asset(
      "assets/icons/doctor.png", 
      width: 110.w, 
      height: 120.h, 
      fit: BoxFit.cover,
    );
    
  
    return InkWell(
      onTap: () {
        if (doctorsData?.doctorId != null) {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(
                doctorsData: doctorsData,
                hospitalsData: hospitalsDataList,
                departmentsData: departmentsDataList,
              ),
            ),
          );
        }
      },
    
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: ColorsManager.lightBlue,
          boxShadow: [
            BoxShadow(
              color: ColorsManager.gray.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
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
                    fit: BoxFit.cover,
                  )
                  : placeholderImage,
            ),
            horizontalSpace(15),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. ${getDisplayText(doctorsData?.name)}" ,
                    style: TextStyles.font18DarkBlueBold,
                    maxLines: 1, // Prevent long names from wrapping excessively
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(5),
                  
                  Text(
                    'Phone: ${getDisplayText(doctorsData?.phoneNumber)}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(5),
                  
                  Text(
                    'Fees: ${getDisplayText(doctorsData?.reportFee.toString())} - ${getDisplayText(doctorsData?.consultationFee.toString())} EGP',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5),
                  
                  Text(
                    'Working Hours: ${getDisplayText(doctorsData?.visitingHour)}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, // Prevent long names from wrapping excessively
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}