import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospital_details/hospital_doctors_screen.dart';

class HospitalDetailsScreen extends StatelessWidget {
  final HospitalsResponseModel? hospitalsData;
  final List<DoctorsResponseModel>? doctorsData;
  final List<DepartmentsResponseModel>? departmentsData;

  const HospitalDetailsScreen({
    super.key,
    required this.doctorsData,
    required this.hospitalsData,
    required this.departmentsData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                child: const CustomTopBar(title: 'Hospital Details'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(5), // Spacing after top bar
                      _buildHospitalProfileCard(), // Hospital Profile Card
                      _buildAboutSection(), // About Section
                      _buildContactInfoSection(), // Contact Information Section
                      _buildFacilitiesSection(), // Facilities Section
                      verticalSpace(20), // Spacing before button
                      _buildViewDoctorsButton(context), // Button moved to scrollable content
                      verticalSpace(10), // Bottom spacing
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewDoctorsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AppTextButton(
        onPressed: () {
          if (hospitalsData?.hospitalId != null && doctorsData != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HospitalDoctorsScreen(
                  doctorsData: doctorsData!,
                  hospitalId: hospitalsData!.hospitalId!,
                  hospitalsDataList: [hospitalsData!],
                  departmentsDataList: departmentsData,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unable to load doctors for this hospital.'),
              ),
            );
          }
        },
        buttonText: "View Hospital Doctors",
        textStyle: TextStyles.font18WhiteMedium,
        backgroundColor: ColorsManager.mainBlue,
        borderRadius: 12.0.r,
        buttonHeight: 55.0.h,
      ),
    );
  }

  Widget _buildHospitalProfileCard() {
    final Widget placeholderImage = Image.asset(
      'assets/icons/hospital.png', 
      height: 250.h, 
      width: double.infinity,
      fit: BoxFit.fill, 
    );

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkBlue.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hospital Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: hospitalsData?.featuredImage != null &&
                    hospitalsData!.featuredImage!.isNotEmpty
                ? Image.network(
                    hospitalsData!.featuredImage!,
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        placeholderImage,
                  )
                : placeholderImage,
          ),
          verticalSpace(20),
          // Hospital Name
          Text(
            getDisplayText(hospitalsData?.name),
            style: TextStyles.font20DarkBlueBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(8),
          // Hospital Type Badge
          if (hospitalsData?.hospitalType != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorsManager.mainBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                getDisplayText(hospitalsData?.hospitalType),
                style: TextStyles.font15DarkBlueMedium,
              ),
            ),
          verticalSpace(12),
          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                size: 18.sp,
                color: ColorsManager.gray,
              ),
              horizontalSpace(8),
              Expanded(
                child: Text(
                  getDisplayText(hospitalsData?.address),
                  style: TextStyles.font16GrayMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorsManager.mainBlue,
                size: 24.sp,
              ),
              horizontalSpace(8),
              Text(
                'About Hospital',
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
          verticalSpace(16),
          Text(
            getDisplayText(hospitalsData?.description?.trim()),
            style: TextStyles.font14GrayRegular.copyWith(height: 1.6.h),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.contact_phone,
                color: ColorsManager.mainBlue,
                size: 26.sp,
              ),
              horizontalSpace(8),
              Text(
                'Contact Information',
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
          verticalSpace(16),
          _buildContactTile(
            Icons.phone,
            'Phone',
            getDisplayText(hospitalsData?.phoneNumber?.toString()),
          ),
          _buildContactTile(
            Icons.email,
            'Email',
            getDisplayText(hospitalsData?.email),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilitiesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: ColorsManager.mainBlue,
                size: 24.sp,
              ),
              horizontalSpace(8),
              Text(
                'Hospital Facilities',
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
          verticalSpace(16),
          // Bed Capacity Cards
          Row(
            children: [
              Expanded(
                child: _buildFacilityCard(
                  'General Beds',
                  getDisplayText(hospitalsData?.generalBedNo?.toString()),
                  Icons.bed,
                  Colors.blue,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: _buildFacilityCard(
                  'Regular Cabins',
                  getDisplayText(hospitalsData?.regularCabinNo?.toString()),
                  Icons.room,
                  Colors.green,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          // VIP Beds Card (Full Width)
          _buildFacilityCard(
            'VIP Cabins',
            getDisplayText(hospitalsData?.vipCabinNo?.toString()),
            Icons.star,
            Colors.amber,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: ColorsManager.mainBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: 24.sp,
              color: ColorsManager.mainBlue,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.font14DarkBlueMedium,
                ),
                verticalSpace(4),
                Text(
                  value,
                  style: TextStyles.font14GrayRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityCard(
    String title,
    String count,
    IconData icon,
    Color color, {
    bool isFullWidth = false,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28.sp,
          ),
          verticalSpace(8),
          Text(
            title,
            style: TextStyles.font15DarkBlueMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(4),
          Text(
            count,
            style: TextStyles.font18DarkBlueBold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}