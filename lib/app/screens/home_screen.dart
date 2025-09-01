import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/user_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDate = ref.watch(userDateProvider);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              'Selecione uma data:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Data selecionada
            if (userDate != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Data selecionada: ${ref.read(userDateProvider.notifier).getFormattedDate('pt_BR')}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

            // Botão para limpar a data
            if (userDate != null)
              OutlinedButton.icon(
                onPressed: () {
                  ref.read(userDateProvider.notifier).clear();
                },
                icon: const Icon(Icons.clear),
                label: const Text('Limpar Data'),
              ),
            // Calendário embutido
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  selectedDayHighlightColor: Theme.of(
                    context,
                  ).colorScheme.primary,
                  centerAlignModePicker: true,
                  firstDayOfWeek: 1, // Segunda-feira como primeiro dia
                  weekdayLabels: [
                    localizations.sunday,
                    localizations.monday,
                    localizations.tuesday,
                    localizations.wednesday,
                    localizations.thursday,
                    localizations.friday,
                    localizations.saturday,
                  ],
                ),
                value: userDate != null ? [userDate] : [],
                onValueChanged: (dates) {
                  if (dates.isNotEmpty) {
                    ref.read(userDateProvider.notifier).add(dates.first);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
