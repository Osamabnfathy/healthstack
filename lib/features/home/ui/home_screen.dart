import 'package:healthstack/features/home/data/models/doctors_response_model.dart';

import 'widgets/home_top_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/hospitals_and_see_all.dart';
import 'widgets/doctors_blue_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/logic/cubit/home_state.dart';
import 'package:healthstack/features/home/ui/widgets/doctor_see_all.dart';
import 'package:healthstack/features/home/ui/widgets/drawer/ui/drawer_screen.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_list_view.dart';
import 'package:healthstack/features/home/ui/widgets/hospitals_list/hospitals_list_view.dart';

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
                  
                  const HospitalsAndSeeAll(),
                  verticalSpace(16),   
                  
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) => 
                      current is HospitalsLoading ||
                      current is HospitalsSuccess ||
                      current is HospitalsError,
                    builder: (context, state) {
                      return state.maybeWhen(
                        hospitalsLoading: () {
                          return const SizedBox(
                            height: 100,
                            child: CircularProgressIndicator(
                              color: ColorsManager.mainBlue,
                            ),
                          );
                        },
                        hospitalsSuccess: (hospitalsResponseModel) {
                          var hospitalsList = hospitalsResponseModel.hospitals;
                          return Expanded(
                            child: Column(
                              children: [       
                                HospitalsListView(hospitalsDataList: hospitalsList ?? [],),
                                verticalSpace(2),
                              ]
                            ),
                          );
                        },
                        hospitalsError: (errorHandler) {
                          return const SizedBox.shrink();
                        },
                        orElse: () {
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  ),
                  
                  const DoctorsAndSeeAll(),
                  verticalSpace(16),
                  
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) => 
                      current is DoctorsLoading ||
                      current is DoctorsSuccess ||
                      current is DoctorsError,
                    builder: (context, state) {
                      return state.maybeWhen(
                        doctorsLoading: () {
                          return const SizedBox(
                            height: 100,
                            child: CircularProgressIndicator(
                              color: ColorsManager.mainBlue,
                            ),
                          );
                        },
                        doctorsSuccess: (doctorsResponseModel) {
                          var doctorssList = doctorsResponseModel.doctors;
                          return Expanded(
                            child: Column(
                              children: [       
                                DoctorsListView(doctorsDataList: doctorssList ?? [],),
                              ]
                            ),
                          );
                        },
                        doctorsError: (errorHandler) {
                          return const SizedBox.shrink();
                        },
                        orElse: () {
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
