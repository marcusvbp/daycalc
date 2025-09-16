import 'package:daycalc/app/enums/operation_type.dart';

class DateCalculator {
  final DateTime date;
  final Duration interval;
  final OperationType operationType;
  final String languageCode;

  DateCalculator({
    required this.date,
    required this.interval,
    required this.operationType,
    required this.languageCode,
  });

  DateTime get calculatedDate {
    switch (operationType) {
      case OperationType.add:
        return date.add(interval);
      case OperationType.subtract:
        return date.subtract(interval);
    }
  }

  String get formattedDate {
    final calculatedDateTime = calculatedDate;
    final weekDay = weekDayName;
    final day = calculatedDateTime.day;
    final month = monthName;
    final year = calculatedDateTime.year;

    switch (languageCode) {
      case 'pt':
      case 'pt_BR':
        return '$weekDay, $day de $month de $year';
      case 'en':
      case 'en_US':
        return '$weekDay, $month $day, $year';
      case 'es':
      case 'es_ES':
        return '$weekDay, $day de $month de $year';
      default:
        return '$weekDay, $month $day, $year';
    }
  }

  String get weekDayName {
    final calculatedDateTime = calculatedDate;

    switch (languageCode) {
      case 'pt':
      case 'pt_BR':
        return _getPortugueseWeekDay(calculatedDateTime.weekday);
      case 'en':
      case 'en_US':
        return _getEnglishWeekDay(calculatedDateTime.weekday);
      case 'es':
      case 'es_ES':
        return _getSpanishWeekDay(calculatedDateTime.weekday);
      default:
        return _getEnglishWeekDay(calculatedDateTime.weekday);
    }
  }

  String get monthName {
    final calculatedDateTime = calculatedDate;

    switch (languageCode) {
      case 'pt':
      case 'pt_BR':
        return _getPortugueseMonth(calculatedDateTime.month);
      case 'en':
      case 'en_US':
        return _getEnglishMonth(calculatedDateTime.month);
      case 'es':
      case 'es_ES':
        return _getSpanishMonth(calculatedDateTime.month);
      default:
        return _getEnglishMonth(calculatedDateTime.month);
    }
  }

  String _getPortugueseMonth(int month) {
    switch (month) {
      case 1:
        return 'janeiro';
      case 2:
        return 'fevereiro';
      case 3:
        return 'março';
      case 4:
        return 'abril';
      case 5:
        return 'maio';
      case 6:
        return 'junho';
      case 7:
        return 'julho';
      case 8:
        return 'agosto';
      case 9:
        return 'setembro';
      case 10:
        return 'outubro';
      case 11:
        return 'novembro';
      case 12:
        return 'dezembro';
      default:
        return 'desconhecido';
    }
  }

  String _getEnglishMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Unknown';
    }
  }

  String _getSpanishMonth(int month) {
    switch (month) {
      case 1:
        return 'enero';
      case 2:
        return 'febrero';
      case 3:
        return 'marzo';
      case 4:
        return 'abril';
      case 5:
        return 'mayo';
      case 6:
        return 'junio';
      case 7:
        return 'julio';
      case 8:
        return 'agosto';
      case 9:
        return 'septiembre';
      case 10:
        return 'octubre';
      case 11:
        return 'noviembre';
      case 12:
        return 'diciembre';
      default:
        return 'desconocido';
    }
  }

  String _getPortugueseWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return 'Segunda-feira';
      case 2:
        return 'Terça-feira';
      case 3:
        return 'Quarta-feira';
      case 4:
        return 'Quinta-feira';
      case 5:
        return 'Sexta-feira';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'Desconhecido';
    }
  }

  String _getEnglishWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }

  String _getSpanishWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'Desconocido';
    }
  }
}
