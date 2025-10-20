// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holidays_fetch_profider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HolidaysFetchNotifier)
const holidaysFetchProvider = HolidaysFetchNotifierProvider._();

final class HolidaysFetchNotifierProvider
    extends
        $AsyncNotifierProvider<HolidaysFetchNotifier, List<PublicHoliday>?> {
  const HolidaysFetchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'holidaysFetchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$holidaysFetchNotifierHash();

  @$internal
  @override
  HolidaysFetchNotifier create() => HolidaysFetchNotifier();
}

String _$holidaysFetchNotifierHash() =>
    r'bea156ad4b4e9543e0755e91c68a97b5242f1881';

abstract class _$HolidaysFetchNotifier
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
