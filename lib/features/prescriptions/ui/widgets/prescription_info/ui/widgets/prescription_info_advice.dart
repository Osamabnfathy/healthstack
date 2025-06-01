import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';


class AdviceSection extends StatelessWidget {
  final String advice;

  const AdviceSection({
    super.key,
    required this.advice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(12.r),
        
        boxShadow: [
          BoxShadow(
            color: ColorsManager.regularBlue.withOpacity(0.07),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle('Advice/Recommendation'),
        
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              advice,
              style: TextStyles.font12DarkBlueRegular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      
      decoration: BoxDecoration(
        color: ColorsManager.regularBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      
      child: Text(
        title,
        style: TextStyles.font16morelightGrayBold,
      ),
    );
  }
}
