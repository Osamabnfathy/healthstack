import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';

class HospitalsListViewItem extends StatelessWidget{
  final HospitalData? hospitalsData;
  final int itemIndex;
  
  const HospitalsListViewItem({
    super.key,
    required this.hospitalsData,
    required this.itemIndex,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 18.w,),
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: ColorsManager.lightBlue,
                  child: hospitalsData?.featuredImage != null 
                      ? Image.network(hospitalsData!.featuredImage!, height: 40.h, width: 40.w,) 
                      : Image.asset('assets/icons/hospital.png', height: 40.h, width: 40.w,),
                ),
                verticalSpace(8),
                
                Text(
                  hospitalsData?.name ?? 'Hospital',
                  style: TextStyles.font12DarkBlueRegular,
                ),
              ],
            ),
          );
  }
}