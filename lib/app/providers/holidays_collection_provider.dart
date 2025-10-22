import 'package:daycalc/app/config/constants.dart';
import 'package:daycalc/app/models/holidays_collection.dart';
import 'package:daycalc/app/modules/open_holidays/services/public_holidays.dart';
import 'package:daycalc/app/modules/open_holidays/services/school_holidays.dart';
import 'package:daycalc/app/providers/country_preference_provider.dart';
import 'package:daycalc/app/providers/holidays_params_provider.dart';
import 'package:daycalc/app/providers/locale_provider.dart';
import 'package:daycalc/app/services/holidays_collection_storage_service.dart';
import 'package:daycalc/app/utils/format_date_to_api_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'holidays_collection_provider.g.dart';

@riverpod
class HolidaysCollectionNotifier extends _$HolidaysCollectionNotifier {
  late final HolidaysCollectionStorageService _storage =
      HolidaysCollectionStorageService();

  Future<HolidaysCollection?> _fetch({bool forceRefresh = false}) async {
    final currentLocale = await ref.read(localeProvider.future);
    final country = await ref.read(countryPreferenceProvider.future);
    final holidaysParams = ref.read(holidaysParamsProvider);
    final stored = await _storage.load();

    bool needRefresh = forceRefresh;

    if (stored == null ||
        country == null ||
        stored.country.isoCode != country.isoCode) {
      needRefresh = true;
    } else {
      final nowYear = DateTime.now().year;
      final createdAt = DateTime.fromMillisecondsSinceEpoch(stored.createdAt);
      if (createdAt.year < nowYear) {
        needRefresh = true;
      }
      final storedLang = stored.locale.languageCode.toLowerCase();
      final currentLang = currentLocale.languageCode.toLowerCase();
      if (storedLang != currentLang) {
        needRefresh = true;
      }
    }

    if (!needRefresh) {
      return stored;
    }

    final finalDate = DateTime(DateTime.now().year, 12, 31);
    final initialDate = finalDate.subtract(
      Duration(days: openHolidaysMaxInterval),
    );

    final validFrom = holidaysParams.validFrom ?? initialDate;
    final validTo = holidaysParams.validTo ?? finalDate;
    final countryIsoCode = country?.isoCode;

    final languageIsoCode = currentLocale.languageCode.toUpperCase();
    final query = {
      'validFrom': formatDateToApiParam(validFrom),
      'validTo': formatDateToApiParam(validTo),
      'countryIsoCode': countryIsoCode,
      'languageIsoCode': languageIsoCode,
    };

    final publicService = PublicHolidaysService(ref: ref);
    final schoolService = SchoolHolidaysService(ref: ref);

    final public = await publicService.listPublicHolidays(query);
    final school = await schoolService.listSchoolHolidays(query);

    final updated = HolidaysCollection(
      publicHolidays: public,
      schoolHolidays: school,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      locale: currentLocale,
      country: country!,
    );

    await _storage.save(updated);

    return updated;
  }

  @override
  Future<HolidaysCollection?> build() async {
    return null;
  }

  Future<void> refresh() async {
    state = AsyncLoading();
    state = AsyncData(await _fetch(forceRefresh: true));
  }
}
