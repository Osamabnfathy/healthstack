import 'package:flutter/material.dart';
import 'package:healthstack/health_stack_app.dart';
import 'package:healthstack/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/di/dependency_injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp(
    HealthStackApp(appRouter: AppRouter(),)
  );
}
