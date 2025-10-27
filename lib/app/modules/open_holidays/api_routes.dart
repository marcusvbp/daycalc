import 'package:daycalc/base/models/api/api_routes_foundation.dart';

class OpenHolidaysApiRoutes extends ApiRoutesFoundation {
  @override
  Map<String, String> get routes => {
    'public-holidays': '/PublicHolidays',
    'public-holidays-by-date': '/PublicHolidaysByDate',
    'school-holidays': '/SchoolHolidays',
    'school-holidays-by-date': '/SchoolHolidaysByDate',
    'countries': '/Countries',
    'languages': '/Languages',
  };
}
