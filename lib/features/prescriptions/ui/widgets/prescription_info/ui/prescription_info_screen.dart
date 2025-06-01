import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/precscription_info_top.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_header.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_test.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/data/models/prescription_info_data.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/data/models/prescription_info_model.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_advice.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/ui/widgets/prescription_info_medicine.dart';

class PrescriptionInfoScreen extends StatelessWidget {
  const PrescriptionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrescriptionData prescription = getSamplePrescriptionData();

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              const PrescriptionsInfoTopBar(),
              verticalSpace(20),
              
              HeaderWidget(prescription: prescription),
              verticalSpace(16),
              
              MedicineSection(medicines: prescription.medicines),
              verticalSpace(16),
              
              TestSection(tests: prescription.tests),
              verticalSpace(16),
              
              AdviceSection(advice: prescription.advice),
              verticalSpace(24),
            ],
          ),
        ),
      ),
    );
  }
}
