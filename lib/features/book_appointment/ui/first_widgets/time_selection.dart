import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';


class TimeSelection extends StatelessWidget {
  final List<String> times;
  final int selectedTimeIndex;
  final Function(int) onTimeSelected;

  const TimeSelection({
    super.key,
    required this.times,
    required this.selectedTimeIndex,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available time",
          style: TextStyles.font16DarkBlueSemiBold,
        ),
        verticalSpace(15), 

        if (times.isEmpty)
          Container(
            width: double.infinity, 
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w), 
            decoration: BoxDecoration(
              color: ColorsManager.lighterGray.withOpacity(0.5), 
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center( 
              child: Text(
                "No Available Time Today.",
                style: TextStyles.font14GrayRegular, 
                textAlign: TextAlign.center,
              ),
            ),
          )

        else
          GridView.builder(
            shrinkWrap: true, 
            itemCount: times.length,
            physics: const NeverScrollableScrollPhysics(), 
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              childAspectRatio: 3.0, 
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 10.h,
            ),
            
            itemBuilder: (context, index) {
              if (index >= times.length) return const SizedBox.shrink();
              final bool isSelected = selectedTimeIndex == index; 
              
              return GestureDetector(
                onTap: () => onTimeSelected(index),
                
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: isSelected ? null : Border.all(color: ColorsManager.lightGray, width: 0.5), 
                    
                    color: isSelected
                        ? ColorsManager.mainBlue
                        : ColorsManager.lighterGray, 
                    
                    boxShadow: isSelected
                        ? [BoxShadow(
                            color: ColorsManager.darkBlue.withOpacity(0.9), 
                            blurRadius: 5,
                            offset: const Offset(0, 2), 
                          )
                        ]: null, 
                  ),
                  
                  child: Center(
                    child: Text(
                      times[index],
                      textAlign: TextAlign.center,
                      style: isSelected
                          ? TextStyles.font14WhiteSemiBold
                          : TextStyles.font14DarkBlueRegular, 
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}