import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/screens/history_tab_screen.dart';
import 'package:daycalc/app/screens/home_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTabScreen(),
          HistoryTabScreen(
            onNavigateToHomeTab: () {
              _tabController.animateTo(0);
            },
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        indicatorColor: Colors.black,
        labelPadding: const EdgeInsets.only(bottom: 16),
        controller: _tabController,
        tabs: [
          Tab(icon: const Icon(Icons.calculate), text: 'Calculadora'),
          Tab(icon: const Icon(Icons.history), text: 'Histórico'),
        ],
      ),
    );
  }
}
