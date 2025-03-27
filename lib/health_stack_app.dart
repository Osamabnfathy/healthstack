import 'package:flutter/material.dart';
import 'package:healthstack/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthStackApp extends StatelessWidget {
  final AppRouter appRouter;
  
  const HealthStackApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'hospital App',
        theme: ThemeData(
          primaryColor:ColorsManager.mainBlue,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.onBoardingScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
