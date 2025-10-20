import 'package:daycalc/app/extensions/country_extension.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/countries_collection_provider.dart';
import 'package:daycalc/app/providers/country_preference_provider.dart';
import 'package:daycalc/app/providers/holidays_params_provider.dart';
import 'package:daycalc/app/utils/format_localized_date.dart';
import 'package:daycalc/app/widgets/country_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidaysParameters extends ConsumerWidget {
  const HolidaysParameters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryAsync = ref.watch(countryPreferenceProvider);
    final holidaysParams = ref.watch(holidaysParamsProvider);
    final localizations = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: [
            Text(
              localizations.dateRange,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    getLocalizedDate(
                      holidaysParams.validFrom,
                      localizations.localeName,
                      localizations.initialDate,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      ref
                          .read(holidaysParamsProvider.notifier)
                          .setValidFrom(date);
                    }
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    getLocalizedDate(
                      holidaysParams.validTo,
                      localizations.localeName,
                      localizations.finalDate,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      ref
                          .read(holidaysParamsProvider.notifier)
                          .setValidTo(date);
                    }
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            countryAsync.when(
              data: (country) => Row(
                children: [
                  Expanded(
                    child: Text(
                      country?.displayName(context) ?? localizations.countryNotSelected,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final localizations = AppLocalizations.of(context)!;
                          return AlertDialog(
                            title: Text(localizations.selectCountry),
                            content: Consumer(
                              builder: (context, ref, _) {
                                final countriesAsync = ref.watch(
                                  countriesCollectionProvider,
                                );
                                final selectedCountryAsync = ref.watch(
                                  countryPreferenceProvider,
                                );
                                return countriesAsync.when(
                                  data: (data) => CountrySelect(
                                    countries: data.countries,
                                    defaultValue: selectedCountryAsync.value,
                                    onChange: (v) {
                                      if (v != null) {
                                        ref
                                            .read(
                                              countryPreferenceProvider
                                                  .notifier,
                                            )
                                            .setCountry(v);
                                      }
                                    },
                                  ),
                                  loading: () => const SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  error: (error, _) => Text(
                                    localizations.errorLoadingCountries(
                                      error.toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(localizations.close),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      country != null
                          ? localizations.changeCountry
                          : localizations.selectCountry,
                    ),
                  ),
                ],
              ),
              error: (error, _) => Text(
                localizations.errorLoadingCountry(error.toString()),
              ),
              loading: () => Text(localizations.loadingCountry),
            ),
          ],
        ),
      ),
    );
  }
}
