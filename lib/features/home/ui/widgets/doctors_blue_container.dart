import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import '../../../../core/theming/styles.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsBlueContainer extends StatelessWidget {
  const DoctorsBlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubitInstance = context.read<HomeCubit>();
    
    /// here i need to pass a matched data of the doctor's hospital and department
    // final enrichedDoctors = getEnrichedDoctors(
    //   doctors: homeCubitInstance.doctorsDataList ?? [], 
    //   hospitals: homeCubitInstance.hospitalsDataList ?? [], 
    //   departments: homeCubitInstance.departmentsDataList ?? [],
    // );
    
    return SizedBox(
      height: 195.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        
        children: [
          Container(
            height: 165.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              image: const DecorationImage(
                image: AssetImage('assets/images/home_blue_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book and\nschedule with\nnearest doctor',
                  style: TextStyles.font18WhiteMedium,
                  textAlign: TextAlign.start,
                ),
                verticalSpace(16),
                
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        Routes.doctorsScreen,
                        arguments: homeCubitInstance,
                      );
                    },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),),
                    ),
                    
                    child: Text(
                      'Doctors List',
                      style: TextStyles.font14BlueSemiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Positioned(
            right: 8.w,
            child: Image.asset(
              'assets/images/doctor-book.png',
              fit: BoxFit.cover, 
              height: 200.h,
              width: 160.w,
            ),
          ),
        ],
      ),
    );
  }
}
