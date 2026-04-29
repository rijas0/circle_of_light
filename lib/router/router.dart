import 'package:circle_of_light/app/app_shell.dart';
import 'package:circle_of_light/features/create_circle/presentation/create_join_circle.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes:<RouteBase>[
    GoRoute(path: '/',builder: (context, state) => AppShell(),
    routes: <RouteBase>[
        GoRoute(
          path: 'create-join-room',
          builder: (context, state) => CreateJoinCircle(),
        ),
      ],
    ),
    
  ] 
);