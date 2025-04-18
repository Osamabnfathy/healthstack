import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';


class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final double rating;
  final int reviews;
  final String imageUrl;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: ColorsManager.gray.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 102.w,
              height: 110.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          horizontalSpace(12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyles.font18DarkBlueBold),
                verticalSpace(4),
                
                Text(
                  '$specialty • $hospital',
                  style: TextStyles.font13DarkBlueMedium
                      .copyWith(color: ColorsManager.gray),
                ),
                verticalSpace(8),
                
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    
                    const SizedBox(width: 4),
                    
                    Text('$rating', style: TextStyles.font12GrayMedium),
                    
                    Text(' ($reviews reviews)', style: TextStyles.font12GrayMedium),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}