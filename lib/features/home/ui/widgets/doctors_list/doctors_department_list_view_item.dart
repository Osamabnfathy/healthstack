import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/icon_text_row.dart';
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
  
  String? _getDepartmentName(int? departmentId) {
    if (departmentId == null || departmentsDataList == null) return null;
    
    final matchingDepartment = departmentsDataList!.firstWhere(
      (dept) => dept.hospitalDepartmentId == departmentId,
      orElse: () => DepartmentsResponseModel(
        hospitalDepartmentId: null,
        hospitalDepartmentName: null,
      ),
    );
    
    return matchingDepartment.hospitalDepartmentName;
  }
  
  String? _getHospitalName(int? hospitalId) {
    if (hospitalId == null || hospitalsDataList == null) return null;
    
    final matchingHospital = hospitalsDataList!.firstWhere(
      (hospital) => hospital.hospitalId == hospitalId,
      orElse: () => HospitalsResponseModel(hospitalId: null, name: 'Unknown Hospital'),
    );
    
    return matchingHospital.name;
  }
  @override
  Widget build(BuildContext context) {
    final departmentName = _getDepartmentName(doctorsData?.departmentName);
    final hospitalName = _getHospitalName(doctorsData?.hospitalName);
    final Widget placeholderImage = Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray,
        borderRadius: BorderRadius.circular(1200.r),
      ),
      child: Image.asset(
        'assets/icons/doctor.png',
        width: 70.w,
        height: 70.h,
        fit: BoxFit.cover,
      )
    );
  
    return GestureDetector(
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsManager.moreLightGray,
          borderRadius: BorderRadius.circular(16.r),
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
              borderRadius: BorderRadius.circular(1200.r),
              child: doctorsData?.featuredImage != null && doctorsData!.featuredImage!.isNotEmpty
                  ? Image.network(
                    doctorsData!.featuredImage!, 
                    width: 100.w, 
                    height: 100.h, 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => placeholderImage,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 100.w,
                        height: 100.h,
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
                    }
                  )
                  : placeholderImage,
            ),
            horizontalSpace(16),
            
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Dr. ${getDisplayText(doctorsData?.name)}",
                    style: TextStyles.font16DarkBlueBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),         
                  verticalSpace(4), 
                  if (departmentName != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.mainBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        getDisplayText(departmentName),
                        style: TextStyles.font15DarkBlueMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),     
                  verticalSpace(8),
                  buildInfoRow(Icons.local_hospital_sharp, getDisplayText(hospitalName)),
                  buildInfoRow(Icons.phone, getDisplayText(doctorsData?.phoneNumber)),
                  buildInfoRow(Icons.schedule, getDisplayText(doctorsData?.visitingHour)),
                  Row(
                    children: [
                      Icon(
                        Icons.payment,
                        size: 14.sp,
                        color: ColorsManager.gray,
                      ),
                      horizontalSpace(4),
                      Flexible(
                        child: Text(
                          'Fees: ${getDisplayText(doctorsData?.reportFee?.toString())} - ${getDisplayText(doctorsData?.consultationFee?.toString())} EGP',
                          style: TextStyles.font12GrayMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ]
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