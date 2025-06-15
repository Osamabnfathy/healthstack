import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'widgets/change_password_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/change_password/logic/change_password_cubit.dart';
import 'package:healthstack/features/change_password/ui/widgets/change_password_bloc_listener.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CustomTopBar(title: 'Change Password'),
                  ),
                  verticalSpace(20),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Text(
                      "Don't use common passwords. \nMake sure to follow the password requirements. \nNew password must be diffenert from your current password.",
                      style: TextStyles.font14GrayRegular,
                    ),
                  ),
                  verticalSpace(20),
                  ChangePasswordForm(),
                  const ChangePasswordBlocListener(),
                ],
              ),
            )),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: AppTextButton(
          buttonText: "Change Password",
          textStyle: TextStyles.font16WhiteSemiBold,
          onPressed: () {
            validateThenDoChangePassword(context);
          },
        ),
      ),
    );
  }

  void validateThenDoChangePassword(BuildContext context) {
    final formState = context.read<ChangePasswordCubit>().formKey.currentState!;
    if (formState.validate()) {
      final cubit = context.read<ChangePasswordCubit>();
      cubit.emitChangePasswordState();
    }
  }
}
