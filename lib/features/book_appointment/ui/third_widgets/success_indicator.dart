import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingSuccessWidget extends StatelessWidget {
  const BookingSuccessWidget({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, 
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animations/success_checkmark.json',
          width: 130.w, 
          height: 130.h,
          repeat: false, 
        ),
        verticalSpace(10), 

        Text(
          'Booked Successfully!',
          style: TextStyles.font24BlueBold,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}