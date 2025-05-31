import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/font_weight_helper.dart';
import 'package:healthstack/core/theming/styles.dart';


class AppointmentData {
  final String? doctorImage;
  final String? doctorName;
  final String? specialty;
  final String? hospitalName;
  final String? date;
  final String? time;
  final String? type;
  final String? amount;
  final String? status;
  final String? paymentStatus;

  AppointmentData({
    this.doctorImage,
    this.doctorName,
    this.specialty,
    this.hospitalName,
    this.date,
    this.time,
    this.type,
    this.amount,
    this.status,
    this.paymentStatus,
  });
}

class MyAppintmentCard extends StatelessWidget {
  final AppointmentData data;

  const MyAppintmentCard({
    super.key,
    required this.data,
  });

  Color _getPaymentStatusColor() {
    String? paymentStatus = data.paymentStatus!.toLowerCase();
    if (paymentStatus == 'confirmed') {
      return ColorsManager.green;
    } 
    else if (paymentStatus == 'pending') {
      return Colors.orange;
    } 
    else if (paymentStatus == 'unconfirmed') {
      return Colors.red;
    } 
    else {
      return Colors.red;
    }
    
  }

  Color _getConfirmationStatusColor() {
    String statusLower = data.status!.toLowerCase();
    if (statusLower == 'confirmed') {
      return ColorsManager.green;
    } 
    else if (statusLower == 'pending') {
      return Colors.orange;
    } 
    else if (statusLower == 'unconfirmed') {
      return Colors.red;
    }
    return Colors.grey;
  }
  
  String formatDateTime(String? date, String? time) {
  if (date == null || time == null) return '';
  try {
    final dt = DateTime.parse('${date}T$time');
    final formattedDate = DateFormat('MMMM d, y').format(dt); 
    final formattedTime = DateFormat('h:mm a').format(dt).toLowerCase(); 
    return '$formattedDate  ||  $formattedTime';
  } catch (e) {
    return '$date  ||  $time';
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkBlue.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundImage: data.doctorImage != null && data.doctorImage!.isNotEmpty
                    ? NetworkImage(data.doctorImage!,)
                    : Image.asset(
                        "assets/icons/doctor.png",
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.fill,
                      ).image,
                      
                onBackgroundImageError: (_, __) {},
                backgroundColor: Colors.grey[300],
              ),
              horizontalSpace(20),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.doctorName ?? '',
                      style: TextStyles.font16DarkBlueSemiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(6),
                    
                    Text(
                      "${getDisplayText(data.specialty)} | ${getDisplayText(data.hospitalName)}",
                      style: TextStyles.font12GrayRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          verticalSpace(15),
          _buildInfoRow(" Date & Time:", formatDateTime(data.date, data.time)),
          verticalSpace(10),
          
          _buildInfoRow(" Type & Amount:", "${data.type ?? ''}  ||  ${data.amount ?? ''} EGP"),
          verticalSpace(10),
          
          _buildColoredInfoRow(" Status:", data.status  ?? '', _getConfirmationStatusColor()),
          verticalSpace(10),
          
          _buildColoredInfoRow(" Payment Status:", data.paymentStatus ?? '', _getPaymentStatusColor()),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: TextStyles.font14DarkBlueBold,
          ),
        ),
        
        Expanded(
          child: Text(
            value,
            style: TextStyles.font12GrayRegular,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildColoredInfoRow(String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: TextStyles.font14DarkBlueBold,
          ),
        ),
        
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
           
          child: Text(
            value,
            style: TextStyles.font12DarkBlueRegular.copyWith(
              color: color,
              fontWeight: FontWeightHelper.semiBold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
