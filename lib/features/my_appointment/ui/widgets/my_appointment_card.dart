import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/font_weight_helper.dart';
import 'package:healthstack/core/theming/styles.dart';


class AppointmentData {
  final String doctorImage;
  final String doctorName;
  final String specialty;
  final String hospitalName;
  final String date;
  final String time;
  final String type;
  final String amount;
  final String status;
  final String paymentStatus;

  AppointmentData({
    required this.doctorImage,
    required this.doctorName,
    required this.specialty,
    required this.hospitalName,
    required this.date,
    required this.time,
    required this.type,
    required this.amount,
    required this.status,
    required this.paymentStatus,
  });
}

class MyAppintmentCard extends StatelessWidget {
  final AppointmentData appointment;

  const MyAppintmentCard({
    super.key,
    required this.appointment,
  });

  Color _getPaymentStatusColor() {
    return appointment.paymentStatus.toLowerCase() == 'paid'
        ? ColorsManager.green
        : Colors.red;
  }

  Color _getConfirmationStatusColor() {
    String statusLower = appointment.status.toLowerCase();
    if (statusLower == 'confirmed') {
      return ColorsManager.green;
    } else if (statusLower == 'pending') {
      return Colors.orange;
    } else if (statusLower == 'unconfirmed') {
      return Colors.red;
    }
    return Colors.grey;
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
                backgroundImage: AssetImage(appointment.doctorImage),
                onBackgroundImageError: (_, __) {},
                backgroundColor: Colors.grey[300],
              ),
              horizontalSpace(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: TextStyles.font16DarkBlueSemiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(6),
                    Text(
                      appointment.specialty,
                      style: TextStyles.font12GrayRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(16),
          _buildInfoRow("  Hospital:", appointment.hospitalName),
          verticalSpace(10),
          _buildInfoRow(
              "  Date&Time:", '${appointment.date} | ${appointment.time}'),
          verticalSpace(10),
          _buildInfoRow("  Type:", appointment.type),
          verticalSpace(10),
          _buildInfoRow("  Amount:", appointment.amount),
          verticalSpace(10),
          _buildColoredInfoRow(
              "  Status:", appointment.status, _getConfirmationStatusColor()),
          verticalSpace(10),
          _buildColoredInfoRow("  Payment Status:", appointment.paymentStatus,
              _getPaymentStatusColor()),
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
          child: Container(
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
        ),
      ],
    );
  }
}
