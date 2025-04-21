import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';

class DoctorsSpecialityListViewItem extends StatelessWidget {
  final SpecializationsResponseModel? specializationsData;
  final int? itemIndex;

  const DoctorsSpecialityListViewItem({
    super.key,
    this.specializationsData,
    this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final Widget placeholder = Image.asset(
      'assets/icons/general.png', 
      height: 60.h, 
      width: 60.w,
      fit: BoxFit.fill, 
    );

    return Container(
      padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 35, 
            backgroundColor: ColorsManager.lightBlue,
            
            child: ClipOval( 
              child: specializationsData?.featuredImage != null && specializationsData!.featuredImage!.isNotEmpty
                ? Image.network(
                    specializationsData!.featuredImage!, 
                    height: 60.h, 
                    width: 60.w, 
                    fit: BoxFit.fill,
                  
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
            specializationsData?.hospitalDepartmentName ?? 'Specialization',
            style: TextStyles.font12DarkBlueRegular,
            maxLines: 1, // Prevent long names from wrapping excessively
            overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
          ),
        ],
      ),
    );
  }
}