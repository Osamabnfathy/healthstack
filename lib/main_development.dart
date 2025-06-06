import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healthstack/medicare_app.dart';
import 'package:healthstack/core/helpers/constants.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/routing/app_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/di/dependency_injection.dart';
import 'package:healthstack/core/helpers/shared_pref_helper.dart';
import 'package:healthstack/core/networking/notification_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await setupGetIt();
  await ScreenUtil.ensureScreenSize();
  await checkIfLogedInUser();
  await NotificationService.init();
  await requestNotificationPermission();
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

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }
}