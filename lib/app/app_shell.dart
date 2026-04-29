import 'package:circle_of_light/features/circles/presentation/pages/circle_dashboard_page.dart';
import 'package:circle_of_light/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:circle_of_light/features/get_started/presentation/get_started_page.dart';
import 'package:flutter/material.dart';
import 'package:circle_of_light/core/constants/app_strings.dart';
import 'package:circle_of_light/features/profile/presentation/pages/profile_page.dart';
import 'package:circle_of_light/features/reflections/presentation/pages/reflections_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  bool hasJoined = false;

  static const _pages = [
    DashboardPage(),
    CircleDashboard(),
    ReflectionsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: hasJoined ? IndexedStack(index: _currentIndex, children: _pages) : GetStartedScreen(),
      ),
      bottomNavigationBar: hasJoined ? NavigationBar(
        backgroundColor: const Color(0xFF07120A),
        labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: AppStrings.homeTab,
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: AppStrings.circlesTab,
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: AppStrings.reflectionsTab,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: AppStrings.profileTab,
          ),
        ],
      ):null,
    );
  }
}
