import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tabs_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeTabsNotifier extends _$HomeTabsNotifier {
  @override
  int build() => 0;

  void set(int value) => state = value;
}
