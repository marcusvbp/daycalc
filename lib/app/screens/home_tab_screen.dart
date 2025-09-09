import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/enums/time_unit.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/models/date_calculator.dart';
import 'package:daycalc/app/providers/date_operations_history_provider.dart';
import 'package:daycalc/app/providers/date_operations_provider.dart';
import 'package:daycalc/app/providers/user_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabScreen extends ConsumerStatefulWidget {
  const HomeTabScreen({super.key});

  @override
  ConsumerState<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> {
  int _currentNumber = 0;
  bool isCalculated = false;
  DateCalculator? _dateCalculator;
  TimeUnit showTimeUnit = TimeUnit.hours;
  FocusNode numberFocusNode = FocusNode();
  final TextEditingController numberController = TextEditingController();
  late final ScrollController scrollController = ScrollController();

  void _updateTimeValue(WidgetRef ref, int number) {
    final num = number < 0 ? number * -1 : number;
    setState(() {
      _currentNumber = num;
    });

    final notifier = ref.read(dateOperationsNotifierProvider.notifier);
    final dateOperations = ref.watch(dateOperationsNotifierProvider);
    final timeUnit = dateOperations.timeUnit;

    // Limpar valores anteriores
    notifier.clear();

    // Adicionar novo valor baseado na unidade selecionada
    switch (timeUnit) {
      case TimeUnit.hours:
        notifier.addHours(num);

        break;
      case TimeUnit.days:
        notifier.addDays(num);

        break;
      case TimeUnit.weeks:
        notifier.addWeeks(num);

        break;
      case TimeUnit.months:
        notifier.addMonths(num);

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

  Widget _makeLabel(String? label, String value, {bool showSeparator = true}) =>
      Text.rich(
        TextSpan(
          children: [
            if (label != null)
              TextSpan(
                text: '$label${showSeparator ? ': ' : ''} ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            TextSpan(text: value),
          ],
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void didChangeDependencies() {
    final dateOperations = ref.read(dateOperationsNotifierProvider);
    if (dateOperations.isHistoryRestored) {
      setState(() {
        _currentNumber = dateOperations.totalTimeByTimeUnit;
        numberController.text = dateOperations.totalTimeByTimeUnit.toString();
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        _scrollToBottom();
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDate = ref.watch(userDateNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    final dateOperations = ref.watch(dateOperationsNotifierProvider);
    final timeConversions = ref
        .read(dateOperationsNotifierProvider.notifier)
        .timeConversions;

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
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
                    ref
                        .read(userDateNotifierProvider.notifier)
                        .add(dates.first);
                    _scrollToBottom();
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
                        '${localizations.selectedDate}: ${ref.read(userDateNotifierProvider.notifier).getFormattedDate(AppLocalizations.of(context)!.localeName)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(userDateNotifierProvider.notifier).clear();
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
            LayoutBuilder(
              builder: (context, constraints) {
                List<Widget> partOne = [
                  // Segmented button para tipo de operação
                  SegmentedButton<OperationType>(
                    showSelectedIcon: false,
                    style: SegmentedButton.styleFrom(
                      selectedBackgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary,
                      selectedForegroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
                          .read(dateOperationsNotifierProvider.notifier)
                          .setOperationType(newSelection.first);
                    },
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      focusNode: numberFocusNode,
                      controller: numberController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                ];
                List<Widget> partTwo = [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<TimeUnit>(
                      decoration: InputDecoration(
                        labelText: localizations.unit,
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      initialValue: dateOperations.timeUnit,
                      items: TimeUnit.values.map((unit) {
                        return DropdownMenuItem<TimeUnit>(
                          value: unit,
                          child: Text(_getTimeUnitLabel(unit, localizations)),
                        );
                      }).toList(),
                      onChanged: (TimeUnit? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _dateCalculator = null;
                            isCalculated = false;
                          });
                          ref
                              .read(dateOperationsNotifierProvider.notifier)
                              .setTimeUnit(newValue);
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: _currentNumber != 0 && userDate != null
                        ? () async {
                            numberFocusNode.unfocus();
                            _updateTimeValue(ref, _currentNumber);
                            final dtOp = ref.read(
                              dateOperationsNotifierProvider,
                            );

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
                            if (!dtOp.isHistoryRestored) {
                              ref
                                  .read(
                                    dateOperationsHistoryNotifierProvider
                                        .notifier,
                                  )
                                  .addOperation(
                                    initialDate: userDate,
                                    operationType: dtOp.operationType,
                                    totalHours: dtOp.totalHours,
                                    timeUnit: dtOp.timeUnit,
                                    timestamp: DateTime.now(),
                                  );
                            } else {
                              ref
                                  .read(dateOperationsNotifierProvider.notifier)
                                  .setIsHistoryRestored(false);
                            }
                            _scrollToBottom();
                          }
                        : null,
                    icon: Icon(Icons.calculate),
                    tooltip: localizations.calculate,
                    color: Theme.of(context).colorScheme.onPrimary,
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ];
                if (constraints.maxWidth <= 380) {
                  return Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(spacing: 8, children: partOne),
                      Row(spacing: 8, children: partTwo),
                    ],
                  );
                }
                return Row(spacing: 8, children: [...partOne, ...partTwo]);
              },
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
                            localizations.finalDate,
                            _dateCalculator!.formattedDate,
                          ),
                          _makeLabel(
                            dateOperations.operationType.symbol,
                            ref
                                .read(dateOperationsNotifierProvider.notifier)
                                .formatHoursToString(
                                  AppLocalizations.of(context)!.localeName,
                                ),
                            showSeparator: false,
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _makeLabel(
                                localizations.interval,
                                timeConversions[showTimeUnit.name].toString(),
                              ),
                              SizedBox(
                                height: 32,
                                child: SegmentedButton<TimeUnit>(
                                  selected: {showTimeUnit},
                                  showSelectedIcon: false,
                                  style: SegmentedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 10,
                                    ),
                                    alignment: Alignment(0, -.5),
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
