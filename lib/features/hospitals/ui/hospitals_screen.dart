import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_bloc_builder.dart';

class HospitalsScreen extends StatelessWidget {
  const HospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  
                  verticalSpace(16),   
                  
                  HospitalsListBlocBuilder(),
                  verticalSpace(2),
                  
                
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}