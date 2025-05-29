import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/extensions.dart'; // For context.pop() if you use it
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_state.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  const ForgetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      // Listen to all relevant states
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {},
          success: (response) {
            // Dismiss loading indicator if shown
            context.pop();
            // Show success message (e.g., SnackBar)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.message ?? 'Password reset instructions sent! Check your email.'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );
            
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) { // Check if widget is still in the tree
                 context.pushReplacementNamed(Routes.loginScreen); // Example: Go back
              }
            });
          },
          error: (error) {
            // Show error dialog using the helper method
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(), // Listener itself doesn't build UI
    );
  }

  // Re-used error dialog logic (can be moved to a shared helper file)
  void setupErrorState(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font15DarkBlueMedium, // Adjust style if needed
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Dismiss dialog
            },
            child: Text(
              'Got it',
              style: TextStyles.font14BlueSemiBold, // Adjust style if needed
            ),
          ),
        ],
      ),
    );
  }
}