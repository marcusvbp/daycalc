import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/holidays_collection_provider.dart';
import 'package:daycalc/app/screens/settings/widgets/settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          // Reexecuta o provider sempre que a tela for fechada
          ref.read(holidaysCollectionProvider.notifier).refresh();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(localizations.settings)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: const SettingsContent(),
        ),
      ),
    );
  }
}
