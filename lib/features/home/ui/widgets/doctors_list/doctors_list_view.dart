import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_list_view_item.dart';

class DoctorsListView extends StatelessWidget {
  final List<DoctorData> doctorsDataList; 
  const DoctorsListView({super.key, required this.doctorsDataList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctorsDataList.length, // widget.specializationDataList.length,
      itemBuilder: (context, index) {
        return DoctorsListViewItem(
          itemIndex: index,
          doctorsData: doctorsDataList[index], // Replace with actual data model
        );
      },
    );
  }
}
