import 'widgets/bottuns_list.dart';
import 'package:flutter/material.dart';
import 'widgets/drawer_top_buttons.dart';
import 'widgets/drawer_circular_edge.dart';
import 'widgets/drawer_profile_information.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsManager.lighterGray,
      // ignore: deprecated_member_use
      shadowColor: Colors.grey.withOpacity(0.3),
      elevation: 10,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProfileInformation(),
          
          const CircularEdgeItemsDrawer(),
          
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
            child: const MyAppointmentAndMedicalRecords(),
          ),
          
          const Expanded(child: ButtonsList()),
        ],
      ),
    );
  }
}
