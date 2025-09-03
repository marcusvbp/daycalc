// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'DayCalc';

  @override
  String get welcome => '¡Bienvenido a DayCalc!';

  @override
  String counter(String count) {
    return 'Contador: $count';
  }

  @override
  String get changeTheme => 'Cambiar tema';

  @override
  String get chooseTheme => 'Elegir tema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Oscuro';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get close => 'Cerrar';

  @override
  String get settings => 'Configuración';

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get sunday => 'Dom';

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mié';

  @override
  String get thursday => 'Jue';

  @override
  String get friday => 'Vie';

  @override
  String get saturday => 'Sáb';

  @override
  String get selectDate => 'Seleccionar fecha';

  @override
  String get dataOperations => 'Operaciones de Fecha';

  @override
  String get number => 'Número';

  @override
  String get unit => 'Unidad';

  @override
  String get add => 'Agregar';

  @override
  String get subtract => 'Restar';

  @override
  String get hours => 'Horas';

  @override
  String get days => 'Días';

  @override
  String get weeks => 'Semanas';

  @override
  String get months => 'Meses';

  @override
  String get years => 'Años';

  @override
  String get calculate => 'Calcular';

  @override
  String get selectedDate => 'Fecha seleccionada';
}
