// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_date_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserDateNotifier)
const userDateProvider = UserDateNotifierProvider._();

final class UserDateNotifierProvider
    extends $NotifierProvider<UserDateNotifier, DateTime?> {
  const UserDateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDateNotifierHash();

  @$internal
  @override
  UserDateNotifier create() => UserDateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$userDateNotifierHash() => r'f5c7e835eda1554ed4c09c4f808eae5daa9bf53d';

abstract class _$UserDateNotifier extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
