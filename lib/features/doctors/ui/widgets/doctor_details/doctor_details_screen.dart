import 'package:flutter/material.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
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
        orElse: () =>
            HospitalsResponseModel(hospitalId: null, name: 'Unknown Hospital'),
      );
      hospitalName = matchingHospital.name;
    }

    String? departmentName;
    if (doctorsData?.departmentName != null && departmentsData != null) {
      final matchingDepartment = departmentsData!.firstWhere(
        (specialization) =>
            specialization.hospitalDepartmentId == doctorsData!.departmentName,
        orElse: () => DepartmentsResponseModel(
          hospitalDepartmentId: null,
          hospitalDepartmentName: 'Unknown Specialization',
        ),
      );
      departmentName = matchingDepartment.hospitalDepartmentName;
    }

    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              // Header with custom top bar
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CustomTopBar(title: 'Doctor Information'),
                      verticalSpace(30), // Spacing after top bar
                      _buildDoctorProfileCard(
                          hospitalName, departmentName), // Doctor Profile Card
                      _buildAboutSection(), // About Section
                      _buildContactInfoSection(), // Contact Information Section
                      _buildFeesSection(), // Fees Section
                      verticalSpace(20), // Spacing before button
                      _buildBookAppointmentButton(context, hospitalName,
                          departmentName), // Button moved to scrollable content
                      verticalSpace(20), // Bottom spacing
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

  Widget _buildBookAppointmentButton(
      BuildContext context, String? hospitalName, String? departmentName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
            },
          );
        },
        buttonText: "Book an Appointment",
        textStyle: TextStyles.font18WhiteMedium,
        backgroundColor: ColorsManager.mainBlue,
        borderRadius: 12.0.r,
        buttonHeight: 55.0.h,
      ),
    );
  }

  Widget _buildDoctorProfileCard(String? hospitalName, String? departmentName) {
    final Widget placeholderImage = Container(
      height: 200.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: ColorsManager.lightGray,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Icon(
        Icons.person,
        size: 80.sp,
        color: Colors.grey[400],
      ),
    );

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(24.w),
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
        children: [
          // Doctor Image
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: doctorsData?.featuredImage != null &&
                    doctorsData!.featuredImage!.isNotEmpty
                ? Image.network(
                    doctorsData!.featuredImage!,
                    height: 200.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        placeholderImage,
                  )
                : placeholderImage,
          ),
          verticalSpace(20),
          // Doctor Name
          Text(
            getDisplayText(doctorsData?.name),
            style: TextStyles.font20DarkBlueBold,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          // Department Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorsManager.mainBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              getDisplayText(departmentName),
              style: TextStyles.font14DarkBlueMedium,
            ),
          ),
          verticalSpace(12),
          // Hospital Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_hospital,
                size: 16.sp,
                color: ColorsManager.gray,
              ),
              horizontalSpace(6),
              Flexible(
                child: Text(
                  getDisplayText(hospitalName),
                  style: TextStyles.font16GrayMedium,
                  textAlign: TextAlign.center,
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
                'About Doctor',
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
          verticalSpace(16),
          Text(
            getDisplayText(doctorsData?.description),
            style: TextStyles.font14GrayRegular.copyWith(height: 1.6),
            textAlign: TextAlign.justify,
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
                size: 24.sp,
              ),
              horizontalSpace(8),
              Text(
                'Contact Information',
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
          verticalSpace(16),
          _buildInfoTile(
            Icons.phone,
            'Phone',
            getDisplayText(doctorsData?.phoneNumber),
          ),
          _buildInfoTile(
            Icons.email,
            'Email',
            getDisplayText(doctorsData?.email),
          ),
          _buildInfoTile(
            Icons.schedule,
            'Visiting Hours',
            getDisplayText(doctorsData?.visitingHour),
          ),
        ],
      ),
    );
  }

  Widget _buildFeesSection() {
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
                Icons.payment,
                color: ColorsManager.mainBlue,
                size: 24.sp,
              ),
              horizontalSpace(8),
              Text(
                'Consultation Fees',
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
          verticalSpace(16),
          Row(
            children: [
              Expanded(
                child: _buildFeeCard(
                  'Checkup Fee',
                  "${getDisplayText(doctorsData?.consultationFee.toString())} EGP",
                  Icons.medical_services,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: _buildFeeCard(
                  'Report Fee',
                  "${getDisplayText(doctorsData?.reportFee.toString())} EGP",
                  Icons.description,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
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
              size: 20.sp,
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

  Widget _buildFeeCard(String title, String amount, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.mainBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: ColorsManager.mainBlue,
            size: 24.sp,
          ),
          verticalSpace(8),
          Text(
            title,
            style: TextStyles.font15DarkBlueMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(4),
          Text(
            amount,
            style: TextStyles.font16DarkBlueBold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
