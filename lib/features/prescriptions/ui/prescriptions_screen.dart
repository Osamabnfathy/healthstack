import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescriptions_top_bar.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescriptions_list.dart';


class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
          child: Column(
            children: [
              const PrescriptionsTopBar(),
              verticalSpace(30),
              
              const Expanded(
                child: PrescriptionsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
