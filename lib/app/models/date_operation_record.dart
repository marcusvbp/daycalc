import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/enums/time_unit.dart';
import 'package:daycalc/app/utils/format_hours_to_string.dart';

/// Modelo de dados para um registro de operação no histórico
class DateOperationRecord {
  final OperationType operationType;
  final Duration interval;
  final TimeUnit timeUnit;
  final DateTime timestamp;
  final DateTime initialDate;

  const DateOperationRecord({
    required this.operationType,
    required this.interval,
    required this.timeUnit,
    required this.timestamp,
    required this.initialDate,
  });

  /// Converte duração para diferentes unidades de tempo
  Map<String, int> formatDurationToUnits() {
    final int totalHours = interval.inHours.abs();

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

  /// Formata a duração em uma string legível
  String formatDurationToString(String languageCode) {
    final units = formatDurationToUnits();
    return hoursToString(units, languageCode);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateOperationRecord &&
        other.operationType == operationType &&
        other.interval == interval &&
        other.timeUnit == timeUnit &&
        other.timestamp == timestamp &&
        other.initialDate == initialDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'operationType': operationType.name,
      'interval': interval.inMilliseconds,
      'timeUnit': timeUnit.name,
      'timestamp': timestamp.toIso8601String(),
      'initialDate': initialDate.toIso8601String(),
    };
  }

  factory DateOperationRecord.fromJson(Map<String, dynamic> json) {
    return DateOperationRecord(
      operationType: OperationType.values.byName(json['operationType']),
      interval: Duration(
        milliseconds: json['interval'] ?? json['totalHours'] * 60 * 60 * 1000,
      ),
      timeUnit: TimeUnit.values.byName(json['timeUnit'] ?? 'hours'),
      timestamp: DateTime.parse(json['timestamp']),
      initialDate: DateTime.parse(json['initialDate']),
    );
  }

  @override
  int get hashCode =>
      operationType.hashCode ^
      interval.hashCode ^
      timeUnit.hashCode ^
      timestamp.hashCode ^
      initialDate.hashCode;

  @override
  String toString() {
    return 'DateOperationRecord(operationType: $operationType, interval: $interval, timeUnit: $timeUnit, timestamp: $timestamp, initialDate: $initialDate)';
  }
}
