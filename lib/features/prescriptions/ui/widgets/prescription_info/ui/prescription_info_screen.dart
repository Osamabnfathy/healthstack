import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_app_bar.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_advice.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_header.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_medicine.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_test.dart';

class PrescriptionInfoScreen extends StatelessWidget {
  final PatientProfileResponseModel? patientProfileData;
  final PrescriptionsResponseModel prescriptionsData;
  final PrescriptionModel prescription;
  final String? doctorName;
  final String? doctorEmail;
  final String? hospitalName;
  final String? departmentName;

  const PrescriptionInfoScreen({
    super.key,
    this.patientProfileData,
    required this.prescriptionsData,
    required this.prescription,
    this.doctorName,
    this.doctorEmail,
    this.hospitalName,
    this.departmentName,
  });

  @override
  Widget build(BuildContext context) {
    final matchedMedicines = prescriptionsData.prescriptionsMedicine
      ?.where((m) => m.prescription == prescription.prescriptionId)
      .toList();
      
    final matchedTests = prescriptionsData.prescriptionsTest
      ?.where((t) => t.prescription == prescription.prescriptionId)
      .toList();
  
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: const CustomAppBar(title: "Prescription Information",backgroundColor: ColorsManager.lightBlue,),
              ),
              verticalSpace(6),
              
              HeaderWidget(
                patientProfileData: patientProfileData,
                prescription: prescription,
                doctorName: doctorName,
                doctorEmail: doctorEmail,
                hospitalName: hospitalName,
                departmentName: departmentName,
              ),
              verticalSpace(16),
              MedicineSection(medicines: matchedMedicines),
              verticalSpace(16),
              TestSection(tests: matchedTests),
              verticalSpace(16),
              AdviceSection(advice: prescription.extraInformation),
              verticalSpace(24),
            ],
          ),
        ),
      ),
    );
  }
}
