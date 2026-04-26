import 'package:flutter/material.dart';

import 'package:circle_of_light/app/app_shell.dart';
import 'package:circle_of_light/core/constants/app_strings.dart';
import 'package:circle_of_light/core/theme/app_theme.dart';

class CircleOfLightApp extends StatelessWidget {
  const CircleOfLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppShell(),
    );
  }
}
