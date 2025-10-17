import 'package:daycalc/app/config/routes.dart';
import 'package:daycalc/app/config/theme.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/locale_provider.dart';
import 'package:daycalc/app/providers/theme_provider.dart';
import 'package:daycalc/app/services/app_settings_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Garante que os widgets sejam inicializados
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await MobileAds.instance.initialize();
  } catch (_) {}

  // Inicializa o SharedPreferences
  await SharedPreferences.getInstance();
  // obtém as configurações do App
  final appSettingsStorageService = AppSettingsStorageService();
  final appSettings = await appSettingsStorageService.getSettings();

  // cria o router
  final router = buildRouter(showSettingsFirst: appSettings.showSettingsFirst);

  runApp(ProviderScope(child: MyApp(router: router)));
}

class MyApp extends ConsumerStatefulWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(localeProvider);

    return themeModeAsync.when(
      data: (themeMode) {
        return localeAsync.when(
          data: (locale) {
            return MaterialApp.router(
              title: 'DayCalc',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: _getThemeMode(themeMode),
              routerConfig: widget.router,
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
