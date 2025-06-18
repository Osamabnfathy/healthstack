import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';

import 'widgets/bottuns_list.dart';
import 'package:flutter/material.dart';
import 'widgets/drawer_top_buttons.dart';
import 'widgets/drawer_circular_edge.dart';
import 'widgets/drawer_profile_information.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndDrawer extends StatelessWidget {
  final PatientProfileResponseModel? patientProfileData;

  const EndDrawer({super.key, this.patientProfileData});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsManager.lighterGray,
      shadowColor: Colors.grey.withOpacity(0.3),
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileInformation(patientProfileData: patientProfileData),
          const CircularEdgeItemsDrawer(),
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 15.w, right: 15.w, bottom: 10.h),
            child: const MyAppointmentAndMedicalRecords(),
          ),
          const Expanded(child: ButtonsList()),
          verticalSpace(12)
        ],
      ),
    );
  }
}
