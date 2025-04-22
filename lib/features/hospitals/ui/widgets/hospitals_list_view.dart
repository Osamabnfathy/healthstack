import 'package:flutter/material.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';

import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_view_item.dart';

class HospitalsListView extends StatelessWidget {
  final List<HospitalsResponseModel>? hospitalsDataList;
  
  const HospitalsListView({super.key, this.hospitalsDataList});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hospitalsDataList?.length, 
      itemBuilder: (context, index) {
        return HospitalsListViewItem(
          itemIndex: index,
          hospitalsData: hospitalsDataList?[index],
        );
      },      
    );
  }
}

