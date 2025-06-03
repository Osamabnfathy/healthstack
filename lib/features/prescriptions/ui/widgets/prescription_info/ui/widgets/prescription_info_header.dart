import 'dart:core';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  final PatientProfileResponseModel? patientProfileData;
  final PrescriptionModel prescription;
  final String? doctorName;
  final String? doctorEmail;
  final String? hospitalName;
  final String? departmentName;

  const HeaderWidget({
    super.key,
    this.patientProfileData,
    required this.prescription,
    this.doctorName,
    this.doctorEmail,
    this.hospitalName,
    this.departmentName,
  });

  @override
  Widget build(BuildContext context) {
    String formatPrescriptionDate(String? date) {
      if (date == null) return '';
      try {
        final parsed = DateTime.parse(date);
        return DateFormat('MMM d, yyyy').format(parsed); 
      } catch (_) {
        return date;
      }
    }
  
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(10.r),
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Prescription To', style: TextStyles.font14DarkBlueBold),
                    verticalSpace(4),
                    
                    Text('Name: ${getDisplayText(patientProfileData!.name)}', style: TextStyles.font12DarkBluMedium),
                    
                    Text('Phone: ${getDisplayText(patientProfileData!.phoneNumber.toString())}', style: TextStyles.font12DarkBluMedium),
                    
                    Text('Address: ${getDisplayText(patientProfileData!.address)}', style: TextStyles.font12DarkBluMedium),
                    
                    Text('Email: ${getDisplayText(patientProfileData!.email)}', style: TextStyles.font12DarkBluMedium),
                  ],
                ),
              ),
              horizontalSpace(5),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient ID: ${getDisplayText(prescription.patient.toString())}', style: TextStyles.font12GrayRegular),
                  verticalSpace(4),
                  
                  Text('Prescription ID: ${getDisplayText(prescription.prescriptionId.toString())}', style: TextStyles.font12GrayRegular),
                  verticalSpace(4),
                  
                  Text('Date: ${getDisplayText(formatPrescriptionDate(prescription.createDate))}', style: TextStyles.font12GrayRegular),
                ],
              ),
            ],
          ),
          verticalSpace(12),
          _buildDivider(),
          verticalSpace(12),
          
          Text('Doctor Information', style: TextStyles.font14DarkBlueBold),
          
          verticalSpace(4),
          Text('Name: ${getDisplayText(doctorName)}', style: TextStyles.font12DarkBluMedium),
          
          Text('Email: ${getDisplayText(doctorEmail)}', style: TextStyles.font12DarkBluMedium),
          
          Text('Department: ${getDisplayText(departmentName)} | ${getDisplayText(hospitalName)}', style: TextStyles.font12DarkBluMedium),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: ColorsManager.moreLighterGray,
    );
  }
}