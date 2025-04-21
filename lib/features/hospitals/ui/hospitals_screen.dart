import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_bloc_builder.dart';

class HospitalsScreen extends StatelessWidget {
  const HospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Find Hospital', 
          style: TextStyles.font20DarkBlueSemiBold,
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context), // Close drawer action
          child: Icon(Icons.arrow_back_ios_new_outlined, color: ColorsManager.darkBlue, size: 20.sp,),
        ),
      ),
      
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 15.h),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                  
                  Expanded(child: HospitalsListBlocBuilder()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}