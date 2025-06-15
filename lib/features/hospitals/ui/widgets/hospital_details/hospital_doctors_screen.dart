import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/core/widgets/icon_text_row.dart';
import 'package:healthstack/core/widgets/search_bar.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctor_details/doctor_details_screen.dart';

class HospitalDoctorsScreen extends StatefulWidget {
  final int hospitalId;
  final List<DoctorsResponseModel>? doctorsData;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final List<DepartmentsResponseModel>? departmentsDataList;

  const HospitalDoctorsScreen({
    super.key,
    required this.doctorsData,
    required this.hospitalId,
    required this.hospitalsDataList,
    required this.departmentsDataList,
  });

  @override
  State<HospitalDoctorsScreen> createState() => _HospitalDoctorsScreenState();
}

class _HospitalDoctorsScreenState extends State<HospitalDoctorsScreen> {
  String _searchQuery = '';
  late TextEditingController _searchController;
  bool _isSorted = true;
  String _selectedDepartment = 'All';
  List<String> _departments = ['All'];

  @override
  void initState() {
    super.initState();
    _initializeDepartments();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }
  
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }
  
  void _onFilterPressed() {
    setState(() {
      _isSorted = !_isSorted;
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initializeDepartments() {
    if (widget.departmentsDataList != null) {
      final departmentNames = widget.departmentsDataList!
          .map((dept) => dept.hospitalDepartmentName ?? 'Unknown')
          .where((name) => name != 'Unknown')
          .toSet()
          .toList();
      
      setState(() {
        _departments = ['All', ...departmentNames];
      });
    }
  }

  String? _getDepartmentName(int? departmentId) {
    if (departmentId == null || widget.departmentsDataList == null) return null;
    
    final matchingDepartment = widget.departmentsDataList!.firstWhere(
      (dept) => dept.hospitalDepartmentId == departmentId,
      orElse: () => DepartmentsResponseModel(
        hospitalDepartmentId: null,
        hospitalDepartmentName: null,
      ),
    );
    
    return matchingDepartment.hospitalDepartmentName;
  }

  List<DoctorsResponseModel> _getFilteredDoctors() {
    final filteredDoctors = widget.doctorsData?.where((doctor) {
      return doctor.hospitalName == widget.hospitalId;
    }).toList() ?? [];

    return filteredDoctors.where((doctor) {
      final matchesSearch = doctor.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false;
      final departmentName = _getDepartmentName(doctor.departmentName);
      final matchesDepartment = _selectedDepartment == 'All' || 
                              departmentName == _selectedDepartment;
      
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _getFilteredDoctors();
    
    // Get hospital name
    String hospitalName = 'Hospital Doctors';
    if (widget.hospitalsDataList != null) {
      final hospital = widget.hospitalsDataList!.firstWhere(
      (h) => h.hospitalId == widget.hospitalId,
      orElse: () => HospitalsResponseModel(hospitalId: null, name: null),
      );
      if (hospital.name != null) {
      final words = hospital.name!.split(' ');
      final firstTwoWords = words.length >= 2
        ? '${words[0]} ${words[1]}'
        : hospital.name!;
      hospitalName = '$firstTwoWords Doctors';
      }
    }

    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: CustomTopBar(title: hospitalName),
              ),
              verticalSpace(15),
              // Search and Filter Section
              Container(
                color: ColorsManager.lightBlue,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    SearchAndFilterBar(
                      searchController: _searchController, 
                      onFilterPressed: _onFilterPressed,
                    ),
                    
                    verticalSpace(12),
                    
                    // Department Filter
                    Row(
                      children: [
                        Text(
                          'Department:',
                          style: TextStyles.font18DarkBlueBold,
                        ),
                        horizontalSpace(12),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: ColorsManager.moreLightGray,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: ColorsManager.lightGray.withOpacity(0.5), width: 1.6),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedDepartment,
                                isExpanded: true,
                                style: TextStyles.font14DarkBlueRegular,
                                items: _departments.map((String department) {
                                  return DropdownMenuItem<String>(
                                    value: department,
                                    child: Text(department),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedDepartment = newValue ?? 'All';
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            // Results Summary
            Container(
              color: ColorsManager.lightBlue,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Row(
                children: [
                  Text(
                    '${filteredDoctors.length} Doctor${filteredDoctors.length != 1 ? 's' : ''} Found',
                    style: TextStyles.font12GrayMedium,
                ),
                const Spacer(),
                if (_searchQuery.isNotEmpty || _selectedDepartment != 'All')
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _selectedDepartment = 'All';
                      });
                    },
                    child: Text(
                      'Clear Filters',
                      style: TextStyles.font13DarkBlueMedium,
                    ),
                  ),
              ],
            ),
            ),
            
            // Doctors List
            Expanded(
              child: filteredDoctors.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal:16.w, vertical: 8.h),
                      itemCount: filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = filteredDoctors[index];
                        return _buildDoctorCard(doctor);
                      },
                    ),
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80.sp,
            color: Colors.grey[400],
          ),
          verticalSpace(16),
          Text(
            _searchQuery.isNotEmpty || _selectedDepartment != 'All'
                ? 'No doctors found matching your criteria'
                : 'No doctors found for this hospital',
            style: TextStyles.font16GrayMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          if (_searchQuery.isNotEmpty || _selectedDepartment != 'All')
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _selectedDepartment = 'All';
                });
              },
              child: Text(
                'Clear Filters',
                style: TextStyles.font13DarkBlueMedium,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(DoctorsResponseModel doctor) {
    final departmentName = _getDepartmentName(doctor.departmentName);
    
    final Widget placeholderImage = Container(
      width: 110.w,
      height: 110.h,
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray,
        borderRadius: BorderRadius.circular(1200.r),
      ),
      child: Icon(
        Icons.person,
        size: 40.sp,
        color: Colors.grey[400],
      ),
    );

    return GestureDetector(
      onTap: () {
        if (doctor.doctorId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(
                doctorsData: doctor,
                hospitalsData: widget.hospitalsDataList,
                departmentsData: widget.departmentsDataList,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsManager.moreLightGray,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.gray.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Doctor Image
            ClipRRect(
              borderRadius: BorderRadius.circular(1200.r),
              child: doctor.featuredImage != null && doctor.featuredImage!.isNotEmpty
                  ? Image.network(
                      doctor.featuredImage!,
                      width: 110.w,
                      height: 110.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => placeholderImage,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 110.w,
                          height: 110.h,
                          decoration: BoxDecoration(
                            color: ColorsManager.moreLighterGray,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 50.w,
                              height: 50.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorsManager.mainBlue,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : placeholderImage,
            ),          
            horizontalSpace(16),        
            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Name
                  Text(
                    "Dr. ${getDisplayText(doctor.name)}",
                    style: TextStyles.font16DarkBlueBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),         
                  verticalSpace(4), 
                  // Department Badge
                  if (departmentName != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.mainBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        getDisplayText(departmentName),
                        style: TextStyles.font15DarkBlueMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  verticalSpace(8),
                  // Contact Info
                  buildInfoRow(Icons.phone, getDisplayText(doctor.phoneNumber)),
                  buildInfoRow(Icons.schedule, getDisplayText(doctor.visitingHour)),
                  // Fees
                  Row(
                    children: [
                      Icon(
                        Icons.payment,
                        size: 14.sp,
                        color: ColorsManager.gray,
                      ),
                      horizontalSpace(4),
                      Text(
                        'Fees: ${getDisplayText(doctor.reportFee?.toString())} - ${getDisplayText(doctor.consultationFee?.toString())} EGP',
                        style: TextStyles.font12GrayMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Arrow Icon
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 2.w),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorsManager.gray.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}