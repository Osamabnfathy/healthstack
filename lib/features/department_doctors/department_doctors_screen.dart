import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/widgets/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/ui/widgets/doctors_list/doctors_department_list_view_item.dart';

class DepartmentDoctorsScreen extends StatefulWidget {
  final int departmentId;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;
  final List<DoctorsResponseModel>? doctorsDataList; 

  const DepartmentDoctorsScreen({
    super.key,
    required this.departmentId,
    this.hospitalsDataList,
    this.departmentsDataList,
    this.doctorsDataList,
  });

  @override
  State<DepartmentDoctorsScreen> createState() => _DepartmentDoctorsScreenState();
}

class _DepartmentDoctorsScreenState extends State<DepartmentDoctorsScreen> {
  late TextEditingController searchController;
  String searchQuery = '';
  bool isSorted = true;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.trim().toLowerCase();
    });
  }
  
  void _onFilterPressed() {
    setState(() {
      isSorted = !isSorted;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final filteredDoctors = (widget.doctorsDataList ?? [])
        .where((doc) => doc.departmentName == widget.departmentId)
        .toList();
        
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'), 
        titleTextStyle: TextStyles.font20DarkBlueSemiBold,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 19.sp,
            color: ColorsManager.mainBlue,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          children: [
            SearchAndFilterBar(
              searchController: searchController, 
              onFilterPressed: _onFilterPressed
            ),
            verticalSpace(10),  
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  return DoctorsDepartmentListViewItem(
                    itemIndex: index,
                    doctorsData: filteredDoctors[index],
                    hospitalsDataList: widget.hospitalsDataList,
                    departmentsDataList: widget.departmentsDataList,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}