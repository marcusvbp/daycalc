import 'package:daycalc/app/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferencesService {
  static const String _themeKey = 'theme_mode';

  /// Salva o modo de tema selecionado pelo usuário
  Future<bool> saveThemeMode(AppThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_themeKey, themeMode.index);
  }

  /// Recupera o modo de tema salvo anteriormente
  Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);
    
    if (themeIndex == null) {
      return AppThemeMode.system; // Valor padrão se não houver preferência salva
    }
    
    return AppThemeMode.values[themeIndex];
  }
}