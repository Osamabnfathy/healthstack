import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointment_list.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointment_taps.dart';
import 'package:healthstack/features/my_appointment/ui/widgets/my_appointment_top_bar.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<MyAppointmentScreen> {
  int selectedTabIndex = 0;

  void _onTabChanged(int index) {
    if (mounted) {
      setState(() {
        selectedTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              verticalSpace(10),
              const MyAppointmentTopBar(),
              verticalSpace(24),
              MyAppointmentTaps(
                selectedIndex: selectedTabIndex,
                onTabChanged: _onTabChanged,
              ),
              verticalSpace(20),
              Expanded(
                child: MyAppointmentList(selectedTab: selectedTabIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
