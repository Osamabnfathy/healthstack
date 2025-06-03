import 'widgets/home_top_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/doctors_blue_container.dart';
import 'widgets/departments_and_see_all.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/home/ui/widgets/drawer/ui/drawer_screen.dart';
import 'package:healthstack/features/home/ui/widgets/departments_list/departments_bloc_builder.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_bloc_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedDepartmentId; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: EndDrawer(
        patientProfileData: context.watch<HomeCubit>().patientProfileData, 
      ), 
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
                  HomeTopBar(
                    onMenuPressed: () => Scaffold.of(context).openEndDrawer(),
                    patientName: context.watch<HomeCubit>().patientProfileData?.name ?? 'Patient',
                  ),
                  
                  const DoctorsBlueContainer(),
                  verticalSpace(24),
                  
                  const DepartmentsAndSeeAll(),
                  verticalSpace(16),   
                  
                  DepartmentsBlocBuilder(
                    selectedIndex: _getSelectedIndex(context),
                    onDepartmentSelected: (departmentId) {
                      setState(() {
                      selectedDepartmentId = departmentId; 
                    });
                    },
                    
                    onDepartmentsLoaded: (departments) {
                      // Set the first department as default
                      if (selectedDepartmentId == null && departments.isNotEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                          selectedDepartmentId = departments.first.hospitalDepartmentId;
                          });
                        });
                      }
                    },
                  ),
                  verticalSpace(10),
                  
                  DoctorsDepartmentBlocBuilder(
                    selectedDepartmentId: selectedDepartmentId,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  
  // Helper method to calculate the selected index
  int? _getSelectedIndex(BuildContext context) {
    final departments = context.read<HomeCubit>().departmentsDataList;
    if (departments == null || selectedDepartmentId == null) return null;

    return departments.indexWhere((department) => department.hospitalDepartmentId == selectedDepartmentId);
  }
}
