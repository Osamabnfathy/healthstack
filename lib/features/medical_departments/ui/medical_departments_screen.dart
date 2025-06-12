// lib/features/doctor_speciality/ui/screens/doctor_speciality_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/medical_departments/ui/widgets/medical_departments_grid_view.dart';
import 'package:healthstack/features/medical_departments/ui/widgets/medical_departments_top_bar.dart';

class MedicalDepartmentsScreen extends StatelessWidget {
  const MedicalDepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MedicalDepartmentsTopBar(),
                verticalSpace(32),
                const MedicalDepartmentsGridView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}