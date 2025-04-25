import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctor_details/doctor_details_screen.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';


class DoctorsListViewItem extends StatelessWidget {
  final int? itemIndex;
  final DoctorsResponseModel? doctorsData;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<SpecializationsResponseModel>? specializationsDataList;

  const DoctorsListViewItem({
    super.key,
    this.itemIndex,
    this.doctorsData,
    this.hospitalsDataList,
    this.specializationsDataList,
  });

  @override
  Widget build(BuildContext context) {
    String? hospitalName;
    if (doctorsData?.hospitalName != null && hospitalsDataList != null) {
      final matchingHospital = hospitalsDataList!.firstWhere(
        (hospital) => hospital.hospitalId == doctorsData!.hospitalName,
        orElse: () => HospitalsResponseModel(hospitalId: null, name: 'Unknown Hospital'),
      );
      hospitalName = matchingHospital.name;
      print('matching hospital: ${matchingHospital.name}');
    }
  
    final Widget placeholderImage = Image.asset(
      'assets/icons/doctor.png', 
      height: 110.h, 
      width: 120.w,
      fit: BoxFit.fill, 
    );
    
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(
              doctorsData: doctorsData,
              hospitalsData: hospitalsDataList,
              specializationsData: specializationsDataList,
            ),
          ),
        );
      },
    
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsManager.lightBlue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.gray.withOpacity(0.2),
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
                    'Fees: ${getDisplayText(doctorsData?.reportFee.toString())} - ${getDisplayText(doctorsData?.consultationFee.toString())}',
                    style: TextStyles.font12GrayMedium,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                  verticalSpace(5.h),
                  
                  Text(
                    'Hospital: ${getDisplayText(hospitalName)}',
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