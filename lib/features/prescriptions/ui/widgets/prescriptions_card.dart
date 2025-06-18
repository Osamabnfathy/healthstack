import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/prescription_info_screen.dart';

class PrescriptionCard extends StatelessWidget {
  final PatientProfileResponseModel? patientProfileData;
  final PrescriptionsResponseModel prescriptionsData;
  final PrescriptionModel prescription;
  final String? doctorName;
  final String? doctorImage;
  final String? doctorEmail;
  final String? hospitalName;
  final String? departmentName;
  

  const PrescriptionCard({
    super.key,
    required this.prescription,
    required this.prescriptionsData,
    this.patientProfileData,
    this.doctorName,
    this.doctorImage,
    this.doctorEmail,
    this.hospitalName,
    this.departmentName
  });

  @override
  Widget build(BuildContext context) {    
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.lightGray),
        
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkBlue.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Row(
        children: [
          _buildAvatar(),
          horizontalSpace(10),
        
          Expanded(
            child: _buildDoctorInfo(),
          ),
          
          _buildActionButton(context),
        ],
      ),
    );
  }



  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 30.r,
      backgroundColor: ColorsManager.lightGray,
      
      backgroundImage: doctorImage != null && doctorImage!.isNotEmpty
                    ? NetworkImage(doctorImage!)
                    : Image.asset(
                        "assets/icons/doctor.png",
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.fill,
                      ).image,
                      
      onBackgroundImageError: (_, __) {},
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getDisplayText(doctorName),
          style: TextStyles.font14DarkBlueBold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpace(2),
        
        Text(
          '${getDisplayText(departmentName)} | ${getDisplayText(hospitalName)}',
          style: TextStyles.font12GrayMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrescriptionInfoScreen(
              prescription: prescription,
              prescriptionsData: prescriptionsData,
              patientProfileData: patientProfileData,
              doctorName: doctorName,
              doctorEmail: doctorEmail,
              hospitalName: hospitalName,
              departmentName: departmentName,
            ),
          ),
        );
      },
      
      icon: Icon(
        Icons.visibility,
        color: ColorsManager.green,
        size: 20.sp,
      ),
      constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
      padding: EdgeInsets.zero,
    );
  }
}