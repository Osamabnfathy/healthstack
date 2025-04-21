import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/specialization_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/speciality_list/doctors_speciality_list_view_item.dart';

class DoctorsSpecialityListView extends StatelessWidget {
  final List<SpecializationsResponseModel>? specializationsDataList;
  
  const DoctorsSpecialityListView({super.key, this.specializationsDataList});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specializationsDataList?.length, 
        itemBuilder: (context, index) {
          return DoctorsSpecialityListViewItem(
            itemIndex: index,
            specializationsData: specializationsDataList?[index],
          );
        },
      ),
    );
  }
}

