import 'package:daycalc/app/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<Dio>((ref) {
  var dio = Dio(BaseOptions(baseUrl: openHolidaysApiUrl));

  return dio;
});
