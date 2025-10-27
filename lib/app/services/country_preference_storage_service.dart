import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:daycalc/app/modules/open_holidays/models/country.dart';

class CountryPreferenceStorageService {
  static const String _countryKey = 'selected_country';

  Future<Country?> getCountry() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_countryKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    try {
      final Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return Country.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> setCountry(Country country) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(country.toJson());
    await prefs.setString(_countryKey, jsonString);
  }

  Future<void> clearCountry() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_countryKey);
  }
}