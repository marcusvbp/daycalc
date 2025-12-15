import 'dart:io';

const hideAdmob = bool.fromEnvironment('HIDE_ADMOB');

const admobInterstitialAndroid = String.fromEnvironment(
  'ADMOB_INTERSTITIAL_ANDROID',
);
const admobInterstitialIos = String.fromEnvironment('ADMOB_INTERSTITIAL_IOS');

const admobHomeAndroid = String.fromEnvironment('ADMOB_HOME_ANDROID');
const admobHomeIos = String.fromEnvironment('ADMOB_HOME_IOS');

const admobFeriadoAndroid = String.fromEnvironment('ADMOB_FERIADO_ANDROID');
const admobFeriadoIos = String.fromEnvironment('ADMOB_FERIADO_IOS');

final admobHomeId = Platform.isAndroid ? admobHomeAndroid : admobHomeIos;

final admobInterstitialId = Platform.isAndroid
    ? admobInterstitialAndroid
    : admobInterstitialIos;

const admobHistoricoAndroid = String.fromEnvironment('ADMOB_HISTORICO_ANDROID');
const admobHistoricoIos = String.fromEnvironment('ADMOB_HISTORICO_IOS');

final admobHistoricoId = Platform.isAndroid
    ? admobHistoricoAndroid
    : admobHistoricoIos;

final admobFeriadoId = Platform.isAndroid
    ? admobFeriadoAndroid
    : admobFeriadoIos;

const openHolidaysApiUrl = String.fromEnvironment('OPEN_HOLIDAYS_API_URL');
const openHolidaysMaxInterval = int.fromEnvironment(
  'OPEN_HOLIDAYS_MAX_INTERVAL',
);
