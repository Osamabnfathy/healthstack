import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    // Original _buildHeader logic goes here
    return Container(
      color: ColorsManager.lightBlue,
      padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 20.w, right: 20.w),
      
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context), // Close drawer action
                child: Icon(Icons.arrow_back, color: ColorsManager.darkBlue),
              ),
              
              Text(
                'Profile',
                style: TextStyles.font18DarkBlueSemiBold,
              ),
              
              InkWell(
                onTap: () {/* Handle settings tap */},
                child: Icon(Icons.settings, color: ColorsManager.darkBlue),
              ),
            ],
          ),
          verticalSpace(20),
          
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                
                decoration: BoxDecoration(
                  color: Colors.purple.shade50, // Example color
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
                  // Consider passing image path or using network image
                  child: SvgPicture.asset(
                    'assets/svgs/general_speciality.svg', // Example image
                    fit: BoxFit.contain, // Adjust fit as needed
                    height: 50.h, // Adjust size if needed
                    width: 50.w,
                  ),
                ),
              ),
              
              InkWell(
                onTap: () {},  // Edit Navigation
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit, size: 16.sp, color: ColorsManager.mainBlue),
                ),
              ),
            ],
          ),
          verticalSpace(10),
          
          Text("Mahmoud Ahmed", style: TextStyles.font18DarkBlueBold),
          verticalSpace(4),
          
          Text("Mahmoudahmed14@gmail.com", style: TextStyles.font13GrayRegular),
        ],
      ),
    );
  }
}
