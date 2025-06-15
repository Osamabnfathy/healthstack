import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/di/dependency_injection.dart';
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_state.dart';
import 'package:healthstack/features/forget_password/ui/widgets/email_text_form.dart';
import 'package:healthstack/features/forget_password/ui/widgets/forget_password_bloc_listener.dart';
import 'package:healthstack/features/forget_password/ui/widgets/reset_password.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 13.w),
            child: BackButton(
              onPressed: () => Navigator.of(context).pop(),
              color: ColorsManager.darkBlue,
              style: ButtonStyle(iconSize: WidgetStateProperty.all(25.sp)),
            ),
          )
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                final cubit = context.read<ForgetPasswordCubit>();
                return Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyles.font24BlueBold,
                        ),
                        verticalSpace(10),
                        Text(
                          'No worries!!! Enter your email address below and we will send you email to reset your password.',
                          style: TextStyles.font14GrayRegular,
                        ),
                        verticalSpace(60),
                        EmailTextForm(
                          controller:
                              cubit.emailController, // Pass the controller
                        ),
                        verticalSpace(40),
                        ResetPasswordButton(
                          onPressed: () {
                            cubit.requestPasswordReset();
                          },
                          isLoading: state is Loading,
                        ),
                        const ForgetPasswordBlocListener(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
