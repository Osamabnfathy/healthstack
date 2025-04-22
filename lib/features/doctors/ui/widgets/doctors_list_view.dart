import 'package:flutter/material.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctors_list_view_item.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';


class DoctorsListView extends StatelessWidget {
  final List<DoctorsResponseModel>? doctorsDataList;

  const DoctorsListView({
    super.key,
    this.doctorsDataList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: doctorsDataList?.length,
        itemBuilder: (context, index) {
          return DoctorsListViewItem(
            itemIndex: index,
            doctorsData: doctorsDataList?[index],
          );
        },
    );
  }
}