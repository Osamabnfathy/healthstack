import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/app_regex.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../login/ui/widgets/password_validations.dart';
import 'package:healthstack/features/sign_up/logic/sign_up_cubit.dart';


class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPasswordObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<SignupCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Username',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid username';
              }
            },
            controller: context.read<SignupCubit>().usernameController,
          ),
          verticalSpace(18),
          
          AppTextFormField(
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
            controller: context.read<SignupCubit>().emailController,
          ),
          verticalSpace(18),
          
          AppTextFormField(
            controller: context.read<SignupCubit>().passwordController,
            hintText: 'Password',
            isObscureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpace(18),
          
          AppTextFormField(
            hintText: 'First Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid first name';
              }
            },
            controller: context.read<SignupCubit>().firstNameController,
          ),
          verticalSpace(18),
          
          AppTextFormField(
            hintText: 'Last Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid first name';
              }
            },
            controller: context.read<SignupCubit>().lastNameController,
          ),
          verticalSpace(18),
      
          PasswordValidations(
            hasLowerCase: hasLowercase,
            hasUpperCase: hasUppercase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}