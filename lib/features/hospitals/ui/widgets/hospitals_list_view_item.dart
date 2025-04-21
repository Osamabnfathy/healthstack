import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/hospitals/data/models/hospitals_response_model.dart';

class HospitalsListViewItem extends StatelessWidget {
  final HospitalData? hospitalsData;
  final int itemIndex;

  const HospitalsListViewItem({
    super.key,
    required this.hospitalsData,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final Widget placeholder = Image.asset(
      'assets/icons/hospital.png', 
      height: 50.h, 
      width: 50.w,
      fit: BoxFit.contain, 
    );

    return Container(
      padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30, 
            backgroundColor: ColorsManager.lightBlue,
            
            child: ClipOval( 
              child: hospitalsData?.featuredImage != null && hospitalsData!.featuredImage!.isNotEmpty
                ? Image.network(
                    hospitalsData!.featuredImage!, 
                    height: 50.h, 
                    width: 50.w, 
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
          ),
          verticalSpace(8),
          
          Text(
            hospitalsData?.name ?? 'Hospital',
            style: TextStyles.font12DarkBlueRegular,
            maxLines: 1, // Prevent long names from wrapping excessively
            overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
          ),
        ],
      ),
    );
  }
}