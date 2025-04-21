import 'package:flutter/material.dart';
import 'package:healthstack/medicare_app.dart';
import 'package:healthstack/core/helpers/constants.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/di/dependency_injection.dart';
import 'package:healthstack/core/helpers/shared_pref_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  await checkIfLogedInUser();
  runApp(
    HealthStackApp(appRouter: AppRouter(),)
  );
}

checkIfLogedInUser() async{
  String? userToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if(userToken.isNullOrEmpty()){
    isLoggedInUser = false;
  } 
  else {
    isLoggedInUser = true;
  } 
}