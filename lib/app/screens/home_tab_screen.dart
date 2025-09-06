import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/models/date_calculator.dart';
import 'package:daycalc/app/providers/date_operations_provider.dart';
import 'package:daycalc/app/providers/user_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimeUnit { hours, days, weeks, months }

class HomeTabScreen extends ConsumerStatefulWidget {
  const HomeTabScreen({super.key});

  @override
  ConsumerState<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> {
  TimeUnit _selectedTimeUnit = TimeUnit.days;
  int _currentNumber = 0;
  bool isCalculated = false;
  DateCalculator? _dateCalculator;
  TimeUnit showTimeUnit = TimeUnit.hours;

  void _updateTimeValue(WidgetRef ref, int number) {
    setState(() {
      _currentNumber = number;
    });

    final notifier = ref.read(dateOperationsProvider.notifier);
    final dateOperations = ref.watch(dateOperationsProvider);
    final operationType = dateOperations.operationType;

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

  Widget _makeLabel(String? label, String value) => Text.rich(
    TextSpan(
      children: [
        if (label != null)
          TextSpan(
            text: '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        TextSpan(text: value),
      ],
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final userDate = ref.watch(userDateProvider);
    final localizations = AppLocalizations.of(context)!;
    final dateOperations = ref.watch(dateOperationsProvider);
    final timeConversions = ref
        .read(dateOperationsProvider.notifier)
        .timeConversions;

    return Scaffold(
      body: SingleChildScrollView(
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
                    setState(() {
                      isCalculated = false;
                      _dateCalculator = null;
                    });
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
                        setState(() {
                          _dateCalculator = null;
                          isCalculated = false;
                        });
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
                    setState(() {
                      _dateCalculator = null;
                      isCalculated = false;
                    });
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
                          _dateCalculator = null;
                          isCalculated = false;
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: _currentNumber != 0 && userDate != null
                      ? () async {
                          _updateTimeValue(ref, _currentNumber);
                          final dtOp = ref.read(dateOperationsProvider);
                          setState(() {
                            isCalculated = true;
                            _dateCalculator = DateCalculator(
                              date: userDate,
                              hours: dtOp.totalHours,
                              operationType: dtOp.operationType,
                              languageCode: AppLocalizations.of(
                                context,
                              )!.localeName,
                            );
                          });
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
            if (isCalculated)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _makeLabel(
                            'Data Final',
                            _dateCalculator!.formattedDate,
                          ),
                          _makeLabel(
                            null,
                            ref
                                .read(dateOperationsProvider.notifier)
                                .formatHoursToString(),
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _makeLabel(
                                'Intervalo',
                                timeConversions[showTimeUnit.name].toString(),
                              ),
                              SizedBox(
                                height: 22,
                                child: SegmentedButton<TimeUnit>(
                                  selected: {showTimeUnit},
                                  showSelectedIcon: false,
                                  style: SegmentedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 10,
                                    ),
                                    alignment: Alignment.topCenter,
                                    visualDensity: VisualDensity.compact,
                                    selectedBackgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    selectedForegroundColor: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                  onSelectionChanged:
                                      (Set<TimeUnit> newSelection) {
                                        setState(() {
                                          showTimeUnit = newSelection.first;
                                        });
                                      },
                                  segments: TimeUnit.values.map((unit) {
                                    return ButtonSegment<TimeUnit>(
                                      value: unit,
                                      icon: null,
                                      label: Text(
                                        _getTimeUnitLabel(unit, localizations),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
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
