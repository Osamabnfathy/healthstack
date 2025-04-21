import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/hospitals/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_view_item.dart';

class HospitalsListView extends StatelessWidget {
  final List<HospitalData> hospitalsDataList;
  
  const HospitalsListView({super.key, required this.hospitalsDataList});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hospitalsDataList.length, 
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

