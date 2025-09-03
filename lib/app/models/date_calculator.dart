enum OperationType { addition, subtraction }

class DateCalculator {
  final DateTime date;
  final int hours;
  final OperationType operationType;

  DateCalculator({
    required this.date,
    required this.hours,
    required this.operationType,
  });

  DateTime get calculatedDate {
    final duration = Duration(hours: hours);

    switch (operationType) {
      case OperationType.addition:
        return date.add(duration);
      case OperationType.subtraction:
        return date.subtract(duration);
    }
  }

  String getFormattedDate(String languageCode) {
    final calculatedDateTime = calculatedDate;
    final weekDay = getWeekDayName(languageCode);
    final day = calculatedDateTime.day;
    final month = _getMonthName(languageCode, calculatedDateTime.month);
    final year = calculatedDateTime.year;

    switch (languageCode.toLowerCase()) {
      case 'pt':
      case 'pt-br':
        return '$weekDay, $day de $month de $year';
      case 'en':
      case 'en-us':
        return '$weekDay, $month $day, $year';
      case 'es':
      case 'es-es':
        return '$weekDay, $day de $month de $year';
      default:
        return '$weekDay, $month $day, $year';
    }
  }

  String getWeekDayName(String languageCode) {
    final calculatedDateTime = calculatedDate;

    switch (languageCode.toLowerCase()) {
      case 'pt':
      case 'pt-br':
        return _getPortugueseWeekDay(calculatedDateTime.weekday);
      case 'en':
      case 'en-us':
        return _getEnglishWeekDay(calculatedDateTime.weekday);
      case 'es':
      case 'es-es':
        return _getSpanishWeekDay(calculatedDateTime.weekday);
      default:
        return _getEnglishWeekDay(calculatedDateTime.weekday);
    }
  }

  String _getMonthName(String languageCode, int month) {
    switch (languageCode.toLowerCase()) {
      case 'pt':
      case 'pt-br':
        return _getPortugueseMonth(month);
      case 'en':
      case 'en-us':
        return _getEnglishMonth(month);
      case 'es':
      case 'es-es':
        return _getSpanishMonth(month);
      default:
        return _getEnglishMonth(month);
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
