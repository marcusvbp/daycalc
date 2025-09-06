import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/models/date_operation_record.dart';
import 'package:daycalc/app/services/date_operations_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_operations_history_provider.g.dart';

@riverpod
class DateOperationsHistoryNotifier extends _$DateOperationsHistoryNotifier {
  @override
  Future<List<DateOperationRecord>> build() async {
    try {
      return await DateOperationsStorageService.loadOperations();
    } catch (e) {
      // Em caso de erro, retorna lista vazia
      return [];
    }
  }

  /// Adiciona uma nova operação ao histórico
  Future<void> addOperation({
    required OperationType operationType,
    required int totalHours,
    required DateTime initialDate,
    DateTime? timestamp,
  }) async {
    try {
      // Obtém o histórico atual
      final currentHistory = await future;

      // Cria o novo registro
      final record = DateOperationRecord(
        operationType: operationType,
        totalHours: totalHours,
        initialDate: initialDate,
        timestamp: timestamp ?? DateTime.now(),
      );

      // Adiciona ao histórico
      final updatedHistory = [...currentHistory, record];

      // Salva no armazenamento
      await DateOperationsStorageService.saveOperations(updatedHistory);

      // Atualiza o estado
      state = AsyncValue.data(updatedHistory);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Remove uma operação do histórico pelo índice
  Future<void> removeOperation(int index) async {
    try {
      // Obtém o histórico atual
      final currentHistory = await future;

      if (index >= 0 && index < currentHistory.length) {
        // Remove o item pelo índice
        final updatedHistory = currentHistory
            .asMap()
            .entries
            .where((entry) => entry.key != index)
            .map((entry) => entry.value)
            .toList();

        // Salva no armazenamento
        await DateOperationsStorageService.saveOperations(updatedHistory);

        // Atualiza o estado
        state = AsyncValue.data(updatedHistory);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Remove uma operação específica do histórico
  Future<void> removeOperationRecord(DateOperationRecord record) async {
    try {
      // Obtém o histórico atual
      final currentHistory = await future;

      // Remove o registro específico
      final updatedHistory = currentHistory
          .where((item) => item != record)
          .toList();

      // Salva no armazenamento
      await DateOperationsStorageService.saveOperations(updatedHistory);

      // Atualiza o estado
      state = AsyncValue.data(updatedHistory);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Limpa todo o histórico
  Future<void> clearHistory() async {
    try {
      // Salva lista vazia no armazenamento
      await DateOperationsStorageService.saveOperations([]);

      // Atualiza o estado
      state = AsyncValue.data([]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Obtém operações por tipo
  List<DateOperationRecord> getOperationsByType(OperationType type) {
    final currentState = state;
    if (currentState is! AsyncData<List<DateOperationRecord>>) {
      return [];
    }
    return currentState.value
        .where((record) => record.operationType == type)
        .toList();
  }

  /// Obtém operações realizadas em uma data específica
  List<DateOperationRecord> getOperationsByDate(DateTime date) {
    final currentState = state;
    if (currentState is! AsyncData<List<DateOperationRecord>>) {
      return [];
    }
    return currentState.value.where((record) {
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
    final currentState = state;
    if (currentState is! AsyncData<List<DateOperationRecord>>) {
      return [];
    }
    return currentState.value.where((record) {
      return record.timestamp.isAfter(
            startDate.subtract(const Duration(days: 1)),
          ) &&
          record.timestamp.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  /// Obtém o total de horas por tipo de operação
  Map<OperationType, int> getTotalHoursByType() {
    final currentState = state;
    if (currentState is! AsyncData<List<DateOperationRecord>>) {
      return {OperationType.add: 0, OperationType.subtract: 0};
    }

    final Map<OperationType, int> totals = {
      OperationType.add: 0,
      OperationType.subtract: 0,
    };

    for (final record in currentState.value) {
      totals[record.operationType] =
          totals[record.operationType]! + record.totalHours;
    }

    return totals;
  }

  /// Obtém estatísticas do histórico
  Map<String, dynamic> getHistoryStats() {
    final currentState = state;
    if (currentState is! AsyncData<List<DateOperationRecord>>) {
      return {
        'totalOperations': 0,
        'totalAddHours': 0,
        'totalSubtractHours': 0,
        'netHours': 0,
        'firstOperation': null,
        'lastOperation': null,
      };
    }

    final history = currentState.value;
    if (history.isEmpty) {
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
    final sortedByDate = List<DateOperationRecord>.from(history)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return {
      'totalOperations': history.length,
      'totalAddHours': totals[OperationType.add]!,
      'totalSubtractHours': totals[OperationType.subtract]!,
      'netHours': totals[OperationType.add]! - totals[OperationType.subtract]!,
      'firstOperation': sortedByDate.first,
      'lastOperation': sortedByDate.last,
    };
  }
}
