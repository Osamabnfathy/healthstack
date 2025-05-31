import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';

class ProfileInformation extends StatelessWidget {
  final PatientProfileResponseModel? patientProfileData;

  const ProfileInformation({super.key, this.patientProfileData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.lightBlue,
      padding: EdgeInsets.only(top: 40.h, bottom: 20.h, left: 20.w, right: 20.w),
      
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context), 
                child: Icon(Icons.arrow_back_ios_new_outlined, color: ColorsManager.darkBlue, size: 20.sp,),
              ),
            ],
          ),
          verticalSpace(15),
          
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 90.w,
                height: 90.h,
                
                decoration: BoxDecoration(
                  color: Colors.purple.shade50, 
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
                  child: patientProfileData?.featuredImage != null && patientProfileData!.featuredImage!.isNotEmpty
                    ? Image.network(
                        patientProfileData!.featuredImage!,
                        fit: BoxFit.fill,
                        width: 90.w,
                        height: 90.h,
                      )
                    : SvgPicture.asset(
                        'assets/svgs/general_speciality.svg',
                        fit: BoxFit.fill,
                        width: 90.w,
                        height: 90.h,
                      ),
                ),
              ),
              
              InkWell(
                onTap: () {
                  context.pushNamed(
                    Routes.profileScreen,
                    arguments: patientProfileData,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit, size: 16.sp, color: ColorsManager.mainBlue),
                ),
              ),
            ],
          ),
          verticalSpace(10),
          
          Text(getDisplayText(patientProfileData?.name), style: TextStyles.font18DarkBlueBold),
          verticalSpace(4),
          
          Text(getDisplayText(patientProfileData?.email), style: TextStyles.font13GrayRegular),
        ],
      ),
    );
  }
}
