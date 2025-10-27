import 'package:daycalc/app/modules/open_holidays/models/country.dart';
import 'package:daycalc/app/services/country_preference_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_preference_provider.g.dart';

@Riverpod(keepAlive: true)
class CountryPreferenceNotifier extends _$CountryPreferenceNotifier {
  late final CountryPreferenceStorageService _storage;

  @override
  Future<Country?> build() async {
    _storage = CountryPreferenceStorageService();
    return await _storage.getCountry();
  }

  Future<void> setCountry(Country country) async {
    await _storage.setCountry(country);
    state = AsyncData(country);
  }

  Future<void> clearCountry() async {
    await _storage.clearCountry();
    state = AsyncData(null);
  }
}