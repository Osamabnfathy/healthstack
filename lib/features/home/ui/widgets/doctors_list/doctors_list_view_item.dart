import 'package:flutter/widgets.dart';
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
                ? Image.network(doctorsData!.featuredImage!, width: 110.w, height: 120.h, fit: BoxFit.cover) 
                : Image.asset("assets/images/doctor-books.png", width: 110.w, height: 120.h, fit: BoxFit.cover),
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
                  '${getDisplayText(doctorsData?.phoneNumber)} | ${getDisplayText(doctorsData?.email)}',
                  style: TextStyles.font12GrayRegular,
                ),
                verticalSpace(5),
                
                Text(
                  doctorsData?.visitingHour ?? 'Not Available',
                  style: TextStyles.font12GrayRegular,
                ),
                verticalSpace(5),
                
                Text(
                  'Constultation: ${getDisplayText(doctorsData?.consultationFee.toString())} | Report: ${getDisplayText(doctorsData?.reportFee.toString())}',
                  style: TextStyles.font12GrayRegular,
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}