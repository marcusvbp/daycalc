import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/locale_preference_service.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  late final LocalePreferenceService _localeService;

  @override
  Future<Locale> build() async {
    _localeService = LocalePreferenceService();
    final appLocale = await _localeService.getLocale();
    return _localeService.getLocaleFromEnum(appLocale);
  }

  Future<void> setLocale(AppLocale locale) async {
    await _localeService.setLocale(locale);
    state = AsyncValue.data(_localeService.getLocaleFromEnum(locale));
  }
}
