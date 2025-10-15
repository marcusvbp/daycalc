import 'package:daycalc/app/modules/open_holidays/models/country.dart';

class CountriesCollection {
  final List<Country> countries;
  final int createdAt;

  CountriesCollection({this.countries = const [], this.createdAt = 0});

  Map<String, dynamic> toJson() => {
    'countries': countries.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
  };

  factory CountriesCollection.fromJson(Map<String, dynamic> json) =>
      CountriesCollection(
        countries: (json['countries'] as List<dynamic>)
            .map((e) => Country.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt: json['createdAt'] as int,
      );
}
