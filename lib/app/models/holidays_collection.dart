import 'package:daycalc/app/modules/open_holidays/models/country.dart';
import 'package:daycalc/app/modules/open_holidays/models/public_holiday.dart';
import 'package:flutter/widgets.dart';

class HolidaysCollection {
  final List<PublicHoliday> publicHolidays;
  final List<PublicHoliday> schoolHolidays;
  final int createdAt;
  final Locale locale;
  final Country country;

  HolidaysCollection({
    required this.publicHolidays,
    required this.schoolHolidays,
    required this.createdAt,
    required this.locale,
    required this.country,
  });

  factory HolidaysCollection.fromJson(Map<String, dynamic> json) {
    return HolidaysCollection(
      publicHolidays: (json['publicHolidays'] as List)
          .map((e) => PublicHoliday.fromJson(e))
          .toList(),
      schoolHolidays: (json['schoolHolidays'] as List)
          .map((e) => PublicHoliday.fromJson(e))
          .toList(),
      createdAt: json['createdAt'] as int,
      locale: Locale(json['locale'] as String),
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'publicHolidays': publicHolidays.map((e) => e.toJson()).toList(),
    'schoolHolidays': schoolHolidays.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
    'locale': locale.toString(),
    'country': country.toJson(),
  };

  List<PublicHoliday> get allHolidaysSorted {
    final merged = <PublicHoliday>[...publicHolidays, ...schoolHolidays];
    merged.sort((a, b) {
      final DateTime? aDate =
          DateTime.tryParse(a.startDate) ?? DateTime.tryParse(a.endDate);
      final DateTime? bDate =
          DateTime.tryParse(b.startDate) ?? DateTime.tryParse(b.endDate);
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return bDate.compareTo(aDate);
    });
    return merged;
  }
}
