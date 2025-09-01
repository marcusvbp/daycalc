import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLocale { en, es, pt }

class LocalePreferenceService {
  static const String _localeKey = 'app_locale';

  /// Carrega a preferência de idioma salva ou retorna o padrão (pt_BR)
  Future<AppLocale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString(_localeKey);

    if (localeString == null) {
      return AppLocale.pt;
    }

    try {
      return AppLocale.values.firstWhere((e) => e.toString() == localeString);
    } catch (e) {
      return AppLocale.pt;
    }
  }

  /// Salva a preferência de idioma na memória persistente
  Future<void> setLocale(AppLocale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.toString());
  }

  /// Converte um AppLocale para Locale do Flutter
  Locale getLocaleFromEnum(AppLocale locale) {
    switch (locale) {
      case AppLocale.en:
        return const Locale('en');
      case AppLocale.es:
        return const Locale('es');
      case AppLocale.pt:
        return const Locale('pt');
    }
  }
}
