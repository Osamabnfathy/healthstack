import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/di/dependency_injection.dart'; // Assuming you use getIt
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_state.dart';
import 'package:healthstack/features/forget_password/ui/widgets/email_text_form.dart'; // Use the refined widget
import 'package:healthstack/features/forget_password/ui/widgets/forget_password_bloc_listener.dart'; // Import the new listener
import 'package:healthstack/features/forget_password/ui/widgets/reset_password.dart'; // Use the refined button

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the cubit instance using your DI setup (like getIt)
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: Scaffold(
        // AppBar might be nice
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(), 
            color: ColorsManager.mainBlue,
            style: ButtonStyle(iconSize: WidgetStateProperty.all(25.sp)), // Adjusted icon size
          ),
          
        ),
        
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h), // Adjusted vertical padding
            // Use BlocBuilder to access the cubit and its state for the Form/Button
            child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                // Get the cubit instance easily
                final cubit = context.read<ForgetPasswordCubit>();
                return Form(
                  key: cubit.formKey, // Assign the key from the cubit
                  child: SingleChildScrollView( // Prevent overflow on small screens
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text section remains the same
                        Text(
                          "Forgot Password?",
                          style: TextStyles.font24BlueBold,
                        ),
                        verticalSpace(10),
                        
                        Text(
                          'No worries!!! Enter your email address below and we will send you email to reset your password.',
                          style: TextStyles.font14GrayRegular,
                        ),
                        verticalSpace(60), // Adjusted spacing

                        // Use the refined EmailTextForm widget
                        EmailTextForm(
                          controller: cubit.emailController, // Pass the controller
                        ),
                        verticalSpace(40), // Adjusted spacing

                        // Use the refined ResetPasswordButton
                        ResetPasswordButton(
                          // Trigger the cubit action on press
                          onPressed: () {
                             // The cubit's method should handle validation via formKey
                             cubit.requestPasswordReset();
                          },
                          // Set loading state based on the cubit's state
                          isLoading: state is Loading,
                        ),

                        // Include the BlocListener to handle side effects
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