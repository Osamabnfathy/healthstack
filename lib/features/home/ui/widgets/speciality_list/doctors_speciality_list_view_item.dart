import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

class DoctorsSpecialityListViewItem extends StatelessWidget {
  final int? itemIndex;
  final SpecializationsResponseModel? specializationsData;
  final List<HospitalsResponseModel>? hospitalsDataList;

  const DoctorsSpecialityListViewItem({
    super.key,
    this.itemIndex, 
    this.specializationsData,
    this.hospitalsDataList,
  });
  

  @override
  Widget build(BuildContext context) {
    String? hospitalName;
    if (specializationsData?.hospital != null && hospitalsDataList != null) {
      final matchingHospital = hospitalsDataList!.firstWhere(
        (hospital) => hospital.hospitalId == specializationsData!.hospital,
        orElse: () => HospitalsResponseModel(hospitalId: null, name: 'Unknown Hospital'),
      );
      hospitalName = matchingHospital.name;
      print('matching hospital: ${matchingHospital.name}');
    }
  
    final Widget placeholderImage = Image.asset(
      'assets/icons/general.png', 
      height: 60.h, 
      width: 60.w,
      fit: BoxFit.fill, 
    );

    return Container(
      padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 35, 
            backgroundColor: ColorsManager.lightBlue,
            
            child: ClipOval( 
              child: specializationsData?.featuredImage != null && specializationsData!.featuredImage!.isNotEmpty
                ? Image.network(
                    specializationsData!.featuredImage!, 
                    height: 60.h, 
                    width: 60.w, 
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
          ),
          verticalSpace(8.h),
          
          
          Text(
            specializationsData?.hospitalDepartmentName ?? 'Specialization',
            style: TextStyles.font12DarkBlueRegular,
            maxLines: 1, // Prevent long names from wrapping excessively
            overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
          ),
          
          Text(
            getDisplayText(hospitalName), // display the name of the hospital here 
            style: TextStyles.font12GrayMedium,
            maxLines: 1, // Prevent long names from wrapping excessively
            overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
          ),
        ],
      ),
    );
  }
}