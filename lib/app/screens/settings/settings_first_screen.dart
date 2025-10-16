import 'package:daycalc/app/screens/settings/widgets/settings_content.dart';
import 'package:flutter/material.dart';

class SettingsFirstScreen extends StatelessWidget {
  const SettingsFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Obrigado por escolher o DayCalc!',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Antes de prosseguir, por favor, configure as seguintes opções:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SettingsContent(),
          ],
        ),
      ),
    );
  }
}
