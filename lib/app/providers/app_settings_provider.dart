import 'package:daycalc/app/models/app_settings.dart';
import 'package:daycalc/app/services/app_settings_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_provider.g.dart';

@Riverpod(keepAlive: true)
class AppSettingsNotifier extends _$AppSettingsNotifier {
  late final AppSettingsStorageService _storage;

  @override
  Future<AppSettings> build() async {
    _storage = AppSettingsStorageService();
    return await _storage.getSettings();
  }

  Future<void> setSettings(AppSettings settings) async {
    await _storage.setSettings(settings);
    state = AsyncData(settings);
  }

  Future<void> setValues({required bool showSettingsFirst}) async {
    final settings =
        state.value?.copyWith(showSettingsFirst: showSettingsFirst) ??
        AppSettings(showSettingsFirst: showSettingsFirst);

    await _storage.setSettings(settings);
    state = AsyncData(settings);
  }

  Future<void> clearSettings() async {
    await _storage.clearSettings();
    state = AsyncData(AppSettings());
  }
}
