// lib/features/home/ui/widgets/drawer_divider.dart
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CircularEdgeItemsDrawer extends StatelessWidget {
  const CircularEdgeItemsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h, 
      color: ColorsManager.lightBlue, 
      
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.lighterGray, 
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
      ),
    );
  }
}