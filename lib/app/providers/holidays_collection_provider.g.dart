// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holidays_collection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HolidaysCollectionNotifier)
const holidaysCollectionProvider = HolidaysCollectionNotifierProvider._();

final class HolidaysCollectionNotifierProvider
    extends
        $AsyncNotifierProvider<
          HolidaysCollectionNotifier,
          HolidaysCollection?
        > {
  const HolidaysCollectionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'holidaysCollectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$holidaysCollectionNotifierHash();

  @$internal
  @override
  HolidaysCollectionNotifier create() => HolidaysCollectionNotifier();
}

String _$holidaysCollectionNotifierHash() =>
    r'c66b67000d6bb6b0a7bb6069ca09eec61ab4153e';

abstract class _$HolidaysCollectionNotifier
    extends $AsyncNotifier<HolidaysCollection?> {
  FutureOr<HolidaysCollection?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<HolidaysCollection?>, HolidaysCollection?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HolidaysCollection?>, HolidaysCollection?>,
              AsyncValue<HolidaysCollection?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
