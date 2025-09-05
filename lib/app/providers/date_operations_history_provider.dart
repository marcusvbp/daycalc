import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/models/date_operation_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_operations_history_provider.g.dart';

@riverpod
class DateOperationsHistory extends _$DateOperationsHistory {
  @override
  List<DateOperationRecord> build() {
    return [];
  }

  /// Adiciona uma nova operação ao histórico
  void addOperation({
    required OperationType operationType,
    required int totalHours,
    DateTime? timestamp,
  }) {
    final record = DateOperationRecord(
      operationType: operationType,
      totalHours: totalHours,
      timestamp: timestamp ?? DateTime.now(),
    );

    state = [...state, record];
  }

  /// Remove uma operação do histórico pelo índice
  void removeOperation(int index) {
    if (index >= 0 && index < state.length) {
      state = state
          .asMap()
          .entries
          .where((entry) => entry.key != index)
          .map((entry) => entry.value)
          .toList();
    }
  }

  /// Remove uma operação específica do histórico
  void removeOperationRecord(DateOperationRecord record) {
    state = state.where((item) => item != record).toList();
  }

  /// Limpa todo o histórico
  void clearHistory() {
    state = [];
  }

  /// Obtém operações por tipo
  List<DateOperationRecord> getOperationsByType(OperationType type) {
    return state.where((record) => record.operationType == type).toList();
  }

  /// Obtém operações realizadas em uma data específica
  List<DateOperationRecord> getOperationsByDate(DateTime date) {
    return state.where((record) {
      return record.timestamp.year == date.year &&
          record.timestamp.month == date.month &&
          record.timestamp.day == date.day;
    }).toList();
  }

  /// Obtém operações realizadas em um período
  List<DateOperationRecord> getOperationsInPeriod(
    DateTime startDate,
    DateTime endDate,
  ) {
    return state.where((record) {
      return record.timestamp.isAfter(
            startDate.subtract(const Duration(days: 1)),
          ) &&
          record.timestamp.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  /// Obtém o total de horas por tipo de operação
  Map<OperationType, int> getTotalHoursByType() {
    final Map<OperationType, int> totals = {
      OperationType.add: 0,
      OperationType.subtract: 0,
    };

    for (final record in state) {
      totals[record.operationType] =
          totals[record.operationType]! + record.totalHours;
    }

    return totals;
  }

  /// Obtém estatísticas do histórico
  Map<String, dynamic> getHistoryStats() {
    if (state.isEmpty) {
      return {
        'totalOperations': 0,
        'totalAddHours': 0,
        'totalSubtractHours': 0,
        'netHours': 0,
        'firstOperation': null,
        'lastOperation': null,
      };
    }

    final totals = getTotalHoursByType();
    final sortedByDate = List<DateOperationRecord>.from(state)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return {
      'totalOperations': state.length,
      'totalAddHours': totals[OperationType.add]!,
      'totalSubtractHours': totals[OperationType.subtract]!,
      'netHours': totals[OperationType.add]! - totals[OperationType.subtract]!,
      'firstOperation': sortedByDate.first,
      'lastOperation': sortedByDate.last,
    };
  }
}
