import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/core/widgets/search_bar.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/medical_departments/ui/widgets/medical_departments_grid_view.dart';

class MedicalDepartmentsScreen extends StatefulWidget {
  final List<DepartmentsResponseModel>? departmentsDataList;
  final List<DoctorsResponseModel>? doctorsDataList;
  final List<HospitalsResponseModel>? hospitalsDataList;

  const MedicalDepartmentsScreen({
    super.key,
    this.departmentsDataList,
    this.doctorsDataList,
    this.hospitalsDataList,
  });

  @override
  State<MedicalDepartmentsScreen> createState() => _MedicalDepartmentsScreenState();
}

class _MedicalDepartmentsScreenState extends State<MedicalDepartmentsScreen> {
  TextEditingController searchController = TextEditingController();
  List<DepartmentsResponseModel>? _filteredDepartments;
  String searchQuery = '';
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    _filteredDepartments = _sortDepartments(widget.departmentsDataList);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.trim().toLowerCase();
      
      if (searchQuery.isEmpty) {
        _filteredDepartments = _sortDepartments(widget.departmentsDataList);
      } else {
        _filteredDepartments = _sortDepartments(
          widget.departmentsDataList?.where((dept) {
            final hospital = widget.hospitalsDataList?.firstWhere(
              (h) => h.hospitalId == dept.hospital,
              orElse: () => HospitalsResponseModel(name: '')
            );
            return hospital?.name?.toLowerCase().contains(searchQuery) ?? false;
          }).toList()
        );
      }
    });
  }

  void _onFilterPressed() {
    setState(() {
      isAscending = !isAscending;
      _filteredDepartments = _sortDepartments(_filteredDepartments);
    });
  }

  List<DepartmentsResponseModel>? _sortDepartments(List<DepartmentsResponseModel>? departments) {
    if (departments == null) return null;
    
    departments.sort((a, b) {
      final hospitalA = widget.hospitalsDataList?.firstWhere(
        (h) => h.hospitalId == a.hospital,
        orElse: () => HospitalsResponseModel(name: '')
      );
      final hospitalB = widget.hospitalsDataList?.firstWhere(
        (h) => h.hospitalId == b.hospital,
        orElse: () => HospitalsResponseModel(name: '')
      );
      
      final nameA = hospitalA?.name?.toLowerCase() ?? '';
      final nameB = hospitalB?.name?.toLowerCase() ?? '';
      
      return isAscending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
    });
    
    return List.from(departments);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTopBar(title: "Medical Departments",),
                verticalSpace(20),
                SearchAndFilterBar(
                  searchController: searchController,
                  onFilterPressed: _onFilterPressed,
                  hintText: "Search Hospital's Name....",
                ),
                verticalSpace(12),
                MedicalDepartmentsGridView(
                  departmentsDataList: _filteredDepartments,
                  doctorsDataList: widget.doctorsDataList,
                  hospitalsDataList: widget.hospitalsDataList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}