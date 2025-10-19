// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holidays_params_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HolidaysParamsNotifier)
const holidaysParamsProvider = HolidaysParamsNotifierProvider._();

final class HolidaysParamsNotifierProvider
    extends $NotifierProvider<HolidaysParamsNotifier, HolidaysParamsState> {
  const HolidaysParamsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'holidaysParamsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$holidaysParamsNotifierHash();

  @$internal
  @override
  HolidaysParamsNotifier create() => HolidaysParamsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HolidaysParamsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HolidaysParamsState>(value),
    );
  }
}

String _$holidaysParamsNotifierHash() =>
    r'235fa2c8c0b47cf791a9fdff908d1a67de81798d';

abstract class _$HolidaysParamsNotifier extends $Notifier<HolidaysParamsState> {
  HolidaysParamsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HolidaysParamsState, HolidaysParamsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HolidaysParamsState, HolidaysParamsState>,
              HolidaysParamsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
