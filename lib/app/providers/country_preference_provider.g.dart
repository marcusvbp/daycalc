// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_preference_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CountryPreferenceNotifier)
const countryPreferenceProvider = CountryPreferenceNotifierProvider._();

final class CountryPreferenceNotifierProvider
    extends $AsyncNotifierProvider<CountryPreferenceNotifier, Country?> {
  const CountryPreferenceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryPreferenceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryPreferenceNotifierHash();

  @$internal
  @override
  CountryPreferenceNotifier create() => CountryPreferenceNotifier();
}

String _$countryPreferenceNotifierHash() =>
    r'89e953367ee1dd7273214d87e7b956f9ab924287';

abstract class _$CountryPreferenceNotifier extends $AsyncNotifier<Country?> {
  FutureOr<Country?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Country?>, Country?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Country?>, Country?>,
              AsyncValue<Country?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
