
import 'package:circle_of_light/features/circles/presentation/pages/circle_dashboard_screen.dart';
import 'package:circle_of_light/features/circles/presentation/pages/circle_details_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/app_shell.dart';
import '../core/utils/go_router_refresh_notifier.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/providers/provider.dart';
import '../features/auth/presentation/viewmodel/auth_state.dart';
import '../features/get_started/presentation/viewmodel/get_started_state.dart';
import '../features/circles/presentation/pages/circles_list_screen.dart';
import '../features/create_circle/presentation/page/create_join_circle.dart';
import '../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../features/get_started/presentation/get_started_screen.dart';
import '../features/get_started/presentation/provider/provider.dart';
import '../features/profile/presentation/pages/profile_screen.dart';
import '../features/quran/presentation/pages/all_surahs_screen.dart';
import '../features/reflections/presentation/pages/reflections_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshNotifier([
      ref.read(authNotifierProvider.notifier).stream,
      ref.read(userCircleCheckNotifierProvider.notifier).stream,
    ]),

    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      if (authState.isInitializing) return null;

      final isLoggedIn = authState.user != null;
      final currentLocation = state.matchedLocation;

      if (!isLoggedIn) {
        return currentLocation == '/login' ? null : '/login';
      }

      final userRoomDetails = ref.read(userCircleCheckNotifierProvider);

      // Circle check hasn't completed yet — stall until it does
      if (userRoomDetails.isLoading || userRoomDetails.userCircleStatus == null) {
        return null;
      }

      return _routeDecision(userRoomDetails, authState, currentLocation);
    },

    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: '/create-join-room',
        builder: (context, state) => const CreateJoinCircle(),
      ),
      GoRoute(path: '/circle-details',builder: (context,state){
        final id = state.extra as String;
        return CircleDashboard(circleId: id);}),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dash',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/quran',
                builder: (context, state) => const AllSurahsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/circle',
                builder: (context, state) => const CirclesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reflections',
                builder: (context, state) => const ReflectionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

String? _routeDecision(
  GetStartedState userRoomDetails,
  AuthState authState,
  String currentLocation,
) {
  final isNewUser = userRoomDetails.userCircleStatus?.isNewUser ?? true;
  final hasRoom = authState.hasJoinedRoom || !isNewUser;

  if (isNewUser) {
    final isOnboardingPage = currentLocation == '/' || currentLocation == '/create-join-room';
    if (!isOnboardingPage) return '/';
    return null;
  }

  if (hasRoom) {
    final isOutsideApp = currentLocation == '/login' ||
        currentLocation == '/' ||
        currentLocation == '/create-join-room';
    if (isOutsideApp) return '/dash';
  }

  return null;
}
