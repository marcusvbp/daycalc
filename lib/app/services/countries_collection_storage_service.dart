import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:daycalc/app/models/countries_collection.dart';

class CountriesCollectionStorageService {
  static const String _storageKey = 'countries_collection_cache';

  Future<CountriesCollection?> getCollection() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    try {
      final Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return CountriesCollection.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> setCollection(CountriesCollection collection) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(collection.toJson());
    await prefs.setString(_storageKey, jsonString);
  }

  Future<void> clearCollection() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}