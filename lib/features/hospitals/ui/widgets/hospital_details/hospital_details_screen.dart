import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

class HospitalDetailsScreen extends StatelessWidget {
  final HospitalsResponseModel? hospitalsData ;
  final List<DoctorsResponseModel>? doctorsData;
  final List<SpecializationsResponseModel>? specializationsData;

  const HospitalDetailsScreen({
    super.key, 
    required this.doctorsData,
    required this.hospitalsData,
    required this.specializationsData,  
  });

  @override
  Widget build(BuildContext context) {
    
    final Widget placeholderImage = Image.asset(
      'assets/icons/hospital.png',
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
            
          },
          buttonText: "See Hospital Doctors",
          textStyle: TextStyles.font18WhiteMedium,
          backgroundColor: ColorsManager.mainBlue,
          borderRadius: 12.0.r,
          buttonHeight: 55.0.h,
        ),
      ),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: hospitalsData?.featuredImage != null && hospitalsData!.featuredImage!.isNotEmpty
                    ? Image.network(
                        hospitalsData!.featuredImage!,
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
                      getDisplayText(hospitalsData?.name),
                      style: TextStyles.font20DarkBlueBold,
                    ),
                    verticalSpace(5.h),
                    
                    Text(
                      getDisplayText(hospitalsData?.address),
                      style: TextStyles.font16GrayMedium,
                    ),
                    verticalSpace(5.h),
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
              "   ${getDisplayText(hospitalsData?.description)}",
              style: TextStyles.font14GrayRegular,
            ),
            verticalSpace(20.h),
            
            buildInfoRow('Phone', getDisplayText(hospitalsData?.phoneNumber.toString())),
            
            buildInfoRow('Email', getDisplayText(hospitalsData?.email)),
            
            buildInfoRow('Hospital Type', getDisplayText(hospitalsData?.hospitalType)),
            
            buildInfoRow('General Beds', getDisplayText(hospitalsData?.generalBedNo.toString())),
            
            buildInfoRow('Regular Beds', getDisplayText(hospitalsData?.regularCabinNo.toString())),
            
            buildInfoRow('VIP Beds', getDisplayText(hospitalsData?.vipCabinNo.toString())),
          ],
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