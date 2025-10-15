import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daycalc/app/modules/open_holidays/api_routes.dart';
import 'package:daycalc/app/providers/http_client_provider.dart';
import 'package:daycalc/app/modules/open_holidays/models/school_holiday.dart';

class SchoolHolidaysService {
  final Ref ref;
  late final Dio _http;
  final OpenHolidaysApiRoutes _routes = OpenHolidaysApiRoutes();

  SchoolHolidaysService({required this.ref}) {
    _http = ref.read(httpClientProvider);
  }

  Future<List<SchoolHoliday>> listSchoolHolidays(
    Map<String, dynamic> queryParameters,
  ) async {
    final path = _routes.getRoute('school-holidays');
    final response = await _http.get(path!, queryParameters: queryParameters);
    final data = response.data as List<dynamic>;
    return data
        .map((e) => SchoolHoliday.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<SchoolHoliday>> listSchoolHolidaysByDate(
    Map<String, dynamic> queryParameters,
  ) async {
    final path = _routes.getRoute('school-holidays-by-date');
    final response = await _http.get(path!, queryParameters: queryParameters);
    final data = response.data as List<dynamic>;
    return data
        .map((e) => SchoolHoliday.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}