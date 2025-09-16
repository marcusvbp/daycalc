import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/enums/time_unit.dart';
import 'package:daycalc/app/utils/format_hours_to_string.dart';
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

  void setInterval(Duration duration) {
    state = state.copyWith(interval: duration);
  }

  // Métodos para adicionar tempo a partir de diferentes unidades de tempo
  void addHours(int hours) {
    state = state.copyWith(interval: Duration(hours: hours));
  }

  void addDays(int days) {
    state = state.copyWith(interval: Duration(days: days));
  }

  void addWeeks(int weeks) {
    state = state.copyWith(interval: Duration(days: weeks * 7));
  }

  void addMonths(int months) {
    // Considerando 30.44 dias por mês em média
    state = state.copyWith(interval: Duration(days: (months * 30.44).round()));
  }

  void addYears(int years) {
    // Considerando 365 dias por ano
    state = state.copyWith(interval: Duration(days: years * 365));
  }

  // Métodos para formatar a duração em diferentes unidades
  Map<String, int> formatDurationToUnits() {
    final int totalHours = state.interval.inHours.abs();

    final int years = totalHours ~/ (24 * 365);
    final int remainingHoursAfterYears = totalHours % (24 * 365);

    final int months = remainingHoursAfterYears ~/ (24 * 30.44);
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

  String formatDurationToString(String languageCode) {
    final units = formatDurationToUnits();
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
        return date.add(state.interval);
      case OperationType.subtract:
        return date.subtract(state.interval);
    }
  }

  // Getter que retorna um map com conversões da duração para diferentes unidades
  Map<String, num> get timeConversions {
    final double totalHours = state.interval.inHours.toDouble();

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
  final Duration interval;
  final TimeUnit timeUnit;
  final bool isHistoryRestored;

  const DateOperationsState({
    this.operationType = OperationType.add,
    this.interval = Duration.zero,
    this.timeUnit = TimeUnit.days,
    this.isHistoryRestored = false,
  });

  DateOperationsState copyWith({
    OperationType? operationType,
    Duration? interval,
    TimeUnit? timeUnit,
    bool? isHistoryRestored,
  }) {
    return DateOperationsState(
      operationType: operationType ?? this.operationType,
      interval: interval ?? this.interval,
      timeUnit: timeUnit ?? this.timeUnit,
      isHistoryRestored: isHistoryRestored ?? this.isHistoryRestored,
    );
  }

  Duration get totalTimeByTimeUnit {
    switch (timeUnit) {
      case TimeUnit.hours:
        return interval;
      case TimeUnit.days:
        return Duration(days: interval.inDays);
      case TimeUnit.weeks:
        return Duration(days: interval.inDays ~/ 7 * 7);
      case TimeUnit.months:
        return Duration(days: (interval.inDays / 30.44).floor() * 30);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateOperationsState &&
        other.operationType == operationType &&
        other.interval == interval &&
        other.timeUnit == timeUnit &&
        other.isHistoryRestored == isHistoryRestored;
  }

  @override
  int get hashCode =>
      operationType.hashCode ^
      interval.hashCode ^
      timeUnit.hashCode ^
      isHistoryRestored.hashCode;
}
