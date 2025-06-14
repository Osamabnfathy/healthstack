import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
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
  String _selectedDepartment = 'All';
  List<String> _departments = ['All'];

  @override
  void initState() {
    super.initState();
    _initializeDepartments();
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

  String getDisplayText(String? text) {
    return text?.isNotEmpty == true ? text! : 'N/A';
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
        hospitalName = '${hospital.name} - Doctors';
      }
    }

    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Header
             CustomTopBar(title: hospitalName),
             verticalSpace(30),
            // Search and Filter Section
            Container(
              color: ColorsManager.lightBlue,
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.moreLightGray,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ColorsManager.lightGray),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search doctors...',
                        hintStyle: TextStyles.font14GrayRegular,
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorsManager.gray,
                          size: 20.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                  ),
                  
                  verticalSpace(12),
                  
                  // Department Filter
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: ColorsManager.mainBlue,
                        size: 20.sp,
                      ),
                      horizontalSpace(8),
                      Text(
                        'Department:',
                        style: TextStyles.font14DarkBlueMedium,
                      ),
                      horizontalSpace(12),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: ColorsManager.moreLightGray,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ColorsManager.lightGray),
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                        style: TextStyles.font15DarkBlueMedium,
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
                      padding: EdgeInsets.all(16.w),
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
                style: TextStyles.font14DarkBlueMedium,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(DoctorsResponseModel doctor) {
    final departmentName = _getDepartmentName(doctor.departmentName);
    
    final Widget placeholderImage = Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.person,
        size: 40.sp,
        color: Colors.grey[400],
      ),
    );

    return GestureDetector(
      onTap: () {
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
              borderRadius: BorderRadius.circular(12.r),
              child: doctor.featuredImage != null && doctor.featuredImage!.isNotEmpty
                  ? Image.network(
                      doctor.featuredImage!,
                      width: 115.w,
                      height: 130.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => placeholderImage,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: ColorsManager.moreLighterGray,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
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
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.mainBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        departmentName,
                        style: TextStyles.font15DarkBlueMedium,
                      ),
                    ),     
                  verticalSpace(8),
                  // Contact Info
                  _buildInfoRow(Icons.phone, doctor.phoneNumber),
                  _buildInfoRow(Icons.schedule, doctor.visitingHour),
                  verticalSpace(4),
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
                        'Fees: ${getDisplayText(doctor.consultationFee?.toString())} EGP',
                        style: TextStyles.font12GrayMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: ColorsManager.gray.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14.sp,
            color: ColorsManager.gray.withOpacity(0.7),
          ),
          horizontalSpace(4),
          Expanded(
            child: Text(
              getDisplayText(value),
              style: TextStyles.font12GrayMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}