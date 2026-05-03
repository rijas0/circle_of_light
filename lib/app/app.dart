import 'package:circle_of_light/features/auth/presentation/providers/provider.dart';
import 'package:circle_of_light/router/router.dart';
import 'package:flutter/material.dart';

import 'package:circle_of_light/core/constants/app_strings.dart';
import 'package:circle_of_light/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircleOfLightApp extends ConsumerWidget {
  const CircleOfLightApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider.notifier).restoreSession();
    });

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
