import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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

  // Initialize Firebase first
  await Firebase.initializeApp();

  await _initializeApp();

  runApp(HealthStackApp(appRouter: AppRouter()));
}

Future<void> _initializeApp() async {
  try {
    // Core app setup
    await setupGetIt();
    await ScreenUtil.ensureScreenSize();
    await _checkIfLoggedInUser();

    // Notification setup (includes FCM)
    await _requestNotificationPermissions();
    await NotificationService.init();

    // Schedule existing medicine reminders if user is logged in
    if (isLoggedInUser) {
      await _scheduleMedicineRemindersOnStartup();
    }

    print('✅ App initialization completed successfully');
  } catch (e) {
    print('❌ App initialization error: $e');
  }
}

/// Schedules medicine reminders for the logged-in user on app startup.
/// TODO: Implement actual scheduling logic as needed.
Future<void> _scheduleMedicineRemindersOnStartup() async {
  // Placeholder implementation
  print('⏰ Scheduling medicine reminders on startup...');
  // Add your scheduling logic here.
}

Future<void> _checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if (userToken.isNullOrEmpty()) {
    isLoggedInUser = false;
  } else {
    isLoggedInUser = true;
  }
}

Future<void> _requestNotificationPermissions() async {
  if (Platform.isAndroid) {
    // Request notification permission
    final notificationStatus = await Permission.notification.status;
    if (!notificationStatus.isGranted) {
      await Permission.notification.request();
      print(
          "🔔 Notification permission: ${await Permission.notification.status}");
    }

    // Request exact alarm permission for Android 12+
    try {
      if (Platform.isAndroid) {
        final exactAlarmStatus = await Permission.scheduleExactAlarm.status;
        if (!exactAlarmStatus.isGranted) {
          await Permission.scheduleExactAlarm.request();
        }
      }
    } catch (e) {
      print('❌ Error requesting exact alarm permission: $e');
    }
  }
}
   
/*
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
  await NotificationService.init();
  await _requestNotificationPermission();
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
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
       print("🔔 Notification permission: ${Permission.notification.request()}");
    }
  }
}
*/