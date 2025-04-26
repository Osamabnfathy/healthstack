import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';

class DoctorsDepartmentListViewItem extends StatelessWidget {
  final int? itemIndex;
  final DepartmentsResponseModel? departmentsData;
  final List<HospitalsResponseModel>? hospitalsDataList;

  const DoctorsDepartmentListViewItem({
    super.key,
    this.itemIndex, 
    this.departmentsData,
    this.hospitalsDataList,
  });
  

  @override
  Widget build(BuildContext context) {
    String? hospitalName;
    if (departmentsData?.hospital != null && hospitalsDataList != null) {
      final matchingHospital = hospitalsDataList!.firstWhere(
        (hospital) => hospital.hospitalId == departmentsData!.hospital,
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
              child: departmentsData?.featuredImage != null && departmentsData!.featuredImage!.isNotEmpty
                ? Image.network(
                    departmentsData!.featuredImage!, 
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
            departmentsData?.hospitalDepartmentName ?? 'Specialization',
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