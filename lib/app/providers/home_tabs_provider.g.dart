// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tabs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeTabsNotifier)
const homeTabsProvider = HomeTabsNotifierProvider._();

final class HomeTabsNotifierProvider
    extends $NotifierProvider<HomeTabsNotifier, int> {
  const HomeTabsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTabsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeTabsNotifierHash();

  @$internal
  @override
  HomeTabsNotifier create() => HomeTabsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$homeTabsNotifierHash() => r'b0382e1aae5d31f3380a82c4bd94d843cb42d226';

abstract class _$HomeTabsNotifier extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
