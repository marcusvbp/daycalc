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

  @override
  String get english => 'Inglês';

  @override
  String get spanish => 'Espanhol';

  @override
  String get portuguese => 'Português';

  @override
  String get hindi => 'Híndi';

  @override
  String get settingsWelcomeTitle => 'Obrigado por escolher o DayCalc!';

  @override
  String get settingsSetupHint =>
      'Antes de prosseguir, por favor, configure as seguintes opções:';

  @override
  String errorMessage(String error) {
    return 'Erro: $error';
  }

  @override
  String get continueLabel => 'Continuar';

  @override
  String get country => 'País';

  @override
  String get selectCountry => 'Selecione o seu país';

  @override
  String get countryInfo =>
      'Utilizaremos esta informação para obter a lista de feriados nacionais e escolares.';

  @override
  String get holidays => 'Feriados';

  @override
  String get cancel => 'Cancelar';

  @override
  String get dateRange => 'Intervalo de datas';

  @override
  String get initialDate => 'Data inicial';

  @override
  String get countryNotSelected => 'País não selecionado';

  @override
  String get changeCountry => 'Alterar país';

  @override
  String get loadingCountry => 'Carregando país...';

  @override
  String errorLoadingCountries(String error) {
    return 'Erro ao carregar países: $error';
  }

  @override
  String errorLoadingCountry(String error) {
    return 'Erro ao carregar país: $error';
  }

  @override
  String get holidaysApiError => 'Erro ao tentar obter os dados de Feriados';

  @override
  String validFrom(int year) => 'Adicione datas entre 2020 e ${year}.';

  @override
  String get dateIntervalInfo =>
      'O intervalo entre as datas não pode ser superior a 3 anos.';

  @override
  String totalHolidaysInfo(int total) =>
      'Exibindo $total feriados nacionais e escolares';

  @override
  String get checkHolidaysButton => 'Ver feriados no Período';

  @override
  String get outOfRangeError => 'Datas fora do intervalo';

  @override
  String get invalidDateRangeError => 'As datas informadas não podem:';

  @override
  String get cannotBeBefore2020 => '- Serem anteriores a 01/01/2020;';

  @override
  String cannotBeAfterNow(String maxDate) => '- Serem maiores que $maxDate;';

  @override
  String cannotBeInterval(String days) =>
      '- Ter um intervalo maior que $days dias.';

  @override
  String intervalInfo(String from, String to) =>
      'Serão mostrados os feriados entre $from e $to.';

  @override
  String get continueQuestion => 'Deseja continuar?';

  @override
  String get confirmLabel => 'Confirmar';

  @override
  String get holidayTypeSchool => 'Feriado Escolar';

  @override
  String get holidayTypeNormal => 'Feriado';

  @override
  String translateHolidayFragment(String fragment) {
    switch (fragment) {
      case 'Public':
        return 'Público';
      case 'National':
        return 'Nacional';
      case 'FullDay':
        return 'Todo o Dia';
      case 'HalfDay':
        return 'Meio Dia';
      case 'Optional':
        return 'Opcional';
      case 'School':
        return 'Escola';
      default:
        return fragment;
    }
  }

  @override
  String get school => 'Escola';

  @override
  String get shareMessageSuccess => 'Compartilhado com sucesso';
}
