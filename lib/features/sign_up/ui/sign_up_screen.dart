import '../logic/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import '../../../core/theming/styles.dart';
import '../../../core/helpers/spacing.dart';
import 'widgets/already_have_account_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/app_text_button.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../login/ui/widgets/terms_and_conditions_text.dart';
import 'package:healthstack/features/sign_up/ui/widgets/sign_up_form.dart';
import 'package:healthstack/features/sign_up/ui/widgets/sign_up_bloc_listener.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.h),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(onPressed: () => Navigator.of(context).pop(), color: ColorsManager.mainBlue, 
          style: ButtonStyle(iconSize: WidgetStateProperty.all(25.sp)),)
        ),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyles.font24BlueBold,
                ),
                verticalSpace(8),
                
                Text(
                  'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                  style: TextStyles.font14GrayRegular,
                ),
                verticalSpace(20),
                
                Column(
                  children: [
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
                    verticalSpace(20),
                    
                    const AlreadyHaveAccountText(),
                    const SignupBlocListener(),
                  ],
                ),
              ],
            ),
          ),
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