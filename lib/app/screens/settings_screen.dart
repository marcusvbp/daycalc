import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/locale_provider.dart';
import 'package:daycalc/app/providers/theme_provider.dart';
import 'package:daycalc/app/services/locale_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final themeModeAsync = ref.watch(themeModeNotifierProvider);
    final localeAsync = ref.watch(localeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      error: (error, _) => Text('Erro: $error'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
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
                              title: const Text('English'),
                              value: AppLocale.en,
                            ),
                            RadioListTile<AppLocale>(
                              title: const Text('Español'),
                              value: AppLocale.es,
                            ),
                            RadioListTile<AppLocale>(
                              title: const Text('Português'),
                              value: AppLocale.pt,
                            ),
                          ],
                        ),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, _) => Text('Erro: $error'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleThemeChange(WidgetRef ref, AppThemeMode value) {
    ref.read(themeModeNotifierProvider.notifier).setThemeMode(value);
  }

  void _handleLocaleChange(WidgetRef ref, AppLocale value) {
    ref.read(localeNotifierProvider.notifier).setLocale(value);
  }

  AppLocale _getAppLocaleFromLocale(Locale locale) {
    if (locale.languageCode == 'en') {
      return AppLocale.en;
    } else if (locale.languageCode == 'es') {
      return AppLocale.es;
    } else {
      return AppLocale.pt;
    }
  }
}
