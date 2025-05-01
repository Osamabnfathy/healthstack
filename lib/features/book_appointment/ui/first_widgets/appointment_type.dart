import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppointmentType extends StatelessWidget {
  final List<String> appointmentTypes;
  final List<Image> appointmentIcons;
  final int selectedAppointmentType;
  final Function(int) onAppointmentTypeSelected;

  const AppointmentType({
    super.key,
    required this.appointmentTypes,
    required this.appointmentIcons,
    required this.selectedAppointmentType,
    required this.onAppointmentTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Appointment Type", style: TextStyles.font16DarkBlueBold),
        verticalSpace(10),

        ...List.generate(appointmentTypes.length, (index) {
          return GestureDetector(
            onTap: () => onAppointmentTypeSelected(index),
            
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedAppointmentType == index
                      ? ColorsManager.mainBlue
                      : ColorsManager.lighterGray,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              
              child: Row(
                children: [
                  appointmentIcons[index],
                  horizontalSpace(12),
                  
                  Expanded(
                    child: Text(appointmentTypes[index],
                        style: TextStyles.font14DarkBlueMedium, 
                    ),
                  ),
                  
                  Radio(
                    value: index,
                    groupValue: selectedAppointmentType,
                    onChanged: (val) => onAppointmentTypeSelected(index),
                    activeColor: ColorsManager.mainBlue,
                  )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
