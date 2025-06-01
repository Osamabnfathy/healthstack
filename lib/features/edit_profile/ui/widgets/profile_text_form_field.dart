import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProfileTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;

  const ProfileTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorsManager.mainBlue,
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(16.0),
    );
    
    final grayBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorsManager.lighterGray,
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(16.0),
    );

    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        
        focusedBorder: readOnly ? InputBorder.none : (focusedBorder ?? border),
        enabledBorder: readOnly ? InputBorder.none : (enabledBorder ?? grayBorder),
        
        hintStyle: hintStyle ?? TextStyles.font14LightGrayRegular,
        hintText: hintText,
        
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? ColorsManager.moreLightGray,
        filled: true,
      ),
      style: inputTextStyle ?? TextStyles.font14DarkBlueMedium,
    );
  }
}