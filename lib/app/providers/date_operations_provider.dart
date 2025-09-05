import 'package:daycalc/app/enums/operation_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_operations_provider.g.dart';

@riverpod
class DateOperations extends _$DateOperations {
  @override
  DateOperationsState build() {
    return const DateOperationsState();
  }

  void setOperationType(OperationType type) {
    state = state.copyWith(operationType: type);
  }

  void setTotalHours(int hours) {
    state = state.copyWith(totalHours: hours);
  }

  // Métodos para adicionar horas a partir de diferentes unidades de tempo
  void addHours(int hours) {
    state = state.copyWith(totalHours: state.totalHours + hours);
  }

  void addDays(int days) {
    state = state.copyWith(totalHours: state.totalHours + (days * 24));
  }

  void addWeeks(int weeks) {
    state = state.copyWith(totalHours: state.totalHours + (weeks * 24 * 7));
  }

  void addMonths(int months) {
    // Considerando 30 dias por mês em média
    state = state.copyWith(totalHours: state.totalHours + (months * 24 * 30));
  }

  void addYears(int years) {
    // Considerando 365 dias por ano
    state = state.copyWith(totalHours: state.totalHours + (years * 24 * 365));
  }

  // Métodos para subtrair horas a partir de diferentes unidades de tempo
  void subtractHours(int hours) {
    state = state.copyWith(totalHours: state.totalHours - hours);
  }

  void subtractDays(int days) {
    state = state.copyWith(totalHours: state.totalHours - (days * 24));
  }

  void subtractWeeks(int weeks) {
    state = state.copyWith(totalHours: state.totalHours - (weeks * 24 * 7));
  }

  void subtractMonths(int months) {
    // Considerando 30 dias por mês em média
    state = state.copyWith(totalHours: state.totalHours - (months * 24 * 30));
  }

  void subtractYears(int years) {
    // Considerando 365 dias por ano
    state = state.copyWith(totalHours: state.totalHours - (years * 24 * 365));
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

  // Métodos para limpar e resetar
  void clear() {
    state = DateOperationsState(operationType: state.operationType);
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
}

class DateOperationsState {
  final OperationType operationType;
  final int totalHours;

  const DateOperationsState({
    this.operationType = OperationType.add,
    this.totalHours = 0,
  });

  DateOperationsState copyWith({
    OperationType? operationType,
    int? totalHours,
  }) {
    return DateOperationsState(
      operationType: operationType ?? this.operationType,
      totalHours: totalHours ?? this.totalHours,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateOperationsState &&
        other.operationType == operationType &&
        other.totalHours == totalHours;
  }

  @override
  int get hashCode => operationType.hashCode ^ totalHours.hashCode;
}
