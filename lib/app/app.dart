// ignore: unused_import
import 'package:circle_of_light/features/auth/presentation/pages/login_screen.dart';
import 'package:circle_of_light/router/router.dart';
import 'package:flutter/material.dart';

import 'package:circle_of_light/core/constants/app_strings.dart';
import 'package:circle_of_light/core/theme/app_theme.dart';

class CircleOfLightApp extends StatelessWidget {
  const CircleOfLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: router,
    );
  }
}
