import 'dart:developer';

import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/holidays_collection_provider.dart';
import 'package:daycalc/app/providers/home_tabs_provider.dart';
import 'package:daycalc/app/screens/home/history_tab_screen.dart';
import 'package:daycalc/app/screens/home/holidays_tab_screen.dart';
import 'package:daycalc/app/screens/home/home_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final homeTabs = ref.watch(homeTabsProvider);

    ref.listen(holidaysCollectionProvider, (previous, next) {
      if (next is AsyncData) {
        log('obteve dados de feriados');
      }
      if (next is AsyncError) {
        log('erro ao obter dados de feriados');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            closeIconColor: Colors.white,
            duration: const Duration(seconds: 12),
            backgroundColor: Colors.red,
            content: Text(
              localizations.holidaysApiError,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: localizations.settings,
            onPressed: () {
              context.pushNamed('settings');
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: homeTabs,
        children: [HomeTabScreen(), HistoryTabScreen(), HolidaysTabScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeTabs,
        onTap: ref.read(homeTabsProvider.notifier).set,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.calculate),
            label: localizations.calculator,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: localizations.history,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.beach_access),
            label: localizations.holidays,
          ),
        ],
      ),
    );
  }
}
