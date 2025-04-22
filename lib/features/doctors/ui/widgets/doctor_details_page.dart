import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

class DoctorDetailsPage extends StatelessWidget {
  final DoctorsResponseModel? doctorsData;
  final List<HospitalsResponseModel>? hospitalsData;
  final List<SpecializationsResponseModel>? specializationsData;

  const DoctorDetailsPage({
    super.key, 
    required this.doctorsData,
    required this.hospitalsData,
    required this.specializationsData,  
  });

  @override
  Widget build(BuildContext context) {
    // Find the hospital name
    String? hospitalName;
    if (doctorsData?.hospitalName != null && hospitalsData != null) {
      final matchingHospital = hospitalsData!.firstWhere(
        (hospital) => hospital.hospitalId == doctorsData!.hospitalName,
        orElse: () => HospitalsResponseModel(hospitalId: null, name: 'Unknown Hospital'),
      );
      hospitalName = matchingHospital.name;
    }

    // // Find the specialization name
    // String? specializationName;
    // if (doctorsData?.departmentName != null && specializationsData != null) {
    //   final matchingSpecialization = specializationsData!.firstWhere(
    //     (specialization) => specialization.hospitalDepartmentId == doctorsData!.specialization,
    //     orElse: () => SpecializationsResponseModel(hospitalDepartmentId: null, hospitalDepartmentName: 'Unknown Specialization'),
    //   );
    //   specializationName = matchingSpecialization.hospitalDepartmentName;
    // }
  
    final Widget placeholderImage = Image.asset(
      'assets/icons/doctor.png',
      height: 150.h,
      width: 150.w,
      fit: BoxFit.cover,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        
        title: Text(
          doctorsData?.name ?? 'Doctor Details',
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined, 
            color: ColorsManager.darkBlue
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: doctorsData?.featuredImage != null && doctorsData!.featuredImage!.isNotEmpty
                    ? Image.network(
                        doctorsData!.featuredImage!,
                        height: 150.h,
                        width: 150.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => placeholderImage,
                      )
                    : placeholderImage,
              ),
            ),
            verticalSpace(20.h),

            // Doctor's Name
            Center(
              child: Text(
                getDisplayText(doctorsData?.name),
                style: TextStyles.font20DarkBlueBold,
              ),
            ),
            verticalSpace(10.h),

            // Doctor's Phone Number
            Text(
              'Phone Number: ${getDisplayText(doctorsData?.phoneNumber)}',
              style: TextStyles.font16GrayMedium,
            ),
            verticalSpace(10.h),

            // Doctor's Email
            Text(
              'Email: ${getDisplayText(doctorsData?.email)}',
              style: TextStyles.font16GrayMedium,
            ),
            verticalSpace(10.h),

            // Doctor's Fees
            Text(
              'Consultation Fee: ${getDisplayText(doctorsData?.consultationFee.toString())}',
              style: TextStyles.font16GrayMedium,
            ),
            verticalSpace(10.h),

            Text(
              'Report Fee: ${getDisplayText(doctorsData?.reportFee.toString())}',
              style: TextStyles.font16GrayMedium,
            ),
            verticalSpace(10.h),

            // Doctor's Visiting Hours
            Text(
              'Visiting Hours: ${getDisplayText(doctorsData?.visitingHour)}',
              style: TextStyles.font16GrayMedium,
            ),
            verticalSpace(10.h),
            
             // Doctor's Hospital
            Text(
              'Hospital: $hospitalName',
              style: TextStyles.font16GrayMedium,
            ),
            verticalSpace(10.h),

            Text(
              'Department: ${getDisplayText(doctorsData?.department)}',
              style: TextStyles.font16GrayMedium,
            ),
            verticalSpace(10.h),

            // Doctor's Description
            Text(
              'Description:',
              style: TextStyles.font18DarkBlueBold,
            ),
            verticalSpace(5.h),
            Text(
              doctorsData?.description ?? 'No description available.',
              style: TextStyles.font14GrayRegular,
            ),
          ],
        ),
      ),
    );
  }
}