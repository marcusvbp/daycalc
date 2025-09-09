import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/enums/time_unit.dart';
import 'package:daycalc/utils/format_hours_to_string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_operations_provider.g.dart';

@Riverpod(keepAlive: true)
class DateOperationsNotifier extends _$DateOperationsNotifier {
  @override
  DateOperationsState build() {
    return const DateOperationsState();
  }

  void setOperationType(OperationType type) {
    state = state.copyWith(operationType: type);
  }

  void setIsHistoryRestored(bool isRestored) {
    state = state.copyWith(isHistoryRestored: isRestored);
  }

  void setTimeUnit(TimeUnit unit) {
    state = state.copyWith(timeUnit: unit);
  }

  void setTotalHours(int hours) {
    state = state.copyWith(totalHours: hours);
  }

  // Métodos para adicionar horas a partir de diferentes unidades de tempo
  void addHours(int hours) {
    state = state.copyWith(totalHours: hours);
  }

  void addDays(int days) {
    state = state.copyWith(totalHours: days * 24);
  }

  void addWeeks(int weeks) {
    state = state.copyWith(totalHours: weeks * 24 * 7);
  }

  void addMonths(int months) {
    // Considerando 30 dias por mês em média
    state = state.copyWith(totalHours: (months * 24 * 30.44).toInt());
  }

  void addYears(int years) {
    // Considerando 365 dias por ano
    state = state.copyWith(totalHours: years * 24 * 365);
  }

  // Métodos para formatar o número de horas em diferentes unidades
  Map<String, int> formatHoursToUnits() {
    final int totalHours = state.totalHours.abs();

    final int years = totalHours ~/ (24 * 365);
    final int remainingHoursAfterYears = totalHours % (24 * 365);

    final int months = remainingHoursAfterYears ~/ (24 * 30);
    final int remainingHoursAfterMonths = remainingHoursAfterYears % (24 * 30);

    final int weeks = remainingHoursAfterMonths ~/ (24 * 7);
    final int remainingHoursAfterWeeks = remainingHoursAfterMonths % (24 * 7);

    final int days = remainingHoursAfterWeeks ~/ 24;
    final int hours = remainingHoursAfterWeeks % 24;

    return {
      'years': years,
      'months': months,
      'weeks': weeks,
      'days': days,
      'hours': hours,
    };
  }

  String formatHoursToString(String languageCode) {
    final units = formatHoursToUnits();
    return hoursToString(units, languageCode);
  }

  // Métodos para limpar e resetar
  void clear() {
    state = DateOperationsState(
      operationType: state.operationType,
      timeUnit: state.timeUnit,
      isHistoryRestored: state.isHistoryRestored,
    );
  }

  void reset() {
    clear();
  }

  // Método para aplicar a operação em uma data
  DateTime applyOperationToDate(DateTime date) {
    switch (state.operationType) {
      case OperationType.add:
        return date.add(Duration(hours: state.totalHours));
      case OperationType.subtract:
        return date.subtract(Duration(hours: state.totalHours));
    }
  }

  // Getter que retorna um map com conversões das horas totais para diferentes unidades
  Map<String, num> get timeConversions {
    final double totalHours = state.totalHours.toDouble();

    return {
      'hours': totalHours % 1 == 0
          ? totalHours.toInt()
          : double.parse(totalHours.toStringAsFixed(1)),
      'days': (totalHours / 24) % 1 == 0
          ? (totalHours / 24).toInt()
          : double.parse((totalHours / 24).toStringAsFixed(1)),
      'weeks': (totalHours / (24 * 7)) % 1 == 0
          ? (totalHours / (24 * 7)).toInt()
          : double.parse((totalHours / (24 * 7)).toStringAsFixed(1)),
      'months': (totalHours / (24 * 30)) % 1 == 0
          ? (totalHours / (24 * 30)).toInt()
          : double.parse((totalHours / (24 * 30)).toStringAsFixed(1)),
    };
  }
}

class DateOperationsState {
  final OperationType operationType;
  final int totalHours;
  final TimeUnit timeUnit;
  final bool isHistoryRestored;

  const DateOperationsState({
    this.operationType = OperationType.add,
    this.totalHours = 0,
    this.timeUnit = TimeUnit.days,
    this.isHistoryRestored = false,
  });

  DateOperationsState copyWith({
    OperationType? operationType,
    int? totalHours,
    TimeUnit? timeUnit,
    bool? isHistoryRestored,
  }) {
    return DateOperationsState(
      operationType: operationType ?? this.operationType,
      totalHours: totalHours ?? this.totalHours,
      timeUnit: timeUnit ?? this.timeUnit,
      isHistoryRestored: isHistoryRestored ?? this.isHistoryRestored,
    );
  }

  int get totalTimeByTimeUnit {
    switch (timeUnit) {
      case TimeUnit.hours:
        return totalHours;
      case TimeUnit.days:
        return totalHours ~/ 24;
      case TimeUnit.weeks:
        return totalHours ~/ (24 * 7);
      case TimeUnit.months:
        return totalHours ~/ (24 * 30);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateOperationsState &&
        other.operationType == operationType &&
        other.totalHours == totalHours &&
        other.timeUnit == timeUnit &&
        other.isHistoryRestored == isHistoryRestored;
  }

  @override
  int get hashCode =>
      operationType.hashCode ^
      totalHours.hashCode ^
      timeUnit.hashCode ^
      isHistoryRestored.hashCode;
}
