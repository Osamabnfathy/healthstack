import 'widgets/home_top_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/speciality_and_see_all.dart';
import 'widgets/doctors_blue_container.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/ui/widgets/drawer/ui/drawer_screen.dart';
import 'package:healthstack/features/home/ui/widgets/speciality_list/specializations_bloc_builder.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_speciality_list_bloc_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const EndDrawer(), // Use your custom drawer
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal:20.w, vertical:16.h),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeTopBar(onMenuPressed: () => Scaffold.of(context).openEndDrawer(),),
                  
                  const DoctorsBlueContainer(),
                  verticalSpace(24),
                  
                  const SpecialityAndSeeAll(),
                  verticalSpace(16),   
                  
                  SpecializationsBlocBuilder(),
                  verticalSpace(15),
                  
                  DoctorsSpecialityListBlocBuilder(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
