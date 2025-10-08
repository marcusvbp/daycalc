import 'dart:io';

const admobInterstitialAndroid = String.fromEnvironment(
  'ADMOB_INTERSTITIAL_ANDROID',
);
const admobInterstitialIos = String.fromEnvironment('ADMOB_INTERSTITIAL_IOS');

const admobHomeAndroid = String.fromEnvironment('ADMOB_HOME_ANDROID');
const admobHomeIos = String.fromEnvironment('ADMOB_HOME_IOS');

final admobHomeId = Platform.isAndroid ? admobHomeAndroid : admobHomeIos;

final admobInterstitialId = Platform.isAndroid
    ? admobInterstitialAndroid
    : admobInterstitialIos;

const admobHistoricoAndroid = String.fromEnvironment('ADMOB_HISTORICO_ANDROID');
const admobHistoricoIos = String.fromEnvironment('ADMOB_HISTORICO_IOS');

final admobHistoricoId = Platform.isAndroid
    ? admobHistoricoAndroid
    : admobHistoricoIos;
