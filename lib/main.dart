import 'package:daycalc/app/config/app_colors.dart';
import 'package:daycalc/app/config/routes.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/locale_provider.dart';
import 'package:daycalc/app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Garante que os widgets sejam inicializados
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  // Inicializa o SharedPreferences
  await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(localeProvider);

    return themeModeAsync.when(
      data: (themeMode) {
        return localeAsync.when(
          data: (locale) {
            return MaterialApp.router(
              title: 'DayCalc',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: AppColors.lightColorScheme,
                textTheme: AppColors.lightTextTheme,
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                  backgroundColor: AppColors.lightSurface,
                  foregroundColor: AppColors.lightPrimaryText,
                  elevation: 0,
                ),
                cardTheme: const CardThemeData(elevation: 2),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: AppColors.lightSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.lightSecondaryText.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.lightSecondaryText.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.lightAccent,
                      width: 2,
                    ),
                  ),
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: AppColors.darkColorScheme,
                textTheme: AppColors.darkTextTheme,
                useMaterial3: true,
                // appBarTheme: AppBarTheme(
                //   backgroundColor: AppColors.darkSurface,
                //   foregroundColor: AppColors.darkPrimaryText,
                //   elevation: 0,
                //   centerTitle: true,
                // ),
                cardTheme: const CardThemeData(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: AppColors.darkSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.darkSecondaryText.withValues(alpha: 0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.darkSecondaryText.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.darkAccent,
                      width: 2,
                    ),
                  ),
                ),
              ),
              themeMode: _getThemeMode(themeMode),
              routerConfig: router,
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
          loading: () => const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          ),
          error: (error, stackTrace) => MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Erro ao carregar idioma: $error')),
            ),
          ),
        );
      },
      loading: () => MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (error, stackTrace) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Erro ao carregar tema: $error')),
        ),
      ),
    );
  }

  ThemeMode _getThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

// Removido MyHomePage pois estamos usando HomeScreen como tela inicial
