// lib/features/home/ui/widgets/menu_item.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';// Assuming ColorsManager is here

// Renamed class for clarity, made public if used across features potentially
class MenuItemData {
  final String title;
  final Image? image; // Keep using Image type if already loading asset
  final IconData? icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  MenuItemData(
    this.title,
    this.bgColor,
    this.iconColor,
    this.onTap, {
    this.icon,
    this.image,
  });
}

// The widget that displays a single menu item
class MenuItemWidget extends StatelessWidget {
  final MenuItemData item;

  const MenuItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // Original _buildMenuItem logic
    return Material(
      color: Colors.transparent, // InkWell handles background/splash
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: item.bgColor.withOpacity(0.3), // Add splash feedback
        highlightColor: item.bgColor.withOpacity(0.1), // Add highlight feedback
        
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w), // Adjusted padding
          decoration: BoxDecoration(
            color: Colors.white, // Background for the item row
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08), // Softer shadow
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: item.bgColor,
                  shape: BoxShape.circle,
                ),
                // Logic to display image or icon
                child: item.image ??
                    (item.icon != null
                        ? Icon(item.icon!,
                            color: item.iconColor,
                            size: 22.sp) // Slightly smaller icon
                        : SizedBox.shrink()), // Fallback if neither exists
              ),
              horizontalSpace(16),
              
              // SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyles.font15DarkBlueMedium,
                ),
              ),
              
              Icon(Icons.arrow_forward_ios,
                  size: 16.sp, color: ColorsManager.lightGray),
            ],
          ),
        ),
      ),
    );
  }
}
