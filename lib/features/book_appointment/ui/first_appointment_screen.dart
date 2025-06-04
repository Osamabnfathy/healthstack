import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/book_appointment/logic/book_appointment_cubit.dart';
import 'package:healthstack/features/book_appointment/ui/first_widgets/steps_numbers.dart';
import 'package:healthstack/features/book_appointment/ui/first_widgets/time_selection.dart';
import 'package:healthstack/features/book_appointment/ui/first_widgets/date_selection.dart';
import 'package:healthstack/features/book_appointment/ui/first_widgets/appointment_type.dart';



class FirstAppointmentScreen extends StatefulWidget {
  final String? visitingHour;
  final int? doctorId;
  final String? doctorName;
  final String? doctorImage;
  final String? hospitalName;
  final String? departmentName;
  
  const FirstAppointmentScreen({
    super.key,
    this.doctorId,
    this.doctorName,
    this.doctorImage,
    this.visitingHour,
    this.hospitalName,
    this.departmentName,
  });

  @override
  State<FirstAppointmentScreen> createState() => _FirstAppointmentScreenState();
}

class _FirstAppointmentScreenState extends State<FirstAppointmentScreen> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  int selectedAppointmentType = 0;
  final int timeSlotIntervalMinutes = 30;

  late List<DateTime> availableDates;
  late List<TimeOfDay> availableTimes;
  final List<String> appointmentTypes = ['checkup', 'report'];
  final List<Image> appointmentIcons = [
    Image.asset('assets/icons/checkup.png', width: 32.w, height: 32.h), 
    Image.asset('assets/icons/followup.png', width: 32.w, height: 32.h),
  ];
  
   @override
  void initState() {
    super.initState();
    availableDates = _generateFutureDates(7); 
    availableTimes = _generateTimesForDate(availableDates[selectedDateIndex]);
    if (availableTimes.isEmpty) selectedTimeIndex = -1;
  }

  String _formatDateForDisplay(DateTime date) {
    final dayName = DateFormat('E').format(date); 
    final dayOfMonth = DateFormat('d').format(date); 
    return '$dayName\n$dayOfMonth';
  }

  List<DateTime> _generateFutureDates(int days) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return List.generate(days, (index) => today.add(Duration(days: index)));
  }

  int _parseHour(String hourString) {
    hourString = hourString.trim();
    final RegExp timeRegex = RegExp(r"(\d{1,2})\s*(am|pm)?", caseSensitive: false);
    final match = timeRegex.firstMatch(hourString);

    if (match != null) {
      int hour = int.tryParse(match.group(1)!) ?? 0;
      final period = match.group(2)?.toLowerCase();

      if (period == 'pm' && hour != 12) {
        hour += 12;
      } else if (period == 'am' && hour == 12) {
        hour = 0; 
      }
      return hour;
    }
    return 9; 
  }


  List<TimeOfDay> _generateTimesForDate(DateTime selectedDate) {
    final now = DateTime.now();
    final bool isToday = selectedDate.year == now.year &&
                         selectedDate.month == now.month &&
                         selectedDate.day == now.day;

    int startHour = 9; 
    int endHour = 17; 
    final visitingHoursString = widget.visitingHour;
    if (visitingHoursString != null && visitingHoursString.contains('-')) {
      final parts = visitingHoursString.split('-');
      if (parts.length >= 2) {
        startHour = _parseHour(parts[0]);
        endHour = _parseHour(parts[1]);
        if (endHour <= startHour && endHour != 0) {
           endHour = startHour + 8; 
        }
      } else if (parts.isNotEmpty) {
          startHour = _parseHour(parts[0]);
          endHour = startHour + 8; 
      }
    } else if (visitingHoursString != null && visitingHoursString.isNotEmpty){
        startHour = _parseHour(visitingHoursString);
        endHour = startHour + 8; 
    }
    endHour = endHour > 24 ? 24 : endHour;

    List<TimeOfDay> times = [];
    final int startMinuteOfDay = startHour * 60;
    final int endMinuteOfDay = endHour * 60;
    for (int currentMinuteOfDay = startMinuteOfDay;
         currentMinuteOfDay < endMinuteOfDay;
         currentMinuteOfDay += timeSlotIntervalMinutes)
      {
        int hour = currentMinuteOfDay ~/ 60;
        int minute = currentMinuteOfDay % 60;
        TimeOfDay slotStartTimeOfDay = TimeOfDay(hour: hour, minute: minute);

        DateTime slotStartDateTime = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day,
          hour, minute,
        );
        if (isToday) {
          if (slotStartDateTime.isAfter(now)) {
             times.add(slotStartTimeOfDay);
          }
        } else {
          times.add(slotStartTimeOfDay);
        }
      }
      return times;
  }


  void updateSelectedDate(int index) {
    if (index < 0 || index >= availableDates.length) return;
    setState(() {
      selectedDateIndex = index;
      // Regenerate times based on the newly selected date
      availableTimes = _generateTimesForDate(availableDates[selectedDateIndex]);
       // Reset time selection, handle empty list
      selectedTimeIndex = availableTimes.isEmpty ? -1 : 0;
    });
  }

  void updateSelectedTime(int index) {
     if (index < 0 || index >= availableTimes.length) return; 
    setState(() {
      selectedTimeIndex = index;
    });
  }

  void updateAppointmentType(int index) {
     if (index < 0 || index >= appointmentTypes.length) return; 
    setState(() {
      selectedAppointmentType = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final List<String> displayDates = availableDates.map(_formatDateForDisplay).toList();
    final List<String> displayTimes = availableTimes.map((time) => time.format(context)).toList();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: ColorsManager.mainBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedTimeIndex == -1) 
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  "Please select a Time",
                  style: TextStyles.font14RedRegular.copyWith(fontSize: 18.sp),
                ),
              ),
          
            AppTextButton(
              onPressed: selectedTimeIndex == -1 
              ? () {} 
              : () {
                final String selectedDate = availableDates[selectedDateIndex].toString();
                final String selectedTime = availableTimes[selectedTimeIndex].format(context);
                final String selectedappointmentType = appointmentTypes[selectedAppointmentType];
              
                Navigator.pushNamed(
                  context,
                  Routes.secondAppointmentScreen,
                  arguments: {
                    'selectedDate': selectedDate,
                    'selectedTime': selectedTime,
                    'selectedAppointmentType': selectedappointmentType,
                    'doctorId': widget.doctorId,
                    'doctorName': widget.doctorName,
                    'doctorImage': widget.doctorImage,
                    'hospitalName': widget.hospitalName,
                    'departmentName': widget.departmentName,
                    'cubit': context.read<BookAppointmentCubit>(),
                  },
                );              
              },
              
              
              
              buttonText: "Continue",
              textStyle: TextStyles.font18WhiteMedium,
              backgroundColor: selectedTimeIndex == -1
              ? ColorsManager.mainBlue.withOpacity(0.6)
              :ColorsManager.mainBlue,
              borderRadius: 12.0.r,
              buttonHeight: 52.0.h,
            ),
          ],
        ),
      ),
    
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepsNumbers(),
                verticalSpace(30),
                
                DateSelection(
                  dates: displayDates,
                  selectedDateIndex: selectedDateIndex,
                  onDateSelected: updateSelectedDate,
                ),
                verticalSpace(30),
                
                TimeSelection(
                  times: displayTimes,
                  selectedTimeIndex: selectedTimeIndex,
                  onTimeSelected: updateSelectedTime,
                ),
                verticalSpace(30),
                
                AppointmentType(
                  appointmentTypes: appointmentTypes,
                  appointmentIcons: appointmentIcons,
                  selectedAppointmentType: selectedAppointmentType,
                  onAppointmentTypeSelected: updateAppointmentType,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
