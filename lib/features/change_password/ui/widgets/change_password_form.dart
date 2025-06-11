import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/app_regex.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_form_field.dart';
import 'package:healthstack/features/change_password/logic/change_password_cubit.dart';
import 'package:healthstack/core/widgets/password_validations.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentPasswordController = context.read<ChangePasswordCubit>().currentPasswordController;
    newPasswordController = context.read<ChangePasswordCubit>().newPasswordController;
    confirmPasswordController = context.read<ChangePasswordCubit>().confirmPasswordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    newPasswordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(newPasswordController.text);
        hasUppercase = AppRegex.hasUpperCase(newPasswordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(newPasswordController.text);
        hasNumber = AppRegex.hasNumber(newPasswordController.text);
        hasMinLength = AppRegex.hasMinLength(newPasswordController.text);
      });
    });
  }
  
  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    
    child: Form(
      key: context.read<ChangePasswordCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: currentPasswordController ,
            hintText: 'Current Password',
            isObscureText: _obscureText1,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText1 = !_obscureText1;
                });
              },
              child: Icon(
                _obscureText1 ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your current password';
              }
            },
          ),
          verticalSpace(18),
        
          AppTextFormField(
            controller: newPasswordController,
            hintText: 'New Password',
            isObscureText: _obscureText2,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              },
              child: Icon(
                _obscureText2 ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the new password';
              }
            },
          ),
          verticalSpace(18),
          
          AppTextFormField(
            controller: confirmPasswordController,
            hintText: 'Confirm New Password',
            isObscureText: _obscureText2,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              },
              child: Icon(
                _obscureText2 ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Confirmation password';
              }
              if (value != newPasswordController.text) {
                return 'Passwords do not match';
              }
            },
          ),
          verticalSpace(25),
          
          PasswordValidations(
            hasLowerCase: hasLowercase,
            hasUpperCase: hasUppercase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
        ],
      ),
    )
    );
  }
}
