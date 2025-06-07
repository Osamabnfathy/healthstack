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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeApp();

  runApp(HealthStackApp(appRouter: AppRouter()));
}

Future<void> _initializeApp() async {
  await setupGetIt();
  await ScreenUtil.ensureScreenSize();
  await _checkIfLoggedInUser();
  await _requestNotificationPermission(); 
  await NotificationService.init(); 
}

Future<void> _checkIfLoggedInUser() async {
  String? userToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if(userToken.isNullOrEmpty()){
    isLoggedInUser = false;
  } 
  else {
    isLoggedInUser = true;  
  }
}

Future<void> _requestNotificationPermission() async {
  if (Platform.isAndroid) {
    await Permission.notification.request();
    try {
    await Permission.scheduleExactAlarm.request();
    } catch (e) {
      print("⚠️ Exact alarm permission error: $e");
    }
  }
}