import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'holidays_params_provider.g.dart';

@Riverpod(keepAlive: true)
class HolidaysParamsNotifier extends _$HolidaysParamsNotifier {
  @override
  HolidaysParamsState build() {
    return const HolidaysParamsState();
  }

  void setValidFrom(DateTime? from) {
    state = state.copyWith(validFrom: from);
  }

  void setValidTo(DateTime? to) {
    state = state.copyWith(validTo: to);
  }

  void setRange({DateTime? from, DateTime? to}) {
    state = state.copyWith(validFrom: from, validTo: to);
  }

  void clear() {
    state = const HolidaysParamsState();
  }
}

class HolidaysParamsState {
  final DateTime? validFrom;
  final DateTime? validTo;

  const HolidaysParamsState({this.validFrom, this.validTo});

  HolidaysParamsState copyWith({DateTime? validFrom, DateTime? validTo}) {
    return HolidaysParamsState(
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HolidaysParamsState &&
        other.validFrom == validFrom &&
        other.validTo == validTo;
  }

  @override
  int get hashCode => validFrom.hashCode ^ validTo.hashCode;
}