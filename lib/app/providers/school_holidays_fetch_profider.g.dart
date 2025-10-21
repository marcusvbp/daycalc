// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_holidays_fetch_profider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SchoolHolidaysFetchNotifier)
const schoolHolidaysFetchProvider = SchoolHolidaysFetchNotifierProvider._();

final class SchoolHolidaysFetchNotifierProvider
    extends
        $AsyncNotifierProvider<
          SchoolHolidaysFetchNotifier,
          List<PublicHoliday>?
        > {
  const SchoolHolidaysFetchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schoolHolidaysFetchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schoolHolidaysFetchNotifierHash();

  @$internal
  @override
  SchoolHolidaysFetchNotifier create() => SchoolHolidaysFetchNotifier();
}

String _$schoolHolidaysFetchNotifierHash() =>
    r'b66b8fe0a1b9297c870510cba03709308f73d231';

abstract class _$SchoolHolidaysFetchNotifier
    extends $AsyncNotifier<List<PublicHoliday>?> {
  FutureOr<List<PublicHoliday>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<PublicHoliday>?>, List<PublicHoliday>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PublicHoliday>?>,
                List<PublicHoliday>?
              >,
              AsyncValue<List<PublicHoliday>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
