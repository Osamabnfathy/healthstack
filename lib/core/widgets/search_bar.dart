import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterPressed;
  final VoidCallback? onSearchChanged;
  final String? hintText;

  const SearchAndFilterBar({
    super.key,
    required this.searchController,
    required this.onFilterPressed,
    this.onSearchChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: hintText ?? 'Search...',
              hintStyle: TextStyles.font16LightGrayMedium,
              prefixIcon: Icon(
                Icons.search_rounded,
                color: ColorsManager.gray,
                size: 20.sp,
              ),
              
              filled: true,
              fillColor: ColorsManager.moreLightGray,
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: ColorsManager.lightGray.withOpacity(0.5), width: 1.6),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: ColorsManager.lightGray.withOpacity(0.5), width: 1.6),
              )
            ),
          ),
        ),
        horizontalSpace(12),
        
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: ColorsManager.moreLightGray,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsManager.lightGray.withOpacity(0.5), width: 1.6),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.gray.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          
          child: IconButton(
            icon: Icon(Icons.filter_list, size: 32.sp, color: ColorsManager.gray,),
            onPressed: onFilterPressed,
          ),
        ),
      ],
    );
  }
}