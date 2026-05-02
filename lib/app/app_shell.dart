import 'package:circle_of_light/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int currentIndex = _computeIndex(location);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF07120A),
        labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          final routes = ['/dash', '/quran', '/tasks', '/reflections', '/profile'];
          context.go(routes[index]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: AppStrings.homeTab,
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: AppStrings.quranTab,
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist_rounded),
            label: AppStrings.tasksTab,
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note_rounded),
            label: AppStrings.reflectionsTab,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: AppStrings.profileTab,
          ),
        ],
      ),
    );
  }

  int _computeIndex(String location) {
    switch (location) {
      case '/dash':
      case '/':
        return 0;
      case '/quran':
        return 1;
      case '/tasks':
        return 2;
      case '/reflections':
        return 3;
      case '/profile':
        return 4;
      default:
        return 0;
    }
  }
}
