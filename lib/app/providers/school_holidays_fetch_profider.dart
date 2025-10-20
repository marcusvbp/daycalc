import 'package:daycalc/app/modules/open_holidays/models/public_holiday.dart';
import 'package:daycalc/app/modules/open_holidays/services/school_holidays.dart';
import 'package:daycalc/app/providers/country_preference_provider.dart';
import 'package:daycalc/app/providers/holidays_params_provider.dart';
import 'package:daycalc/app/providers/locale_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_holidays_fetch_profider.g.dart';

@riverpod
class SchoolHolidaysFetchNotifier extends _$SchoolHolidaysFetchNotifier {
  @override
  Future<List<PublicHoliday>?> build() async {
    final params = ref.watch(holidaysParamsProvider);
    final country = await ref.watch(countryPreferenceProvider.future);
    final locale = await ref.watch(localeProvider.future);

    final validFrom = params.validFrom;
    final validTo = params.validTo;
    final countryIsoCode = country?.isoCode;

    if (validFrom == null || validTo == null || countryIsoCode == null) {
      return null;
    }

    final languageIsoCode = locale.languageCode;

    final service = SchoolHolidaysService(ref: ref);

    final query = {
      'validFrom': _formatDate(validFrom),
      'validTo': _formatDate(validTo),
      'countryIsoCode': countryIsoCode,
      'languageIsoCode': languageIsoCode.toUpperCase(),
    };

    return await service.listSchoolHolidays(query);
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
