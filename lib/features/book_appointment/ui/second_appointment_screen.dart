import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/book_appointment/logic/book_appointment_cubit.dart';
import 'package:healthstack/features/book_appointment/logic/book_appointment_state.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/doctor_info_card.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/bookink_info_card.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/message_text_field.dart';
import 'package:healthstack/features/book_appointment/ui/seconds_widgets/summary_step_numbers.dart';

class SecondAppointmentScreen extends StatelessWidget {
  final String selectedDate;
  final String? selectedTime;
  final String? selectedAppointmentType;
  final int? doctorId;
  final String? doctorName;
  final String? doctorImage;
  final String? hospitalName;
  final String? departmentName;

  const SecondAppointmentScreen({
    super.key,
    required this.selectedDate,
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
    'Date': DateFormat('MMM d, y').format(DateTime.parse(selectedDate)),
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

  String _parseTimeFromString(String timeString) {
    final sanitizedTimeString = timeString.trim().replaceAll(RegExp(r'\s+'), ' ');
    final timeParts = sanitizedTimeString.split(' ');
    if (timeParts.length != 2) {
      throw FormatException("Invalid time format: $timeString");
    }
    final time = timeParts[0];
    final amPm = timeParts[1].toUpperCase();
    final timeSplit = time.split(':');
    if (timeSplit.length != 2) {
      throw FormatException("Invalid time format: $timeString");
    }
    final hour = int.parse(timeSplit[0]);
    final minute = int.parse(timeSplit[1]);
    int adjustedHour = hour;
    if (amPm == 'PM' && hour != 12) {
      adjustedHour += 12;
    } else if (amPm == 'AM' && hour == 12) {
      adjustedHour = 0;
    }
    return '${adjustedHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
  }

  String _parseDate(String dateString) {
    final dateParts = dateString.split(' ');
    final date = dateParts[0];
    return date;
  }

  return Builder(
    builder: (innerContext) {
      final bookApptCubit = innerContext.read<BookAppointmentCubit>();

      bookApptCubit.updateBookingDetails(
        date: _parseDate(selectedDate),
        time: _parseTimeFromString(selectedTime!),
        type: selectedAppointmentType,
        doctor: DoctorsResponseModel(
          doctorId: doctorId,
        ),
      );

      messageController.addListener(() {
        bookApptCubit.updateMessage(messageController.text);
      });

      return Scaffold(
        backgroundColor: ColorsManager.lightBlue,
        body: BlocListener<BookAppointmentCubit, BookAppointmentState>(
          listener: (context, state) {
            if (state is BookAppointmentLoading) {
              showDialog(
                context: context,
                builder: (context) => const Center(child: CircularProgressIndicator()),
              );
            } else if (state is BookAppointmentSuccess) {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                Routes.summaryScreen,
                arguments: {
                  'bookingInfo': bookingInfo,
                  'doctorInfo': doctorInfo,
                },
              );
            } else if (state is BookAppointmentError) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTopBar(title: 'Book Appointment'),
                    verticalSpace(30),
                    SummaryStepsNumbers(currentStep: 2),
                    verticalSpace(30),
                    BookingInfoCard(bookingInfo: bookingInfo),
                    verticalSpace(30),
                    DoctorInfoCard(doctorInfo: doctorInfo, bookingInfo: bookingInfo,),
                    verticalSpace(30),
                    MessageTextField(messageController: messageController),
                    verticalSpace(30),
                    // Moved the button here inside the scrollable content
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: AppTextButton(
                        onPressed: () {
                          bookApptCubit.updateMessage(messageController.text);
                          bookApptCubit.submitBooking();
                        },
                        buttonText: "Book Now",
                        textStyle: TextStyles.font18WhiteMedium,
                        backgroundColor: ColorsManager.mainBlue,
                        borderRadius: 12.0.r,
                        buttonHeight: 52.0.h,
                      ),
                    ),
                    verticalSpace(10), // Add some bottom spacing
                  ],
                ),
              ),
            ),
          ),
        ),
        // Removed bottomNavigationBar completely
      );
    },
  );
 }
}