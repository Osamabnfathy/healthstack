import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        
        focusedBorder: focusedBorder ??
          OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.mainBlue,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
        
        enabledBorder: enabledBorder ??
          OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.lighterGray,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
        
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        
        hintStyle: hintStyle ?? TextStyles.font14LightGrayRegular,
        hintText: hintText,
        
        suffixIcon: suffixIcon,
        
        fillColor: backgroundColor ?? ColorsManager.moreLightGray,
        filled: true,
        
        // Add error text style
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 12.sp,
        ),
      ),
      
      obscureText: isObscureText ?? false,
      style: TextStyles.font14DarkBlueMedium,
      validator: (value) {
        return validator(value);
      },
    );
  }
}