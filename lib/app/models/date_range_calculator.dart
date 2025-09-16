class DateRangeCalculator {
  /// Calcula dias úteis e finais de semana entre duas datas
  static Map<String, int> calculateDays(DateTime startDate, DateTime endDate) {
    // Garante que a data inicial seja menor ou igual à final
    if (startDate.isAfter(endDate)) {
      throw ArgumentError(
        'Data inicial deve ser anterior ou igual à data final',
      );
    }

    int businessDays = 0;
    int weekendDays = 0;

    // Itera através de cada dia no intervalo
    DateTime currentDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    DateTime finalDate = DateTime(endDate.year, endDate.month, endDate.day);

    while (currentDate.isBefore(finalDate) ||
        currentDate.isAtSameMomentAs(finalDate)) {
      // weekday retorna: 1=Segunda, 2=Terça, ..., 6=Sábado, 7=Domingo
      if (currentDate.weekday >= 1 && currentDate.weekday <= 5) {
        businessDays++;
      } else {
        weekendDays++;
      }

      // Avança para o próximo dia
      currentDate = currentDate.add(Duration(days: 1));
    }

    return {
      'diasUteis': businessDays,
      'finsDeSemanae': weekendDays,
      'totalDias': businessDays + weekendDays,
    };
  }

  /// Versão mais eficiente para intervalos grandes
  static Map<String, int> calculateDaysOptimized(
    DateTime startDate,
    DateTime endDate,
  ) {
    if (startDate.isAfter(endDate)) {
      throw ArgumentError(
        'Data inicial deve ser anterior ou igual à data final',
      );
    }

    // Normaliza as datas (remove horas/minutos)
    DateTime start = DateTime(startDate.year, startDate.month, startDate.day);
    DateTime end = DateTime(endDate.year, endDate.month, endDate.day);

    // Calcula total de dias
    int totalDays = end.difference(start).inDays + 1;

    // Calcula semanas completas
    int completeWeeks = totalDays ~/ 7;
    int remainingDays = totalDays % 7;

    // Cada semana completa tem 5 dias úteis e 2 fins de semana
    int businessDays = completeWeeks * 5;
    int weekendDays = completeWeeks * 2;

    // Verifica os dias restantes
    DateTime currentDate = start.add(Duration(days: completeWeeks * 7));
    for (int i = 0; i < remainingDays; i++) {
      if (currentDate.weekday >= 1 && currentDate.weekday <= 5) {
        businessDays++;
      } else {
        weekendDays++;
      }
      currentDate = currentDate.add(Duration(days: 1));
    }

    return {
      'diasUteis': businessDays,
      'finsDeSemanae': weekendDays,
      'totalDias': totalDays,
    };
  }

  /// Adiciona ou subtrai dias úteis de uma data
  static DateTime addBusinessDays(DateTime date, int businessDaysToAdd) {
    DateTime result = DateTime(date.year, date.month, date.day);
    int direction = businessDaysToAdd.isNegative ? -1 : 1;
    int remainingDays = businessDaysToAdd.abs();

    while (remainingDays > 0) {
      result = result.add(Duration(days: direction));

      // Se for dia útil, conta
      if (result.weekday >= 1 && result.weekday <= 5) {
        remainingDays--;
      }
    }

    return result;
  }

  /// Verifica se uma data é dia útil
  static bool isBusinessDay(DateTime date) {
    return date.weekday >= 1 && date.weekday <= 5;
  }

  /// Verifica se uma data é final de semana
  static bool isWeekend(DateTime date) {
    return date.weekday == 6 || date.weekday == 7; // Sábado ou Domingo
  }

  /// Retorna o próximo dia útil
  static DateTime nextBusinessDay(DateTime date) {
    DateTime nextDay = date.add(Duration(days: 1));
    while (!isBusinessDay(nextDay)) {
      nextDay = nextDay.add(Duration(days: 1));
    }
    return nextDay;
  }

  /// Retorna o dia útil anterior
  static DateTime previousBusinessDay(DateTime date) {
    DateTime prevDay = date.subtract(Duration(days: 1));
    while (!isBusinessDay(prevDay)) {
      prevDay = prevDay.subtract(Duration(days: 1));
    }
    return prevDay;
  }
}

// Função para formatar data em português
String formatDate(DateTime date) {
  const meses = [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];

  return '${date.day} de ${meses[date.month - 1]} de ${date.year}';
}
