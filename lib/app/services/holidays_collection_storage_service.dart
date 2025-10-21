import 'dart:convert';

import 'package:daycalc/app/models/holidays_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HolidaysCollectionStorageService {
  static const String _storageKey = 'holidays_collection';

  /// Salva a coleção de feriados em Shared Preferences como JSON
  Future<void> save(HolidaysCollection collection) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(collection.toJson());
    await prefs.setString(_storageKey, jsonString);
  }

  /// Carrega a coleção de feriados do Shared Preferences
  /// Retorna `null` se não houver dados ou em caso de erro de parsing
  Future<HolidaysCollection?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    try {
      final Map<String, dynamic> json = jsonDecode(jsonString) as Map<String, dynamic>;
      return HolidaysCollection.fromJson(json);
    } catch (_) {
      // Em caso de falha no parsing, retornamos null para evitar crashes
      return null;
    }
  }

  /// Remove a coleção salva
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  /// Indica se há dados previamente salvos
  Future<bool> hasData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_storageKey);
  }
}