import 'package:flutter/material.dart';
import 'package:healthstack/features/change_password/logic/change_password_cubit.dart';
import 'package:healthstack/features/change_password/logic/change_password_state.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/extensions.dart';



class ChangePasswordBlocListener extends StatelessWidget {
  const ChangePasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          current is ChangePasswordLoading ||
          current is ChangePasswordSuccess ||
          current is ChangePasswordError,
      listener: (context, state) {
        state.whenOrNull(
          changePasswordLoading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainBlue,
                ),
              ),
            );
          },
          changePasswordSuccess: (signupResponse) {
            context.pop();
            showSuccessDialog(context);
          },
          changePasswordError: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Changed Successfully'),
          
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Done, you have changed your password successfully!'),
              ],
            ),
          ),
          
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                context.pushNamedAndRemoveUntil(
                  Routes.homeScreen,
                  (route) => false, predicate: (Route<dynamic> route) { return false; },
                );
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
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
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}