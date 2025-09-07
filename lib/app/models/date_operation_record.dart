import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/enums/time_unit.dart';

/// Modelo de dados para um registro de operação no histórico
class DateOperationRecord {
  final OperationType operationType;
  final int totalHours;
  final TimeUnit timeUnit;
  final DateTime timestamp;
  final DateTime initialDate;

  const DateOperationRecord({
    required this.operationType,
    required this.totalHours,
    required this.timeUnit,
    required this.timestamp,
    required this.initialDate,
  });

  /// Converte horas totais para diferentes unidades de tempo
  Map<String, int> formatHoursToUnits() {
    final int totalHours = this.totalHours.abs();

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

  /// Formata as horas em uma string legível
  String formatHoursToString() {
    final units = formatHoursToUnits();
    final List<String> parts = [];

    if (units['years']! > 0) {
      parts.add('${units['years']} ${units['years'] == 1 ? 'ano' : 'anos'}');
    }
    if (units['months']! > 0) {
      parts.add('${units['months']} ${units['months'] == 1 ? 'mês' : 'meses'}');
    }
    if (units['weeks']! > 0) {
      parts.add(
        '${units['weeks']} ${units['weeks'] == 1 ? 'semana' : 'semanas'}',
      );
    }
    if (units['days']! > 0) {
      parts.add('${units['days']} ${units['days'] == 1 ? 'dia' : 'dias'}');
    }
    if (units['hours']! > 0) {
      parts.add('${units['hours']} ${units['hours'] == 1 ? 'hora' : 'horas'}');
    }

    if (parts.isEmpty) {
      return '0 horas';
    }

    return parts.join(', ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateOperationRecord &&
        other.operationType == operationType &&
        other.totalHours == totalHours &&
        other.timeUnit == timeUnit &&
        other.timestamp == timestamp &&
        other.initialDate == initialDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'operationType': operationType.name,
      'totalHours': totalHours,
      'timeUnit': timeUnit.name,
      'timestamp': timestamp.toIso8601String(),
      'initialDate': initialDate.toIso8601String(),
    };
  }

  factory DateOperationRecord.fromJson(Map<String, dynamic> json) {
    return DateOperationRecord(
      operationType: OperationType.values.byName(json['operationType']),
      totalHours: json['totalHours'],
      timeUnit: TimeUnit.values.byName(json['timeUnit'] ?? 'hours'),
      timestamp: DateTime.parse(json['timestamp']),
      initialDate: DateTime.parse(json['initialDate']),
    );
  }

  @override
  int get hashCode =>
      operationType.hashCode ^
      totalHours.hashCode ^
      timeUnit.hashCode ^
      timestamp.hashCode ^
      initialDate.hashCode;

  @override
  String toString() {
    return 'DateOperationRecord(operationType: $operationType, totalHours: $totalHours, timeUnit: $timeUnit, timestamp: $timestamp, initialDate: $initialDate)';
  }
}
