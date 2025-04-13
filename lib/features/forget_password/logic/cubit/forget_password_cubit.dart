import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/forget_password/data/models/forget_password_request_body.dart';
// Remove the unused import: import 'package:healthstack/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:healthstack/features/forget_password/data/repos/forget_password_repo.dart';
import 'package:healthstack/features/forget_password/logic/cubit/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo _forgetPasswordRepo;
  ForgetPasswordCubit(this._forgetPasswordRepo) : super(const ForgetPasswordState.initial());

  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Corrected method name and parameter type
  void requestPasswordReset() async {
    // Validate the form first
    if (formKey.currentState?.validate() ?? false) {
      emit(const ForgetPasswordState.loading());
      // Create the request body using the controller's value
      final forgetPasswordRequestBody = ForgetPasswordRequestBody(
        email: emailController.text.trim(), // Trim whitespace
      );
      // Corrected repository method call
      final response = await _forgetPasswordRepo.requestPasswordReset(forgetPasswordRequestBody);

      response.when(
        success: (forgetPasswordResponse) {
          // Check the response if necessary (especially if using Option A for Response Model)
          // if (forgetPasswordResponse.isSuccess) {
             emit(ForgetPasswordState.success(forgetPasswordResponse));
          // } else {
          //   emit(ForgetPasswordState.error(error: forgetPasswordResponse.error ?? 'Unknown error occurred'));
          // }
        },
        failure: (error) {
          // This assumes ErrorHandler provides a user-friendly message in apiErrorModel.message
          emit(ForgetPasswordState.error(error: error.apiErrorModel.message ?? 'An unexpected error occurred.'));
        }
      );
    }
  }

  // Dispose the controller when the Cubit is closed
  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}

