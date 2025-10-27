import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:daycalc/app/config/constants.dart';
import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/enums/time_unit.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/models/date_calculator.dart';
import 'package:daycalc/app/models/date_range_calculator.dart';
import 'package:daycalc/app/providers/date_operations_history_provider.dart';
import 'package:daycalc/app/providers/date_operations_provider.dart';
import 'package:daycalc/app/providers/user_date_provider.dart';
import 'package:daycalc/app/screens/home/widgets/check_holidays_button.dart';
import 'package:daycalc/app/screens/home/widgets/native_banner.dart';
import 'package:daycalc/app/utils/format_localized_date.dart';
import 'package:daycalc/app/widgets/rebuild_loop.dart';
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

    final notifier = ref.read(dateOperationsProvider.notifier);
    final dateOperations = ref.watch(dateOperationsProvider);
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

  int _getNumericValueFromDuration(Duration duration, TimeUnit timeUnit) {
    switch (timeUnit) {
      case TimeUnit.hours:
        return duration.inHours;
      case TimeUnit.days:
        return duration.inDays;
      case TimeUnit.weeks:
        return duration.inDays ~/ 7;
      case TimeUnit.months:
        return (duration.inDays / 30.44).round();
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDate = ref.watch(userDateProvider);
    final localizations = AppLocalizations.of(context)!;
    final dateOperations = ref.watch(dateOperationsProvider);
    final timeConversions = ref
        .read(dateOperationsProvider.notifier)
        .timeConversions;

    ref.listen(dateOperationsProvider, (previous, next) {
      if (next.isHistoryRestored) {
        setState(() {
          _currentNumber = _getNumericValueFromDuration(
            next.interval,
            next.timeUnit,
          );
          numberController.text = _currentNumber.toString();
          isCalculated = false;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          _scrollToBottom();
          ref.read(dateOperationsProvider.notifier).setIsHistoryRestored(false);
        });
      }
    });

    return Scaffold(
      body: Column(
        children: [
          RebuildLoop(child: NativeBanner(adUnitId: admobHomeId)),
          Expanded(
            child: SingleChildScrollView(
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
                  Card(
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
                          _scrollToBottom();
                        }
                      },
                    ),
                  ),

                  // Data selecionada
                  if (userDate != null)
                    Card(
                      clipBehavior: Clip.antiAlias,

                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Expanded(
                              child: Text(
                                '${localizations.selectedDate}: ${getLocalizedDate(userDate, AppLocalizations.of(context)!.localeName)}',
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
                          onSelectionChanged:
                              (Set<OperationType> newSelection) {
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
                            focusNode: numberFocusNode,
                            controller: numberController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            maxLength: 4,
                            decoration: InputDecoration(
                              labelText: localizations.number,
                              border: OutlineInputBorder(),
                              hintText: '0',
                              isDense: true,
                              counter: const SizedBox.shrink(),
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
                                child: Text(
                                  _getTimeUnitLabel(unit, localizations),
                                ),
                              );
                            }).toList(),
                            onChanged: (TimeUnit? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _dateCalculator = null;
                                  isCalculated = false;
                                });
                                ref
                                    .read(dateOperationsProvider.notifier)
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
                                  final dtOp = ref.read(dateOperationsProvider);

                                  setState(() {
                                    isCalculated = true;
                                    _dateCalculator = DateCalculator(
                                      date: userDate,
                                      interval: dtOp.interval,
                                      operationType: dtOp.operationType,
                                      languageCode: AppLocalizations.of(
                                        context,
                                      )!.localeName,
                                    );
                                  });
                                  if (!dtOp.isHistoryRestored) {
                                    ref
                                        .read(
                                          dateOperationsHistoryProvider
                                              .notifier,
                                        )
                                        .addOperation(
                                          initialDate: userDate,
                                          operationType: dtOp.operationType,
                                          interval: dtOp.interval,
                                          timeUnit: dtOp.timeUnit,
                                          timestamp: DateTime.now(),
                                        );
                                  } else {
                                    ref
                                        .read(dateOperationsProvider.notifier)
                                        .setIsHistoryRestored(false);
                                  }
                                  _scrollToBottom();
                                }
                              : null,
                          icon: Icon(Icons.calculate),
                          tooltip: localizations.calculate,
                          color: Theme.of(context).colorScheme.onPrimary,
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
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
                      return Row(
                        spacing: 8,
                        children: [...partOne, ...partTwo],
                      );
                    },
                  ),
                  // Exibição do resultado formatado
                  if (isCalculated)
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _makeLabel(
                                        localizations.finalDate,
                                        _dateCalculator!.formattedDate,
                                      ),
                                      if (dateOperations.operationType ==
                                          OperationType.add)
                                        _makeLabel(
                                          localizations.workingDays,
                                          '${DateRangeCalculator.calculateDaysOptimized(_dateCalculator!.date, _dateCalculator!.calculatedDate)['diasUteis'].toString()} *',
                                        ),
                                      if (dateOperations.operationType ==
                                          OperationType.subtract)
                                        _makeLabel(
                                          localizations.workingDays,
                                          '${DateRangeCalculator.calculateDaysOptimized(_dateCalculator!.calculatedDate, _dateCalculator!.date)['diasUteis'].toString()} *',
                                        ),
                                      _makeLabel(
                                        null,
                                        '* ${localizations.notConsiderHolidays}',
                                      ),
                                      if (dateOperations.operationType ==
                                          OperationType.add)
                                        _makeLabel(
                                          localizations.weekends,
                                          DateRangeCalculator.calculateDaysOptimized(
                                            _dateCalculator!.date,
                                            _dateCalculator!.calculatedDate,
                                          )['finsDeSemana'].toString(),
                                        ),
                                      if (dateOperations.operationType ==
                                          OperationType.subtract)
                                        _makeLabel(
                                          localizations.weekends,
                                          DateRangeCalculator.calculateDaysOptimized(
                                            _dateCalculator!.calculatedDate,
                                            _dateCalculator!.date,
                                          )['finsDeSemana'].toString(),
                                        ),
                                      _makeLabel(
                                        dateOperations.operationType.symbol,
                                        ref
                                            .read(
                                              dateOperationsProvider.notifier,
                                            )
                                            .formatDurationToString(
                                              AppLocalizations.of(
                                                context,
                                              )!.localeName,
                                            ),
                                        showSeparator: false,
                                      ),
                                      _makeLabel(
                                        localizations.interval,
                                        timeConversions[showTimeUnit.name]
                                            .toString(),
                                      ),
                                      Center(
                                        child: SizedBox(
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
                                              visualDensity:
                                                  VisualDensity.compact,
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
                                                    showTimeUnit =
                                                        newSelection.first;
                                                  });
                                                },
                                            segments: TimeUnit.values.map((
                                              unit,
                                            ) {
                                              return ButtonSegment<TimeUnit>(
                                                value: unit,
                                                icon: null,
                                                label: Text(
                                                  _getTimeUnitLabel(
                                                    unit,
                                                    localizations,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            CheckHolidaysButton(
                              startDate: _dateCalculator!.date,
                              endDate: _dateCalculator!.calculatedDate,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
