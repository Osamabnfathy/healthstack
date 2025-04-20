import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';

class DoctorsListViewItem extends StatelessWidget {
  final DoctorData? doctorsData;
  final int itemIndex;
  
  const DoctorsListViewItem({
    super.key,
    required this.doctorsData,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
  
    final Widget placeholder = Image.asset(
      "assets/images/doctor-books.png", 
      width: 110.w, 
      height: 120.h, 
      fit: BoxFit.cover
    );
    
    String getDisplayText(String? value) {
      return (value == null || value.trim().isEmpty) ? 'Not Available' : value;
    }
  
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorsManager.lightBlue,
      ),
      
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: doctorsData?.featuredImage != null 
                ? Image.network(
                  doctorsData!.featuredImage!, 
                  width: 110.w, 
                  height: 120.h, 
                  fit: BoxFit.cover,
                  
                  errorBuilder: (context, error, stackTrace) {
                      return placeholder;
                    },

                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      
                      return SizedBox( 
                        width: 40.w,
                        height: 40.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null, 
                          ),
                        ),
                      );
                    },
                )
                    
                : placeholder,
          ),
          horizontalSpace(16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorsData?.name ?? 'Doctor' ,
                  style: TextStyles.font18DarkBlueBold,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(5),
                
                Text(
                  'Email: ${getDisplayText(doctorsData?.email)}',
                  style: TextStyles.font12GrayRegular,
                ),
                verticalSpace(5),
                
                Text(
                  'Phone Number: ${getDisplayText(doctorsData?.phoneNumber)}',
                  style: TextStyles.font12GrayRegular,
                ),
                verticalSpace(5),
                
                Text(
                  'Working Hours: ${getDisplayText(doctorsData?.visitingHour)}',
                  style: TextStyles.font12GrayRegular,
                ),
                
              ]
            ),
          ),
        ],
      ),
    );
  }
}