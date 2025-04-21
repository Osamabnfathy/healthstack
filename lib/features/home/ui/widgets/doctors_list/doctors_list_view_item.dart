import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';

class DoctorsListViewItem extends StatelessWidget {
  final DoctorsResponseModel? doctorsData;
  final int? itemIndex;
  
  const DoctorsListViewItem({
    super.key,
    this.doctorsData,
    this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
  
    final Widget placeholderImage = Image.asset(
      "assets/images/doctor-books.png", 
      width: 110.w, 
      height: 120.h, 
      fit: BoxFit.cover
    );
    
  
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorsManager.lightBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          )
        ],
      ),
      
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: doctorsData?.featuredImage != null && doctorsData!.featuredImage!.isNotEmpty
                ? Image.network(
                  doctorsData!.featuredImage!, 
                  width: 110.w, 
                  height: 120.h, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => placeholderImage,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                )
                : placeholderImage,
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
                  maxLines: 1, // Prevent long names from wrapping excessively
                ),
                verticalSpace(5),
                
                Text(
                  'Phone: ${getDisplayText(doctorsData?.phoneNumber)}',
                  style: TextStyles.font12GrayRegular,
                  maxLines: 1, // Prevent long names from wrapping excessively
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(5),
                
                Text(
                  'Email: ${getDisplayText(doctorsData?.email)}',
                  style: TextStyles.font12GrayRegular,
                  maxLines: 1, // Prevent long names from wrapping excessively
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(5),
                
                Text(
                  'Working Hours: ${getDisplayText(doctorsData?.visitingHour)}',
                  style: TextStyles.font12GrayRegular,
                  maxLines: 1, // Prevent long names from wrapping excessively
                  overflow: TextOverflow.ellipsis,
                ),
                
              ]
            ),
          ),
        ],
      ),
    );
  }
}