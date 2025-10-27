// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_operations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DateOperationsNotifier)
const dateOperationsProvider = DateOperationsNotifierProvider._();

final class DateOperationsNotifierProvider
    extends $NotifierProvider<DateOperationsNotifier, DateOperationsState> {
  const DateOperationsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dateOperationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dateOperationsNotifierHash();

  @$internal
  @override
  DateOperationsNotifier create() => DateOperationsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateOperationsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateOperationsState>(value),
    );
  }
}

String _$dateOperationsNotifierHash() =>
    r'112795cee19290632da2eae1231b7f8301a187c2';

abstract class _$DateOperationsNotifier extends $Notifier<DateOperationsState> {
  DateOperationsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateOperationsState, DateOperationsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateOperationsState, DateOperationsState>,
              DateOperationsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
