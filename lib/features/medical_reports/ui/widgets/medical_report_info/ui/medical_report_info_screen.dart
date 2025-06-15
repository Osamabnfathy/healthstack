import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';
import 'package:healthstack/features/medical_reports/ui/widgets/medical_report_info/ui/widgets/header.dart';
import 'package:healthstack/features/medical_reports/ui/widgets/medical_report_info/ui/widgets/other_informations.dart';
import 'package:healthstack/features/medical_reports/ui/widgets/medical_report_info/ui/widgets/specimen_details.dart';
import 'package:healthstack/features/medical_reports/ui/widgets/medical_report_info/ui/widgets/test_results.dart';


class MedicalReportInfoScreen extends StatelessWidget {
  final PatientProfileResponseModel? patientProfileData;
  final MedicalReportsResponseModel medicalReportsData;
  final ReportModel medicalReport;
  final String? doctorName;
  final String? doctorEmail;
  final String? hospitalName;
  final String? departmentName;
  
  const MedicalReportInfoScreen({
    super.key,
    this.patientProfileData,
    required this.medicalReportsData,
    required this.medicalReport,
    this.doctorName,
    this.doctorEmail,
    this.hospitalName,
    this.departmentName,
  });

  @override
  Widget build(BuildContext context) {
    final matchedspecimen = medicalReportsData.specimen
      ?.where((m) => m.report == medicalReport.reportId)
      .toList();
      
    final matchedTests = medicalReportsData.test
      ?.where((t) => t.report == medicalReport.reportId)
      .toList();

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: const CustomTopBar(title: "Medical Report Information"),
              ),
              verticalSpace(6),
              
              Header(
                patientProfileData: patientProfileData,
                medicalReport: medicalReport,
                doctorName: doctorName,
                doctorEmail: doctorEmail,
                hospitalName: hospitalName,
                departmentName: departmentName,
              ),
              verticalSpace(16),
              
              SpecimenDetailsSection(specimenDetails: matchedspecimen),
              verticalSpace(16),
              
              TestResultsSection(tests: matchedTests),
              verticalSpace(16),
              
              OtherInformations(advice: medicalReport.otherInformation),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
