import 'package:flutter/material.dart';

import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/quran/presentation/pages/all_surahs_screen.dart';
import '../features/tasks/presentation/pages/tasks_page.dart';
import '../core/constants/app_strings.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/reflections/presentation/pages/reflections_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _pages = [
    DashboardPage(),
    AllSurahsScreen(),
    TasksPage(),
    ReflectionsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),
      bottomNavigationBar: NavigationBar(
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
}
