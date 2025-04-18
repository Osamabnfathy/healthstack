import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsListView extends StatelessWidget {
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsManager.moreLighterGray,
            ),
            
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    width: 110.w,
                    height: 120.h,
                    "https://wallpapers.com/images/hd/doctor-pictures-l5y1qs2998u7rf0x.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                horizontalSpace(16),
                
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyles.font18DarkBlueBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace(5),
                        
                        Text(
                          'Degree | hahahahah',
                          style: TextStyles.font12GrayRegular,
                        ),
                        verticalSpace(5),
                        
                        Text(
                          'Email@gmail.com',
                          style: TextStyles.font12GrayRegular,
                        )
                      ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
