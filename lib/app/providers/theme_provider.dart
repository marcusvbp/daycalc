import 'package:daycalc/app/services/theme_preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

enum AppThemeMode { light, dark, system }

@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  final _themePreferencesService = ThemePreferencesService();
  
  @override
  Future<AppThemeMode> build() async {
    // Carrega o tema salvo nas preferências
    return await _themePreferencesService.getThemeMode();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    // Salva o tema nas preferências
    await _themePreferencesService.saveThemeMode(mode);
    // Atualiza o estado
    state = AsyncData(mode);
  }
}
