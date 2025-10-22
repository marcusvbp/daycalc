// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es_ES']) : super(locale);

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

  @override
  String get calculator => 'Calculadora';

  @override
  String get history => 'Histórico';

  @override
  String get finalDate => 'Fecha final';

  @override
  String get interval => 'Intervalo';

  @override
  String get errorLoadingHistory => 'Error al cargar el historial';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get clearHistory => 'Limpiar historial';

  @override
  String get clearHistoryConfirmation =>
      '¿Estás seguro de querer limpiar todo el historial de operaciones? Esta acción no puede ser deshecha.';

  @override
  String get clearHistorySuccess => 'Historial limpiado con éxito';

  @override
  String get clearHistoryError => 'Error al limpiar el historial';

  @override
  String get noHistory => 'No se encontró historial';

  @override
  String get delete => 'Eliminar';

  @override
  String get noHistoryMessage => 'Las operaciones realizadas aparecerán aquí';

  @override
  String get deleteOperation => 'Eliminar Operación';

  @override
  String get deleteOperationConfirmation =>
      '¿Estás seguro de querer eliminar la operación?';

  @override
  String get deleteOperationSuccess => 'Operación eliminada con éxito';

  @override
  String get workingDays => 'Días úteis';

  @override
  String get weekends => 'Dias de fin de semana';

  @override
  String get notConsiderHolidays => 'No considera feriados';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get portuguese => 'Portugués';

  @override
  String get settingsWelcomeTitle => '¡Gracias por elegir DayCalc!';

  @override
  String get settingsSetupHint =>
      'Antes de continuar, configure las siguientes opciones:';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get continueLabel => 'Continuar';

  @override
  String get country => 'País';

  @override
  String get selectCountry => 'Seleccione su país';

  @override
  String get countryInfo =>
      'Utilizaremos esta información para obtener la lista de feriados nacionales y escolares.';

  @override
  String get holidays => 'Feriados';

  @override
  String get cancel => 'Cancelar';

  @override
  String get dateRange => 'Intervalo de fechas';

  @override
  String get initialDate => 'Fecha inicial';

  @override
  String get countryNotSelected => 'País no seleccionado';

  @override
  String get changeCountry => 'Cambiar país';

  @override
  String get loadingCountry => 'Cargando país...';

  @override
  String errorLoadingCountries(String error) {
    return 'Error al cargar países: $error';
  }

  @override
  String errorLoadingCountry(String error) {
    return 'Error al cargar país: $error';
  }

  @override
  String get holidaysApiError =>
      'Error al intentar obtener los datos de Feriados';

  @override
  String validFrom(int year) => 'Adicione datas entre 2020 e ${year}.';

  @override
  String get dateIntervalInfo =>
      'El intervalo entre las fechas no puede ser superior a 3 años.';
}
