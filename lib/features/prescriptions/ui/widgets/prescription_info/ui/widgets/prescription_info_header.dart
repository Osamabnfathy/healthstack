import 'dart:core';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/data/models/prescription_info_model.dart';

class HeaderWidget extends StatelessWidget {
  final PrescriptionData prescription;

  const HeaderWidget({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
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
                    
                    Text('Name: ${prescription.patient.name}', style: TextStyles.font12DarkBluMedium),
                    
                    Text('Address: ${prescription.patient.address}', style: TextStyles.font12DarkBluMedium),
                    
                    Text('Email: ${prescription.patient.email}', style: TextStyles.font12DarkBluMedium),
                    
                    Text('Phone: ${prescription.patient.phoneNumber}', style: TextStyles.font12DarkBluMedium),
                  ],
                ),
              ),
              horizontalSpace(16),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prescription ID: ${prescription.prescriptionId}', style: TextStyles.font12DarkBluMedium),
                  verticalSpace(4),
                  
                  Text('Patient ID: ${prescription.patientId}', style: TextStyles.font12DarkBluMedium),
                  verticalSpace(4),
                  
                  Text('Date: ${DateFormat('dd-MM-yyyy').format(prescription.date)}', style: TextStyles.font12DarkBluMedium),
                ],
              ),
            ],
          ),
          verticalSpace(12),
          _buildDivider(),
          
          verticalSpace(12),
          Text('Doctor Information', style: TextStyles.font14DarkBlueBold),
          
          verticalSpace(4),
          Text('Name: ${prescription.doctor.name}', style: TextStyles.font12DarkBluMedium),
          
          Text('Department: ${prescription.doctor.department}', style: TextStyles.font12DarkBluMedium),
          
          Text('Email: ${prescription.doctor.email}', style: TextStyles.font12DarkBluMedium),
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