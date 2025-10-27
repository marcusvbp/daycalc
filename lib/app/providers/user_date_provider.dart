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
}
