import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/features/prescriptions/ui/widgets/prescriptions_card.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_models.dart';

class PrescriptionsList extends StatelessWidget {
  const PrescriptionsList({super.key});

  static final List<Prescription> _prescriptions = [
    Prescription(
      id: 36,
      doctorName: 'Ahmed Khalid',
      specialization: 'Dentistry',
      hospital: 'Qena Hospital',
      avatarUrl: 'assets/images/doctor_avatar.png',
    ),
    Prescription(
      id: 35,
      doctorName: 'Mahmoud Sayed',
      specialization: 'surgery',
      hospital: 'Esna Hospital',
      avatarUrl: 'assets/images/doctor_avatar.png',
    ),
    Prescription(
      id: 34,
      doctorName: 'Sara Ibrahim',
      specialization: 'Cardiology',
      hospital: 'Central Hospital',
      avatarUrl: 'assets/images/doctor_avatar_female.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderRow(),
        verticalSpace(16),
        
        Expanded(
          child: _prescriptions.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: _prescriptions.length,
                  itemBuilder: (context, index) {
                    return PrescriptionCard(
                      prescription: _prescriptions[index],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.gray.withOpacity(0.2)),
        
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkBlue.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'ID',
              style: TextStyles.font16DarkBlueBold,
            ),
          ),
          horizontalSpace(16),
          
          Expanded(
            flex: 3,
            child: Text(
              'Doctor ',
              style: TextStyles.font16DarkBlueBold,
            ),
          ),
          horizontalSpace(60),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64.sp,
            color: ColorsManager.lightGray,
          ),
          verticalSpace(16),
          Text(
            'No prescriptions found',
            style: TextStyles.font15DarkBlueMedium,
          ),
        ],
      ),
    );
  }
}