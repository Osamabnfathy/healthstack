import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ConfirmationBookingInfoCard extends StatelessWidget {
  final Map<dynamic, dynamic> bookingInfo;
  
  const ConfirmationBookingInfoCard({
    super.key, 
    required this.bookingInfo,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Booking Information",
          style: TextStyles.font16DarkBlueBold,
        ),
        verticalSpace(15),
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          
          child: Column(
            children: [
              _buildInfoItem(
                icon: Icons.calendar_month_outlined,
                iconColor: ColorsManager.mainBlue,
                title: "Date & Time",
                subtitle: "${bookingInfo['Date']}  ‖  ${bookingInfo['Time']}",
              ),
              
              Divider(height: 1, thickness: 2,indent: 15.w , endIndent: 15.w, color: Colors.grey.shade200),
              
              _buildInfoItem(
                icon: Icons.menu_book_outlined,
                iconColor: ColorsManager.mainBlue,
                title: "Appointment Type",
                subtitle: bookingInfo['Appointment Type'] ?? "",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            
            child: Icon(
              icon,
              color: iconColor,
              size: 35.w,
            ),
          ),
          horizontalSpace(16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.font14DarkBlueMedium,
                ),
                verticalSpace(4),
                
                Text(
                  subtitle,
                  style: TextStyles.font13GrayRegular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
