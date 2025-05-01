import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DateSelection extends StatelessWidget {
  final List<String> dates;
  final int selectedDateIndex;
  final Function(int) onDateSelected;

  const DateSelection({
    super.key,
    required this.dates,
    required this.selectedDateIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Date", style: TextStyles.font16DarkBlueBold),
        verticalSpace(15),
        
        SizedBox(
          height: 80.h,
          width: double.infinity,
          
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final selected = selectedDateIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                
                child: GestureDetector(
                  onTap: () => onDateSelected(index),
                  
                  child: Container(
                    width: selected ? 65.w : 60.w, // Width changes
                    height: selected ? 60.h : 50.h, // Height changes
                    padding: selected
                        ? EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w)
                        : EdgeInsets.symmetric(vertical: 8.h, horizontal: 13.w),
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: selected
                          ? ColorsManager.mainBlue
                          : ColorsManager.lighterGray,
                          
                      boxShadow: selected
                          ? [BoxShadow(
                              color: ColorsManager.darkBlue.withOpacity(0.9,),
                              blurRadius: 5,
                              offset: const Offset(0, 2,),
                            )
                          ] : null,
                    ),
                    
                    child: Center(
                      child: Text(
                        dates[index],
                        textAlign: TextAlign.center,
                        style: selected
                            ? TextStyles.font14WhiteSemiBold
                          : TextStyles.font14DarkBlueRegular,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
