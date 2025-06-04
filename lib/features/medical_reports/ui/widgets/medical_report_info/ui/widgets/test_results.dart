import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/medical_reports/data/models/medical_reports_response_model.dart';

class TestResultsSection extends StatelessWidget {
  final List<TestModel>? tests;

  TestResultsSection({
    super.key,
    required this.tests,
  });



  final TextStyle _labelStyle = TextStyles.font12RegularBlueSemiBold;
  final TextStyle _valueStyle = TextStyles.font12DarkBlueRegular;

  @override
  Widget build(BuildContext context) {
    final List<TestModel> _testsData = List.from(tests ?? []);
    
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
          _buildSectionTitle('Test Results'),
          if (_testsData.isEmpty)
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                "No test Results Received.",
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
            
          if (_testsData.isNotEmpty) 
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

  Widget _buildTestCard(TestModel test, int index) {
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
            child: Text('Test $index', style: TextStyles.font14BlueBold),
          ),
          
          _buildFieldRow('Test Name', getDisplayText(test.testName)),
          _buildDivider(),
          
          _buildFieldRow('Result', getDisplayText(test.result)),
          _buildDivider(),
          
          _buildFieldRow('Unit', getDisplayText(test.unit)),
          _buildDivider(),
          
          _buildFieldRow('Referred value', getDisplayText(test.referredValue)),
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
            width: 95.w,
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