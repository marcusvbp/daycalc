// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_operations_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DateOperationsHistoryNotifier)
const dateOperationsHistoryProvider = DateOperationsHistoryNotifierProvider._();

final class DateOperationsHistoryNotifierProvider
    extends
        $AsyncNotifierProvider<
          DateOperationsHistoryNotifier,
          List<DateOperationRecord>
        > {
  const DateOperationsHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dateOperationsHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dateOperationsHistoryNotifierHash();

  @$internal
  @override
  DateOperationsHistoryNotifier create() => DateOperationsHistoryNotifier();
}

String _$dateOperationsHistoryNotifierHash() =>
    r'8105beb97c385240062432c6b1e32721c50e6c33';

abstract class _$DateOperationsHistoryNotifier
    extends $AsyncNotifier<List<DateOperationRecord>> {
  FutureOr<List<DateOperationRecord>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DateOperationRecord>>,
              List<DateOperationRecord>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DateOperationRecord>>,
                List<DateOperationRecord>
              >,
              AsyncValue<List<DateOperationRecord>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
