import 'package:daycalc/app/screens/home/home_screen.dart';
import 'package:daycalc/app/screens/settings/settings_first_screen.dart';
import 'package:daycalc/app/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

GoRouter buildRouter({required bool showSettingsFirst}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: showSettingsFirst ? '/settings-first' : '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings-first',
        name: 'settingsFirst',
        builder: (context, state) => const SettingsFirstScreen(),
      ),
    ],
  );
}
