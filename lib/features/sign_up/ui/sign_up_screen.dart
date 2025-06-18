import '../logic/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import '../../../core/theming/styles.dart';
import '../../../core/helpers/spacing.dart';
import 'widgets/already_have_account_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import '../../login/ui/widgets/terms_and_conditions_text.dart';
import 'package:healthstack/features/sign_up/ui/widgets/sign_up_form.dart';
import 'package:healthstack/features/sign_up/ui/widgets/sign_up_bloc_listener.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: CustomTopBar(title: "Create Account"),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(5),
                    Text(
                      'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                      style: TextStyles.font14GrayRegular,
                    ),
                    verticalSpace(20),
                    const SignupForm(),
                    verticalSpace(20),
                    AppTextButton(
                      buttonText: "Create Account",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        validateThenDoSignup(context);
                      },
                    ),
                    verticalSpace(16),
                    const TermsAndConditionsText(),
                    verticalSpace(16),
                    Center(child: const AlreadyHaveAccountText()),
                    const SignupBlocListener(),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<SignupCubit>().formKey.currentState!.validate()) {
      context.read<SignupCubit>().emitSignupStates();
    }
  }
}