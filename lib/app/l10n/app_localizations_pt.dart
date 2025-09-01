// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'DayCalc';

  @override
  String get welcome => 'Bem-vindo ao DayCalc!';

  @override
  String counter(String count) {
    return 'Contador: $count';
  }

  @override
  String get changeTheme => 'Mudar tema';

  @override
  String get chooseTheme => 'Escolher tema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Escuro';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get close => 'Fechar';

  @override
  String get settings => 'Configurações';

  @override
  String get appearance => 'Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get sunday => 'Dom';

  @override
  String get monday => 'Seg';

  @override
  String get tuesday => 'Ter';

  @override
  String get wednesday => 'Qua';

  @override
  String get thursday => 'Qui';

  @override
  String get friday => 'Sex';

  @override
  String get saturday => 'Sáb';
}
