import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
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
  TextEditingController searchController = TextEditingController();
  List<DoctorsResponseModel> filteredDoctors = [];
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    filteredDoctors = _getSortedDoctors(_filterDoctorsByDepartment(), isAscending);
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<DoctorsResponseModel> _filterDoctorsByDepartment() {
    return (widget.doctorsDataList ?? [])
        .where((doc) => doc.departmentName == widget.departmentId)
        .toList();
  }

  List<DoctorsResponseModel> _getSortedDoctors(
    List<DoctorsResponseModel> doctors, 
    bool ascending
  ) {
    final sorted = List<DoctorsResponseModel>.from(doctors);
    sorted.sort((a, b) {
      final nameA = a.name?.toLowerCase() ?? '';
      final nameB = b.name?.toLowerCase() ?? '';
      return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
    });
    return sorted;
  }

  void _onSearchChanged() {
    setState(() {
      final query = searchController.text.toLowerCase();
      final departmentDoctors = _filterDoctorsByDepartment();
      filteredDoctors = _getSortedDoctors(
        departmentDoctors.where((doctor) {
          return doctor.name?.toLowerCase().contains(query) ?? false;
        }).toList(),
        isAscending,
      );
    });
  }

  void _toggleSortOrder() {
    setState(() {
      isAscending = !isAscending;
      filteredDoctors = _getSortedDoctors(filteredDoctors, isAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              const CustomTopBar(title: 'Doctors'),
              verticalSpace(30),

              SearchAndFilterBar(
                searchController: searchController,
                onFilterPressed: _toggleSortOrder,
              ),
              verticalSpace(16),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredDoctors.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: DoctorsDepartmentListViewItem(
                        itemIndex: index,
                        doctorsData: filteredDoctors[index],
                        hospitalsDataList: widget.hospitalsDataList,
                        departmentsDataList: widget.departmentsDataList,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}