import 'package:flutter/material.dart';
import 'package:healthstack/health_stack_app.dart';
import 'package:healthstack/core/routing/app_router.dart';
import 'package:healthstack/core/di/dependency_injection.dart';

void main() {
  setupGetIt();
  runApp(
    HealthStackApp(
      appRouter: AppRouter(),
    )
  );
}
