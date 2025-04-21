import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/helpers/constants.dart';
import 'package:healthstack/core/networking/dio_factory.dart';
import 'package:healthstack/core/helpers/shared_pref_helper.dart';
import 'package:healthstack/features/login/data/repos/login_repo.dart';
import 'package:healthstack/features/login/logic/cubit/login_state.dart';
import 'package:healthstack/features/login/data/models/login_request_body.dart';


class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        username: userNameController.text,
        password: passwordController.text,
      ),
    );
    response.when(success: (loginResponse) async {
      await saveUserToken(loginResponse.access ?? '');
      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
