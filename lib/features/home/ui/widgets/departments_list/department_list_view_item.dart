import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';

class DepartmentsListViewItem extends StatelessWidget {
  final int? itemIndex;
  final int? selectedIndex;
  final DepartmentsResponseModel? departmentsData;
  final List<HospitalsResponseModel>? hospitalsDataList;
  final Function(int departmentId)? onDepartmentSelected;

  const DepartmentsListViewItem({
    super.key,
    this.itemIndex, 
    this.departmentsData,
    this.hospitalsDataList,
    this.selectedIndex,
    this.onDepartmentSelected,
  });
  

  @override
  Widget build(BuildContext context) {
    String? hospitalName;
    if (departmentsData?.hospital != null && hospitalsDataList != null) {
      final matchingHospital = hospitalsDataList!.firstWhere(
        (hospital) => hospital.hospitalId == departmentsData!.hospital,
        orElse: () => HospitalsResponseModel(hospitalId: null, name: 'Unknown Hospital'),
      );
      hospitalName = matchingHospital.name;
      print('matching hospital: ${matchingHospital.name}');
    }
  
    final Widget placeholderImage = Image.asset(
      'assets/icons/general.png', 
      height: 65.h, 
      width: 65.w,
      fit: BoxFit.fill, 
    );

    return GestureDetector(
      onTap: () {
        if (departmentsData?.hospitalDepartmentId != null) {
          onDepartmentSelected?.call(departmentsData!.hospitalDepartmentId!);
        }
      },
    
      child: Container(
        padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: selectedIndex == itemIndex
              ? BoxDecoration(
                border: Border.all(
                  color: ColorsManager.mainBlue,
                  width: 2.r
                ),
                shape: BoxShape.circle,  
              ): null,
              
              child: CircleAvatar(
                radius: 35.r, 
                backgroundColor: ColorsManager.lightBlue,
                
                child: ClipOval( 
                  child: departmentsData?.featuredImage != null && departmentsData!.featuredImage!.isNotEmpty
                    ? Image.network(
                        departmentsData!.featuredImage!, 
                        height: 65.h, 
                        width: 65.w, 
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) => placeholderImage,
                    )
                    : placeholderImage,
                ),
              ),
            ),
            verticalSpace(8.h),
            
            
            Text(
              departmentsData?.hospitalDepartmentName ?? 'Specialization',
              style: selectedIndex == itemIndex
                  ? TextStyles.font12DarkBlueBold 
                  : TextStyles.font12DarkBlueRegular,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            
            Text(
              getDisplayText(hospitalName),
              style: selectedIndex == itemIndex
                  ? TextStyles.font12GrayBold 
                  : TextStyles.font12GrayRegular,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}