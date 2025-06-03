import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';

class TestSection extends StatelessWidget {
  final List<PrescriptionTestModel>? tests;

  TestSection({
    super.key,
    required this.tests,
  });

  final TextStyle _labelStyle = TextStyles.font12RegularBlueSemiBold;
  final TextStyle _valueStyle = TextStyles.font12DarkBlueRegular;

  @override
  Widget build(BuildContext context) {
    final List<PrescriptionTestModel> _testsData = List.from(tests ?? []);
    
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGray,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.regularBlue.withOpacity(0.07),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle('Test'),
          
          if (_testsData.isEmpty)
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                "No tests prescribed.",
                style: _valueStyle,
                textAlign: TextAlign.center,
              ),
            )
            
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _testsData.length,
              itemBuilder: (context, index) {
                return _buildTestCard(_testsData[index], index + 1);
              },
              separatorBuilder: (context, index) => verticalSpace(12),
            ),
            
          if (_testsData.isNotEmpty) verticalSpace(8),
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

  Widget _buildTestCard(PrescriptionTestModel test, int index) {
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
            
            child: Text('Test $index', style: TextStyles.font14BlueBold),
          ),
          
          _buildFieldRow('Test Name', getDisplayText(test.testName)),
          _buildDivider(),
          
          _buildFieldRow('Test Price', getDisplayText(test.testInfoPrice)),
          _buildDivider(),
          
          _buildFieldRow('Description', getDisplayText(test.testDescription)),
          _buildDivider(),
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
            width: 90.w,
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
        thickness: 1,
        height: 0.2,
      ),
    );
  }
}