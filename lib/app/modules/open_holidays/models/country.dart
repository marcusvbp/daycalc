import 'localized_text.dart';

class Country {
  final String isoCode;
  final List<LocalizedText> name;
  final List<String> officialLanguages;

  Country({
    required this.isoCode,
    required this.name,
    required this.officialLanguages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final namesJson = json['name'] as List<dynamic>? ?? const [];
    final languagesJson = json['officialLanguages'] as List<dynamic>? ?? const [];
    return Country(
      isoCode: json['isoCode'] as String? ?? '',
      name: namesJson
          .map((e) => LocalizedText.fromJson(e as Map<String, dynamic>))
          .toList(),
      officialLanguages: languagesJson.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'isoCode': isoCode,
        'name': name.map((e) => e.toJson()).toList(),
        'officialLanguages': officialLanguages,
      };
}