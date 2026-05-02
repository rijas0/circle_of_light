import 'package:circle_of_light/app/app_shell.dart';
import 'package:circle_of_light/core/utils/go_router_refresh_notifier.dart';
import 'package:circle_of_light/features/auth/presentation/pages/login_screen.dart';
import 'package:circle_of_light/features/auth/presentation/providers/provider.dart';
import 'package:circle_of_light/features/create_circle/presentation/create_join_circle.dart';
import 'package:circle_of_light/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:circle_of_light/features/get_started/presentation/get_started_page.dart';
import 'package:circle_of_light/features/profile/presentation/pages/profile_page.dart';
import 'package:circle_of_light/features/quran/presentation/pages/all_surahs_screen.dart';
import 'package:circle_of_light/features/reflections/presentation/pages/reflections_page.dart';
import 'package:circle_of_light/features/tasks/presentation/pages/tasks_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authNotifierProvider);
  //final authNotifier = ref.read(authNotifierProvider.notifier);
  final notifier = ref.watch(authNotifierProvider.notifier);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshNotifier(notifier.stream),

    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final isLoggedIn = authState.user != null;
      final hasRoom = authState.hasJoinedRoom;

      final isLoginPage = state.matchedLocation == '/login';

      /// Not logged in → go login
      if (!isLoggedIn) {
        return isLoginPage ? null : '/login';
      }

      if (isLoggedIn && isLoginPage) {
        // If they are logged in but on login page, send them where they belong
        return hasRoom ? '/dash' : '/';
      }

      if (isLoggedIn && state.matchedLocation == '/') {
        return hasRoom ? '/dash' : '/';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const GetStartedScreen(),
          ),
          GoRoute(
            path: '/dash',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/quran',
            builder: (context, state) => const AllSurahsScreen(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TasksPage(),
          ),
          GoRoute(
            path: '/reflections',
            builder: (context, state) => const ReflectionsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/create-join-room',
            builder: (context, state) => const CreateJoinCircle(),
          ),
        ],
      ),
    ],
  );
});