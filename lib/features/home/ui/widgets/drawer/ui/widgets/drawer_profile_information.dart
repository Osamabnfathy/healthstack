import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';

class ProfileInformation extends StatelessWidget {
  final PatientProfileResponseModel? patientProfileData;

  const ProfileInformation({super.key, this.patientProfileData});

  @override
  Widget build(BuildContext context) {
    final homeCubitInstance = context.read<HomeCubit>();
    
    return Container(
      color: ColorsManager.lightBlue,
      padding: EdgeInsets.only(top: 40.h, bottom: 20.h, left: 20.w, right: 20.w),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context), 
                child: Icon(Icons.arrow_back, color: ColorsManager.darkBlue, size: 22.sp,),
              ),
            ],
          ),
          verticalSpace(10),
          
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                
                decoration: BoxDecoration(
                  color: Colors.purple.shade50, 
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManager.mainBlue.withOpacity(0.5), width: 3),
                ),
                
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70.r),
                  child: patientProfileData?.featuredImage != null && patientProfileData!.featuredImage!.isNotEmpty
                    ? Image.network(
                        patientProfileData!.featuredImage!,
                        fit: BoxFit.cover,
                        width: 90.w,
                        height: 90.h,
                      )
                    : SvgPicture.asset(
                        'assets/svgs/general_speciality.svg',
                        fit: BoxFit.cover,
                        width: 90.w,
                        height: 90.h,
                      ),
                ),
              ),
              
              InkWell(
                onTap: () {
                  context.pushNamed(
                    Routes.editProfileScreen,
                    arguments: homeCubitInstance,
                  );
                },
                
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: ColorsManager.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  
                  child: Icon(Icons.edit, size: 16.sp, color: ColorsManager.mainBlue),
                ),
              ),
            ],
          ),
          verticalSpace(10),
          
            Text(
            getDisplayText(
              patientProfileData?.name?.split(' ').take(2).join(' ')
            ),
            style: TextStyles.font18DarkBlueBold,
            ),
            verticalSpace(4),
          
          Text(getDisplayText(patientProfileData?.email), style: TextStyles.font13GrayRegular),
        ],
      ),
    );
  }
}
