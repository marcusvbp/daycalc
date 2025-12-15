import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/app_settings_provider.dart';
import 'package:daycalc/app/screens/settings/widgets/settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsFirstScreen extends ConsumerWidget {
  const SettingsFirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                localizations.settingsWelcomeTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                localizations.settingsSetupHint,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SettingsContent(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(appSettingsProvider.notifier)
                        .setValues(showSettingsFirst: false);
                    context.pushReplacement('/');
                  },
                  child: Text(localizations.continueLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
