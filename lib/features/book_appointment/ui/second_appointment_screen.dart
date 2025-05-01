import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/doctor_info_card.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/bookink_info_card.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/message_text_field.dart';
import 'package:healthstack/features/book_appointment/ui/third_booking_confirmation_screen.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/summary_step_numbers.dart';

class SecondAppointmentScreen extends StatelessWidget {
  final String? selectedDate;
  final String? selectedTime;
  final String? selectedAppointmentType;
  final int? doctorId;
  final String? doctorName;
  final String? doctorImage;
  final String? hospitalName;
  final String? departmentName;
  
  
  const SecondAppointmentScreen({
    super.key,
    this.selectedDate,
    this.selectedTime,
    this.selectedAppointmentType,
    this.doctorId,
    this.doctorName,
    this.doctorImage,
    this.hospitalName,
    this.departmentName,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    
    final bookingInfo = {
      'Date': DateFormat('MMM d, y').format(DateTime.parse(selectedDate!)),
      'Time': selectedTime,
      'Appointment Type': selectedAppointmentType,
    };
    
    final doctorInfo = {
      'Doctor ID': doctorId,
      'Doctor Name': doctorName,
      'Hospital Name': hospitalName,
      'Department Name': departmentName,
      'Doctor Image': doctorImage,
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: ColorsManager.darkBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15.w),
        child: AppTextButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => SummaryScreen(
                  bookingInfoData: bookingInfo,
                  doctorInfoData: doctorInfo,
                ),
              ),
            );
          },
          buttonText: "Book Now",
          textStyle: TextStyles.font18WhiteMedium,
          backgroundColor: ColorsManager.mainBlue,
          borderRadius: 12.0.r,
          buttonHeight: 55.0.h,
        ),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryStepsNumbers(currentStep: 2),
                verticalSpace(30),
                
                BookingInfoCard(bookingInfo: bookingInfo),
                verticalSpace(30),
                
                DoctorInfoCard(doctorInfo: doctorInfo),
                verticalSpace(30),
                
                MessageTextField(messageController: messageController,),
                verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
