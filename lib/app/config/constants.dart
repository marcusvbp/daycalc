import 'dart:io';

const admobAndroid = String.fromEnvironment('ADMOB_ANDROID');
const admobIos = String.fromEnvironment('ADMOB_IOS');
final admobId = Platform.isAndroid ? admobAndroid : admobIos;
