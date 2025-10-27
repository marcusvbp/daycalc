import 'package:daycalc/app/modules/open_holidays/api_routes.dart';
import 'package:daycalc/app/modules/open_holidays/models/language.dart';
import 'package:daycalc/app/providers/http_client_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagesService {
  final Ref ref;
  late final Dio _http;
  final OpenHolidaysApiRoutes _routes = OpenHolidaysApiRoutes();

  LanguagesService(this.ref) {
    _http = ref.read(httpClientProvider);
  }

  Future<List<Language>> getLanguages() async {
    final response = await _http.get(_routes.getRoute('languages')!);

    final data = response.data;
    if (data is List) {
      return data
          .map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
