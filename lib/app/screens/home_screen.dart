import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/date_operations_provider.dart';
import 'package:daycalc/app/providers/user_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum TimeUnit { hours, days, weeks, months }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TimeUnit _selectedTimeUnit = TimeUnit.days;
  int _currentNumber = 0;

  void _updateTimeValue(WidgetRef ref, int number) {
    setState(() {
      _currentNumber = number;
    });

    final notifier = ref.read(dateOperationsProvider.notifier);
    final operationType = ref.read(dateOperationsProvider).operationType;

    // Limpar valores anteriores
    notifier.clear();

    // Adicionar novo valor baseado na unidade selecionada
    switch (_selectedTimeUnit) {
      case TimeUnit.hours:
        if (operationType == OperationType.add) {
          notifier.addHours(number);
        } else {
          notifier.subtractHours(number);
        }
        break;
      case TimeUnit.days:
        if (operationType == OperationType.add) {
          notifier.addDays(number);
        } else {
          notifier.subtractDays(number);
        }
        break;
      case TimeUnit.weeks:
        if (operationType == OperationType.add) {
          notifier.addWeeks(number);
        } else {
          notifier.subtractWeeks(number);
        }
        break;
      case TimeUnit.months:
        if (operationType == OperationType.add) {
          notifier.addMonths(number);
        } else {
          notifier.subtractMonths(number);
        }
        break;
    }
  }

  String _getTimeUnitLabel(TimeUnit unit, AppLocalizations localizations) {
    switch (unit) {
      case TimeUnit.hours:
        return localizations.hours;
      case TimeUnit.days:
        return localizations.days;
      case TimeUnit.weeks:
        return localizations.weeks;
      case TimeUnit.months:
        return localizations.months;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDate = ref.watch(userDateProvider);
    final localizations = AppLocalizations.of(context)!;
    final dateOperations = ref.watch(dateOperationsProvider);

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
              localizations.selectDate,
              style: Theme.of(context).textTheme.headlineSmall,
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
            // Data selecionada
            if (userDate != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        '${localizations.selectedDate}: ${ref.read(userDateProvider.notifier).getFormattedDate(AppLocalizations.of(context)!.localeName)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(userDateProvider.notifier).clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
            // Seção de operações de data
            Text(
              localizations.dataOperations,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // Campo de entrada e dropdown
            Row(
              spacing: 16,
              children: [
                // Segmented button para tipo de operação
                SegmentedButton<OperationType>(
                  segments: [
                    ButtonSegment<OperationType>(
                      value: OperationType.add,
                      icon: Icon(Icons.add),
                      tooltip: localizations.add,
                    ),
                    ButtonSegment<OperationType>(
                      value: OperationType.subtract,
                      icon: Icon(Icons.remove),
                      tooltip: localizations.subtract,
                    ),
                  ],
                  selected: {dateOperations.operationType},
                  onSelectionChanged: (Set<OperationType> newSelection) {
                    ref
                        .read(dateOperationsProvider.notifier)
                        .setOperationType(newSelection.first);
                  },
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: localizations.number,
                      border: OutlineInputBorder(),
                      hintText: '0',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final number = int.tryParse(value) ?? 0;
                      _updateTimeValue(ref, number);
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<TimeUnit>(
                    decoration: InputDecoration(
                      labelText: localizations.unit,
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    initialValue: _selectedTimeUnit,
                    items: TimeUnit.values.map((unit) {
                      return DropdownMenuItem<TimeUnit>(
                        value: unit,
                        child: Text(_getTimeUnitLabel(unit, localizations)),
                      );
                    }).toList(),
                    onChanged: (TimeUnit? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedTimeUnit = newValue;
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: _currentNumber != 0
                      ? () {
                          _updateTimeValue(ref, _currentNumber);
                        }
                      : null,
                  icon: Icon(Icons.calculate),
                  tooltip: localizations.calculate,
                  color: Theme.of(context).colorScheme.onPrimary,
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            // Exibição do resultado formatado
            if (dateOperations.totalHours > 0)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Total: ${ref.read(dateOperationsProvider.notifier).formatHoursToString()}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
