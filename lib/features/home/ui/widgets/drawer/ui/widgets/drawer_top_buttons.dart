import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';


class MyAppointmentAndMedicalRecords extends StatelessWidget {
  const MyAppointmentAndMedicalRecords({super.key});

  Widget _buildQuickActionItem(BuildContext context, String title, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyles.font14DarkBlueMedium),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.white, // Top buttons color
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            _buildQuickActionItem(
              context,
              'Appointments',
              () {
                final homeCubit = context.read<HomeCubit>();
                print('Navigating with doctors: ${homeCubit.doctorsDataList}');
                print('Navigating with hospitals: ${homeCubit.hospitalsDataList}');
                print('Navigating with departments: ${homeCubit.departmentsDataList}'); 
                if (homeCubit.doctorsDataList!.isNotEmpty &&
                    homeCubit.hospitalsDataList!.isNotEmpty &&
                    homeCubit.departmentsDataList!.isNotEmpty) {
                  context.pushNamed(
                    Routes.appointmentScreen,
                    arguments: {
                      'doctors': homeCubit.doctorsDataList,
                      'hospitals': homeCubit.hospitalsDataList,
                      'departments': homeCubit.departmentsDataList,
                    },
                  );
                } 
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please wait, loading data...')),
                  );
                }
              }
            ),
            
            VerticalDivider(
              color: Colors.grey.shade300,
              thickness: 1,
              width: 1, // Keep width minimal
              indent: 10.h, // Optional: Add some vertical padding
              endIndent: 10.h,
            ),
            
            _buildQuickActionItem(
              context,
              'Prescriptions',
              () => context.pushNamed(Routes.prescriptionsScreen),
            ),
          ],
        ),
      ),
    );
  }
}
