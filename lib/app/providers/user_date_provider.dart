import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_date_provider.g.dart';

@Riverpod(keepAlive: true)
class UserDateNotifier extends _$UserDateNotifier {
  @override
  DateTime? build() {
    return null;
  }

  /// Adiciona uma nova data
  void add(DateTime date) {
    state = date;
  }

  /// Limpa a data atual
  void clear() {
    state = null;
  }

  /// Retorna a data formatada no formato dd/mm/yyyy
  /// [locale] - idioma da interface (ex: 'pt_BR', 'en_US', 'es_ES')
  String getFormattedDate(String locale) {
    if (state == null) {
      return '';
    }

    final formatter = DateFormat('dd/MM/yyyy', locale);
    return formatter.format(state!);
  }
}
