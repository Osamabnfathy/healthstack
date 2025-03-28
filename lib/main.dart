import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:healthstack/core/routing/app_router.dart';
import 'package:healthstack/health_stack_app.dart';

void main() {
  // setupGetIt();
  runApp(
    HealthStackApp(
      appRouter: AppRouter(),
    )
  );
}
