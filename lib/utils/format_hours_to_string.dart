String hoursToString(Map<String, int> units, String languageCode) {
  final List<String> parts = [];
  final Map<String, String> anoT = {
    'pt_BR': 'ano',
    'en_US': 'year',
    'es_ES': 'año',
  };
  final Map<String, String> anosT = {
    'pt_BR': 'anos',
    'en_US': 'years',
    'es_ES': 'años',
  };
  final Map<String, String> mesT = {
    'pt_BR': 'mês',
    'en_US': 'month',
    'es_ES': 'mes',
  };
  final Map<String, String> mesesT = {
    'pt_BR': 'meses',
    'en_US': 'months',
    'es_ES': 'meses',
  };
  final Map<String, String> semanaT = {
    'pt_BR': 'semana',
    'en_US': 'week',
    'es_ES': 'semana',
  };
  final Map<String, String> semanasT = {
    'pt_BR': 'semanas',
    'en_US': 'weeks',
    'es_ES': 'semanas',
  };
  final Map<String, String> diaT = {
    'pt_BR': 'dia',
    'en_US': 'day',
    'es_ES': 'dia',
  };
  final Map<String, String> diasT = {
    'pt_BR': 'dias',
    'en_US': 'days',
    'es_ES': 'dias',
  };
  final Map<String, String> horaT = {
    'pt_BR': 'hora',
    'en_US': 'hour',
    'es_ES': 'hora',
  };
  final Map<String, String> horasT = {
    'pt_BR': 'horas',
    'en_US': 'hours',
    'es_ES': 'horas',
  };

  if (units['years']! > 0) {
    parts.add(
      '${units['years']} ${units['years'] == 1 ? anoT[languageCode] : anosT[languageCode]}',
    );
  }
  if (units['months']! > 0) {
    parts.add(
      '${units['months']} ${units['months'] == 1 ? mesT[languageCode] : mesesT[languageCode]}',
    );
  }
  if (units['weeks']! > 0) {
    parts.add(
      '${units['weeks']} ${units['weeks'] == 1 ? semanaT[languageCode] : semanasT[languageCode]}',
    );
  }
  if (units['days']! > 0) {
    parts.add(
      '${units['days']} ${units['days'] == 1 ? diaT[languageCode] : diasT[languageCode]}',
    );
  }
  if (units['hours']! > 0) {
    parts.add(
      '${units['hours']} ${units['hours'] == 1 ? horaT[languageCode] : horasT[languageCode]}',
    );
  }

  if (parts.isEmpty) {
    return '0 horas';
  }

  return parts.join(', ');
}
