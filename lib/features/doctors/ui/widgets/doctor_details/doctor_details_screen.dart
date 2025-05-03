import 'package:flutter/material.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorsResponseModel? doctorsData;
  final List<HospitalsResponseModel>? hospitalsData;
  final List<DepartmentsResponseModel>? departmentsData;

  const DoctorDetailsScreen({
    super.key, 
    required this.doctorsData,
    required this.hospitalsData,
    required this.departmentsData,  
  });

  @override
  Widget build(BuildContext context) {
    String? hospitalName;
    if (doctorsData?.hospitalName != null && hospitalsData != null) {
      final matchingHospital = hospitalsData!.firstWhere(
        (hospital) => hospital.hospitalId == doctorsData!.hospitalName,
        orElse: () => HospitalsResponseModel(hospitalId: null, name: 'Unknown Hospital'),
      );
      hospitalName = matchingHospital.name;
    }

    // Find the specialization name
    String? departmentName;
    if (doctorsData?.departmentName != null && departmentsData != null) {
      final matchingDepartment = departmentsData!.firstWhere(
        (specialization) => specialization.hospitalDepartmentId == doctorsData!.departmentName,
        orElse: () => DepartmentsResponseModel(
          hospitalDepartmentId: null,
          hospitalDepartmentName: 'Unknown Specialization',
        ),
      );
      departmentName = matchingDepartment.hospitalDepartmentName;
    }
    
    final Widget placeholderImage = Image.asset(
      'assets/icons/doctor.png',
      height: 150.h,
      width: 150.w,
      fit: BoxFit.cover,
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
      
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15.w),
        child: AppTextButton(
          onPressed: () {
            Navigator.pushNamed(
              context, 
              Routes.firstAppointmentScreen,
              arguments: {
                'visitingHour': doctorsData?.visitingHour,
                'doctorId': doctorsData?.doctorId,
                'doctorName': doctorsData?.name,
                'doctorImage': doctorsData?.featuredImage,
                'hospitalName': hospitalName, 
                'departmentName': departmentName, 
              }              
            );
          },
          buttonText: "Book an Appointment",
          textStyle: TextStyles.font18WhiteMedium,
          backgroundColor: ColorsManager.mainBlue,
          borderRadius: 12.0.r,
          buttonHeight: 55.0.h,
        ),
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal:20.w, vertical:10.h),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: doctorsData?.featuredImage != null && doctorsData!.featuredImage!.isNotEmpty
                        ? Image.network(
                          doctorsData!.featuredImage!,
                          height: 300.h,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) => placeholderImage,
                          )
                        : placeholderImage,
                  ),
                ),
                verticalSpace(15.h),
                
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.w,),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: ColorsManager.lightBlue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          getDisplayText(doctorsData?.name),
                          style: TextStyles.font20DarkBlueBold,
                        ),
                        verticalSpace(5.h),
                        
                        Text(
                          'Hospital: ${getDisplayText(hospitalName)}',
                          style: TextStyles.font16GrayMedium,
                        ),
                        verticalSpace(5.h),
            
                        Text(
                          'Department: ${getDisplayText(departmentName)}',
                          style: TextStyles.font16GrayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(10.h),
                    
                Text(
                  'Description:',
                  style: TextStyles.font18DarkBlueBold,
                ),
                verticalSpace(5.h),
                Text(
                  "   ${getDisplayText(doctorsData?.description)}",
                  style: TextStyles.font14GrayRegular,
                ),
                verticalSpace(20.h),

                buildInfoRow('Phone', getDisplayText(doctorsData?.phoneNumber)),
                
                buildInfoRow('Email', getDisplayText(doctorsData?.email)),
                
                buildInfoRow('Visiting Hours', getDisplayText(doctorsData?.visitingHour)),
                
                buildInfoRow('Consultation Fee', getDisplayText(doctorsData?.consultationFee.toString())),
                
                buildInfoRow('Report Fee', getDisplayText(doctorsData?.reportFee.toString())),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget buildInfoRow(String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '• $label: ',
              style: TextStyles.font14DarkBlueRegular,
            ),
            Text(
              value,
              style: TextStyles.font14GrayRegular,
            ),
          ],
        ),
        verticalSpace(10.h),
      ],
    );
  }
}