import 'package:go_router/go_router.dart';

import '../app/app_shell.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/quran/presentation/pages/all_surahs_screen.dart';
import '../features/tasks/presentation/pages/tasks_page.dart';
import '../features/reflections/presentation/pages/reflections_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/create_circle/presentation/create_join_circle.dart';
import '../features/auth/presentation/pages/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',

  routes: [

    /// 🔐 Login (outside shell)
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    /// 🧱 Shell (Bottom Navigation)
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },
      routes: [

        GoRoute(
          path: '/',
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