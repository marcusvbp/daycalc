// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_collection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CountriesCollectionNotifier)
const countriesCollectionProvider = CountriesCollectionNotifierProvider._();

final class CountriesCollectionNotifierProvider
    extends
        $AsyncNotifierProvider<
          CountriesCollectionNotifier,
          CountriesCollection
        > {
  const CountriesCollectionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countriesCollectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countriesCollectionNotifierHash();

  @$internal
  @override
  CountriesCollectionNotifier create() => CountriesCollectionNotifier();
}

String _$countriesCollectionNotifierHash() =>
    r'44d23cc8bc9a30892e3472234c62861e3471e296';

abstract class _$CountriesCollectionNotifier
    extends $AsyncNotifier<CountriesCollection> {
  FutureOr<CountriesCollection> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<CountriesCollection>, CountriesCollection>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CountriesCollection>, CountriesCollection>,
              AsyncValue<CountriesCollection>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
