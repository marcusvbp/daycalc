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
}
