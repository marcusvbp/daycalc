import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/screens/settings/widgets/settings_content.dart';
import 'package:flutter/material.dart';

class SettingsFirstScreen extends StatelessWidget {
  const SettingsFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                localizations.settingsWelcomeTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              localizations.settingsSetupHint,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SettingsContent(),
          ],
        ),
      ),
    );
  }
}
