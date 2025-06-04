import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';

class SpecimenDetailsSection extends StatelessWidget {
  final List<SpecimenModel>? specimenDetails;

  SpecimenDetailsSection({
    super.key,
    required this.specimenDetails,
  });

  final TextStyle _labelStyle = TextStyles.font12RegularBlueSemiBold;
  final TextStyle _valueStyle = TextStyles.font12DarkBlueRegular;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(12.r),
        
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.07),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle('Specimen Details'),
          if (specimenDetails!.isEmpty)
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                "No Specimen Details Received.",
                style: _valueStyle,
                textAlign: TextAlign.center,
              ),
            )
            
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: specimenDetails!.length,
              itemBuilder: (context, index) {
                return _buildMedicineCard(specimenDetails![index], index + 1);
              },
              separatorBuilder: (context, index) => verticalSpace(12),
            ),
            
          if (specimenDetails!.isNotEmpty) 
            verticalSpace(8),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      
      decoration: BoxDecoration(
        color: ColorsManager.regularBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      
      child: Text(
        title,
        style: TextStyles.font16morelightGrayBold,
      ),
    );
  }

  Widget _buildMedicineCard(SpecimenModel specimen, int index) {
    String formatReportDate(String? date) {
      if (date == null) return '';
      try {
        final parsed = DateTime.parse(date);
        return DateFormat('MMM d, yyyy').format(parsed); 
      } catch (_) {
        return date;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.blue.shade50),
        
        boxShadow: [
          BoxShadow(
            color: ColorsManager.regularBlue.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blue title bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            
            child: Text('Specimen $index', style: TextStyles.font14BlueBold),
          ),
          _buildFieldRow('Specimen Information', getDisplayText(specimen.specimenType)),
          _buildDivider(),
          
          _buildFieldRow('Specimen ID', getDisplayText(specimen.specimenId.toString())),
          _buildDivider(),
          
          _buildFieldRow('collection Date/time', getDisplayText(formatReportDate(specimen.collectionDate))),
          _buildDivider(),
          
          _buildFieldRow('Receiving Date/time', getDisplayText(formatReportDate(specimen.receivingDate))),
        ],
      ),
    );
  }

  Widget _buildFieldRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 135.w,
            child: Text(
              label,
              style: _labelStyle,
            ),
          ),
          
          Expanded(
            child: Text(
              value,
              style: _valueStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(
        color: Colors.blue.shade50,
        thickness: 1.2,
        height: 0.2,
      ),
    );
  }
}