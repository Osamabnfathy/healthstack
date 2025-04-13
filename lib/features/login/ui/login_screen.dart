import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/app_text_button.dart';
import 'package:healthstack/features/login/logic/cubit/login_cubit.dart';
import 'package:healthstack/features/login/ui/widgets/email_and_password.dart';
import 'package:healthstack/features/login/ui/widgets/login_bloc_listener.dart';
import 'package:healthstack/features/login/ui/widgets/dont_have_account_text.dart';
import 'package:healthstack/features/login/ui/widgets/terms_and_conditions_text.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                verticalSpace(30),
                Text(
                  'Welcome Back',
                  style: TextStyles.font24BlueBold,
                ),
                verticalSpace(8),
                
                Text(
                  'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                  style: TextStyles.font14GrayRegular,
                ),
                verticalSpace(80),
                
                Column(
                  children: [
                    const EmailAndPassword(),
                    verticalSpace(5),
                    
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: RichText(
                        text: TextSpan(
                          text: 'Forgot Password?',
                          style: TextStyles.font13BlueRegular,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed(Routes.forgetPasswordScreen);
                            },
                        ),
                      ),
                    ),
                    verticalSpace(66),
                    
                    AppTextButton(
                      buttonText: "Login",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        validateThenDoLogin(context);
                      },
                    ),
                    verticalSpace(16),
                    
                    const TermsAndConditionsText(),
                    verticalSpace(60),
                    
                    const DontHaveAccountText(),
                    
                    const LoginBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
