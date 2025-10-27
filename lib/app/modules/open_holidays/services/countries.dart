import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daycalc/app/modules/open_holidays/api_routes.dart';
import 'package:daycalc/app/providers/http_client_provider.dart';
import 'package:daycalc/app/modules/open_holidays/models/country.dart';

class CountriesService {
  final Ref ref;
  late final Dio _http;
  final OpenHolidaysApiRoutes _routes = OpenHolidaysApiRoutes();

  CountriesService({required this.ref}) {
    _http = ref.read(httpClientProvider);
  }

  Future<List<Country>> listCountries({
    Map<String, dynamic>? queryParameters,
  }) async {
    final path = _routes.getRoute('countries');
    final response = await _http.get(path!, queryParameters: queryParameters);
    final data = response.data as List<dynamic>;
    return data
        .map((e) => Country.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}