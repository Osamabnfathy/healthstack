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
    hourString = hourString.trim().toLowerCase();  
    // Updated regex to be more specific and handle various formats
    final RegExp timeRegex = RegExp(r"(\d{1,2})(?::\d{2})?\s*(am|pm)", caseSensitive: false);
    final match = timeRegex.firstMatch(hourString);
    if (match != null) {
      int hour = int.tryParse(match.group(1)!) ?? 9; // Better default
      final period = match.group(2)?.toLowerCase();
  
      // Fixed AM/PM conversion logic
      if (period == 'pm' && hour != 12) {
        hour += 12;
      } else if (period == 'am' && hour == 12) {
        hour = 0; 
      }
      // Ensure hour is within valid range
      return hour.clamp(0, 23);
    }
    // Try parsing just numbers (assume 24-hour format)
    final numberMatch = RegExp(r"(\d{1,2})").firstMatch(hourString);
    if (numberMatch != null) {
      final hour = int.tryParse(numberMatch.group(1)!) ?? 9;
      return hour.clamp(0, 23);
    }
    return 9; // Default fallback
  }

// Improved method to parse time strings like "9:00 AM" or "1:00 PM"
TimeOfDay? _parseTime(String timeStr) {
  try {
    timeStr = timeStr.trim();
    
    // Enhanced regex to handle various time formats
    final RegExp timeRegex = RegExp(r'(\d{1,2}):?(\d{2})?\s*(AM|PM)', caseSensitive: false);
    final match = timeRegex.firstMatch(timeStr);
    
    if (match != null) {
      int hour = int.tryParse(match.group(1)!) ?? 0;
      int minute = int.tryParse(match.group(2) ?? '0') ?? 0;
      final period = match.group(3)?.toUpperCase();
      
      // Convert to 24-hour format
      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }
      
      return TimeOfDay(hour: hour, minute: minute);
    }
    
    // Fallback: try to parse just the hour
    final hourMatch = RegExp(r'(\d{1,2})\s*(AM|PM)', caseSensitive: false).firstMatch(timeStr);
    if (hourMatch != null) {
      int hour = int.tryParse(hourMatch.group(1)!) ?? 9;
      final period = hourMatch.group(2)?.toUpperCase();
      
      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }
      
      return TimeOfDay(hour: hour, minute: 0);
    }
    
    return null;
  } catch (e) {
    debugPrint('Time parsing error: $e for timeStr: $timeStr');
    return null;
  }
}

// Improved method to generate time slots
  List<TimeOfDay> _generateTimesForDate(DateTime selectedDate) {
    final now = DateTime.now();
    final bool isToday = selectedDate.year == now.year &&
                         selectedDate.month == now.month &&
                         selectedDate.day == now.day;
  
    // Default values
    TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);
    
    final visitingHoursString = widget.visitingHour;
    
    if (visitingHoursString != null && visitingHoursString.contains('-')) {
      final parts = visitingHoursString.split('-');
      if (parts.length >= 2) {
        final parsedStart = _parseTime(parts[0]);
        final parsedEnd = _parseTime(parts[1]);
        
        if (parsedStart != null) startTime = parsedStart;
        if (parsedEnd != null) endTime = parsedEnd;
      }
    }
    
    List<TimeOfDay> times = [];
    
    // Convert TimeOfDay to minutes for easier calculation
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;
    
    // Handle case where end time is before start time (next day)
    if (endMinutes <= startMinutes) {
      endMinutes += 24 * 60; // Add 24 hours
    }
    
    for (int currentMinutes = startMinutes; 
         currentMinutes < endMinutes; 
         currentMinutes += timeSlotIntervalMinutes) {
      
      int hour = (currentMinutes ~/ 60) % 24; // Handle overflow past 24 hours
      int minute = currentMinutes % 60;
      
      final slotTime = TimeOfDay(hour: hour, minute: minute);
      final slotDateTime = DateTime(
        selectedDate.year, 
        selectedDate.month, 
        selectedDate.day,
        hour, 
        minute,
      );
      
      // Only add future times if it's today
      if (!isToday || slotDateTime.isAfter(now)) {
        times.add(slotTime);
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
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTopBar(title: 'Book Appointment'), 
                verticalSpace(30),
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
                verticalSpace(30),
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
                    : ColorsManager.mainBlue,
                  borderRadius: 12.0.r,
                  buttonHeight: 52.0.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}    