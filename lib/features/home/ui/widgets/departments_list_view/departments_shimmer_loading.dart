import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DepartmentsShimmerLoading extends StatelessWidget {
  const DepartmentsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 24.w),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: ColorsManager.lightGray,
                  highlightColor: Colors.white,
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Colors.white,
                  ),
                ),
                verticalSpace(14),
                
                Shimmer.fromColors(
                  baseColor: ColorsManager.lightGray,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 14.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}