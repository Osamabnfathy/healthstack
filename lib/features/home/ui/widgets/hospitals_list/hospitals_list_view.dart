// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/hospitals_list/hospitals_list_view_item.dart';

class HospitalsListView extends StatelessWidget {
  final List<HospitalData> hospitalsDataList;
  
  const HospitalsListView({super.key, required this.hospitalsDataList});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // widget.specializationDataList.length,
        itemBuilder: (context, index) {
          return HospitalsListViewItem(
            itemIndex: index,
            hospitalsData: hospitalsDataList[index],
          );
        },
      ),
    );
  }
}

