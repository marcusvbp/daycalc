import 'dart:convert';
import 'dart:developer';

import 'package:daycalc/app/models/date_operation_record.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serviço para armazenar e recuperar operações de data usando SharedPreferences
class DateOperationsStorageService {
  static const String _storageKey = 'date_operations_history';

  /// Salva uma lista de DateOperationRecord no armazenamento persistente
  static Future<bool> saveOperations(
    List<DateOperationRecord> operations,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(
        operations.map((op) => op.toJson()).toList(),
      );
      return await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      log('Erro ao salvar operações: $e');
      return false;
    }
  }

  /// Recupera a lista de DateOperationRecord do armazenamento persistente
  static Future<List<DateOperationRecord>> loadOperations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => DateOperationRecord.fromJson(json))
          .toList();
    } catch (e) {
      log('Erro ao carregar operações: $e');
      return [];
    }
  }

  /// Limpa todas as operações do armazenamento
  static Future<bool> clearOperations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_storageKey);
    } catch (e) {
      log('Erro ao limpar operações: $e');
      return false;
    }
  }
}
