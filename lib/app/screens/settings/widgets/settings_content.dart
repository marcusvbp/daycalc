import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/app_settings_provider.dart';
import 'package:daycalc/app/providers/countries_collection_provider.dart';
import 'package:daycalc/app/providers/country_preference_provider.dart';
import 'package:daycalc/app/providers/locale_provider.dart';
import 'package:daycalc/app/providers/theme_provider.dart';
import 'package:daycalc/app/services/locale_preference_service.dart';
import 'package:daycalc/app/widgets/country_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsContent extends ConsumerWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final themeModeAsync = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(localeProvider);
    final countryAsync = ref.watch(countryPreferenceProvider);
    final countriesAsync = ref.watch(countriesCollectionProvider);
    final appSettingsAsync = ref.watch(appSettingsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Idioma
        Text(
          localizations.language,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.selectLanguage,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                localeAsync.when(
                  data: (locale) => RadioGroup<AppLocale>(
                    groupValue: _getAppLocaleFromLocale(locale),
                    onChanged: (v) {
                      if (v != null) {
                        _handleLocaleChange(ref, v);
                      }
                    },
                    child: Column(
                      children: [
                        RadioListTile<AppLocale>(
                          title: Text(localizations.english),
                          value: AppLocale.en,
                        ),
                        RadioListTile<AppLocale>(
                          title: Text(localizations.spanish),
                          value: AppLocale.es,
                        ),
                        RadioListTile<AppLocale>(
                          title: Text(localizations.portuguese),
                          value: AppLocale.pt,
                        ),
                        RadioListTile<AppLocale>(
                          title: Text(localizations.hindi),
                          value: AppLocale.hi,
                        ),
                      ],
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) =>
                      Text(localizations.errorMessage(error.toString())),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // País
        Text(
          localizations.country,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.selectCountry,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                countriesAsync.when(
                  data: (data) => SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 6,
                      children: [
                        CountrySelect(
                          countries: data.countries,
                          onChange: (v) {
                            if (v != null) {
                              ref
                                  .read(countryPreferenceProvider.notifier)
                                  .setCountry(v);
                            }
                          },
                          defaultValue: countryAsync.value,
                        ),
                        appSettingsAsync.when(
                          data: (settings) => settings.showSettingsFirst
                              ? Text(
                                  localizations.countryInfo,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : SizedBox.shrink(),
                          loading: () => const SizedBox.shrink(),
                          error: (error, _) => Text(
                            localizations.errorMessage(error.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  error: (error, _) =>
                      Text(localizations.errorMessage(error.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          localizations.appearance,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        // Tema
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.theme,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                themeModeAsync.when(
                  data: (themeMode) => RadioGroup<AppThemeMode>(
                    groupValue: themeMode,
                    onChanged: (v) {
                      if (v != null) {
                        _handleThemeChange(ref, v);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile<AppThemeMode>(
                          title: Text(localizations.lightTheme),
                          value: AppThemeMode.light,
                        ),
                        RadioListTile<AppThemeMode>(
                          title: Text(localizations.darkTheme),
                          value: AppThemeMode.dark,
                        ),
                        RadioListTile<AppThemeMode>(
                          title: Text(localizations.systemTheme),
                          value: AppThemeMode.system,
                        ),
                      ],
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) =>
                      Text(localizations.errorMessage(error.toString())),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleThemeChange(WidgetRef ref, AppThemeMode value) {
    ref.read(themeModeProvider.notifier).setThemeMode(value);
  }

  void _handleLocaleChange(WidgetRef ref, AppLocale value) {
    ref.read(localeProvider.notifier).setLocale(value);
  }

  AppLocale _getAppLocaleFromLocale(Locale locale) {
    if (locale.languageCode == 'en') {
      return AppLocale.en;
    } else if (locale.languageCode == 'es') {
      return AppLocale.es;
    } else if (locale.languageCode == 'hi') {
      return AppLocale.hi;
    } else {
      return AppLocale.pt;
    }
  }
}
