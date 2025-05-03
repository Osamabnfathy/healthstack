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

class HospitalDoctorsScreen extends StatelessWidget {
  final int hospitalId;
  final List<DoctorsResponseModel>? doctorsData;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;

  const HospitalDoctorsScreen({
    super.key,
    required this.doctorsData,
    required this.hospitalId,
    required this.hospitalsDataList,
    required this.departmentsDataList,
  });

  @override
  Widget build(BuildContext context) {
    // Filter doctors based on the hospitalId
    final filteredDoctors = doctorsData?.where((doctor) {
      return doctor.hospitalName == hospitalId;
    }).toList();

    final Widget placeholderImage = Image.asset(
      'assets/icons/doctor.png',
      height: 110.h,
      width: 120.w,
      fit: BoxFit.fill,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: ColorsManager.darkBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      body: filteredDoctors!.isEmpty
          ? Center(
              child: Text(
                'No doctors found for this hospital.',
                style: TextStyles.font20DarkBlueSemiBold,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                String? departmentName;
                if (doctor.departmentName != null && departmentsDataList != null) {
                  final matchingSpecialization = departmentsDataList!.firstWhere(
                    (specialization) => specialization.hospitalDepartmentId == doctor.departmentName,
                    orElse: () => DepartmentsResponseModel(
                      hospitalDepartmentId: null,
                      hospitalDepartmentName: 'Unknown Specialization',
                    ),
                  );
                  departmentName = matchingSpecialization.hospitalDepartmentName;
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(
                          doctorsData: doctor,
                          hospitalsData: hospitalsDataList,
                          departmentsData: departmentsDataList,
                        ),
                      ),
                    );
                  },
                  
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
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
                          child: doctor.featuredImage != null && doctor.featuredImage!.isNotEmpty
                              ? Image.network(
                                  doctor.featuredImage ?? '',
                                  width: 110.w,
                                  height: 120.h,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) => placeholderImage,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                (loadingProgress.expectedTotalBytes ?? 1)
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
                                doctor.name ?? 'Doctor',
                                style: TextStyles.font18DarkBlueBold,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(5.h),
                              
                              Text(
                                'Phone: ${getDisplayText(doctor.phoneNumber)}',
                                style: TextStyles.font12GrayMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(5.h),
                              
                              Text(
                                'Fees: ${getDisplayText(doctor.reportFee.toString())} - ${getDisplayText(doctor.consultationFee.toString())}',
                                style: TextStyles.font12GrayMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(5.h),
                              
                              Text(
                                'Working Hours: ${getDisplayText(doctor.visitingHour)}',
                                style: TextStyles.font12GrayMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(5.h),
                              
                              Text(
                                'Department: ${getDisplayText(departmentName)}',
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
              },
            ),
    );
  }
}