import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/screens/settings/widgets/settings_content.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settings)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SettingsContent(),
      ),
    );
  }
}
