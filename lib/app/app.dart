import 'package:circle_of_light/features/auth/presentation/providers/provider.dart';
import 'package:circle_of_light/features/get_started/presentation/provider/provider.dart';
import 'package:circle_of_light/router/router.dart';
import 'package:flutter/material.dart';

import 'package:circle_of_light/core/constants/app_strings.dart';
import 'package:circle_of_light/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircleOfLightApp extends ConsumerStatefulWidget {
  const CircleOfLightApp({super.key});

  @override
  ConsumerState<CircleOfLightApp> createState() => _CircleOfLightAppState();
}

class _CircleOfLightAppState extends ConsumerState<CircleOfLightApp> {
  @override
  void initState() {
    super.initState();
    ref.read(authNotifierProvider.notifier).restoreSession();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final router = ref.watch(goRouterProvider);

    ref.listen(authNotifierProvider, (prev, next) {
      final wasInitializing = prev?.isInitializing ?? true;
      final isNowReady = !next.isInitializing;
      final justLoggedIn = prev?.user == null && next.user != null;

      if ((wasInitializing && isNowReady && next.user != null) || justLoggedIn) {
        ref.read(userCircleCheckNotifierProvider.notifier).checkUserHasCircle();
      }
    });

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
      builder: authState.isInitializing ? (context, child) => _buildSplash() : null,
    );
  }

  Widget _buildSplash() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
      ),
    );
  }
}
