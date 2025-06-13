import 'package:flutter/material.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/book_appointment/ui/third_widgets/success_indicator.dart';
import 'package:healthstack/features/book_appointment/ui/third_widgets/confirmation_doctor_info_card.dart';
import 'package:healthstack/features/book_appointment/ui/third_widgets/confirmation_booking_info_card.dart';

class SummaryScreen extends StatelessWidget {
  final Map<String, dynamic>? bookingInfoData;
  final Map<String, dynamic>? doctorInfoData;
  
  const SummaryScreen({
    super.key,
    this.bookingInfoData,
    this.doctorInfoData,
  });

  @override
  Widget build(BuildContext context) {  
    final bookingInfo = {
      'Date': bookingInfoData?['Date'] ?? "",
      'Time': bookingInfoData?['Time'] ?? "",
      'Appointment Type': bookingInfoData?['Appointment Type'] ?? "",
    };  
    
    final doctorInfo = {
      'Doctor Name': doctorInfoData?['Doctor Name'] ?? "",
      'Hospital Name': doctorInfoData?['Hospital Name'] ?? "",
      'Department Name': doctorInfoData?['Department Name'] ?? "",
      'Doctor Image': doctorInfoData?['Doctor Image'] ?? "",
    };

    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BookingSuccessWidget(),
                verticalSpace(30),
                ConfirmationBookingInfoCard(bookingInfo: bookingInfo),
                verticalSpace(20),  
                ConfirmationDoctorInfoCard(doctorInfo: doctorInfo),
                verticalSpace(30),
                Padding(
                  padding: EdgeInsets.all(15.w),
                  child: AppTextButton(
                    onPressed: () {
                      context.pushNamedAndRemoveUntil(
                        Routes.homeScreen, (route) => false,
                        predicate: (Route<dynamic> route) { return false; });
                    },
                    buttonText: "Done",
                    textStyle: TextStyles.font18WhiteMedium,
                    backgroundColor: ColorsManager.mainBlue,
                    borderRadius: 12.0.r,
                    buttonHeight: 52.0.h,
                  ),
                ),
                verticalSpace(20), // Add some bottom spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}