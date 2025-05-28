import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/change_password/data/repo/change_password_repo.dart';
import 'package:healthstack/features/change_password/logic/change_password_state.dart';
import 'package:healthstack/features/change_password/data/models/change_password_request_body.dart';


class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepo _changePasswordRepo;
  ChangePasswordCubit(this._changePasswordRepo) : super(const ChangePasswordState.initial());

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitChangePasswordState() async {
    emit(const ChangePasswordState.changePasswordLoading());
    final response = await _changePasswordRepo.changePassword(
      ChangePasswordRequestBody(
        oldPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
    );
    response.when(success: (changePasswordResponse) {
      emit(ChangePasswordState.changePasswordSuccess(changePasswordResponse));
    }, failure: (error) {
      emit(ChangePasswordState.changePasswordError(error: error.apiErrorModel.message ?? ''));
    });
  }
}