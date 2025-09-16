// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt_BR']) : super(locale);

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

  @override
  String get selectDate => 'Selecione uma data';

  @override
  String get dataOperations => 'Operações de Data';

  @override
  String get number => 'Número';

  @override
  String get unit => 'Unidade';

  @override
  String get add => 'Adicionar';

  @override
  String get subtract => 'Subtrair';

  @override
  String get hours => 'Horas';

  @override
  String get days => 'Dias';

  @override
  String get weeks => 'Semanas';

  @override
  String get months => 'Meses';

  @override
  String get years => 'Anos';

  @override
  String get calculate => 'Calcular';

  @override
  String get selectedDate => 'Data selecionada';

  @override
  String get calculator => 'Calculadora';

  @override
  String get history => 'Histórico';

  @override
  String get finalDate => 'Data final';

  @override
  String get interval => 'Intervalo';

  @override
  String get errorLoadingHistory => 'Erro ao carregar histórico';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get clearHistory => 'Limpar histórico';

  @override
  String get clearHistoryConfirmation =>
      'Tem certeza que deseja limpar todo o histórico de operações? Esta ação não pode ser desfeita.';

  @override
  String get clearHistorySuccess => 'Histórico limpo com sucesso';

  @override
  String get clearHistoryError => 'Erro ao limpar histórico';

  @override
  String get noHistory => 'Nenhum histórico encontrado';

  @override
  String get delete => 'Excluir';

  @override
  String get noHistoryMessage => 'As operações realizadas aparecerão aqui';

  @override
  String get deleteOperation => 'Excluir Operação';

  @override
  String get deleteOperationConfirmation =>
      'Tem certeza que deseja excluir a operação?';

  @override
  String get deleteOperationSuccess => 'Operação excluída com sucesso';

  @override
  String get workingDays => 'Dias úteis';

  @override
  String get weekends => 'Dias de fim de semana';

  @override
  String get notConsiderHolidays => 'Não leva em conta feriados';
}
