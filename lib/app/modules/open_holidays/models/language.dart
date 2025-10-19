import 'localized_text.dart';

class Language {
  final String isoCode;
  final List<LocalizedText> name;

  Language({required this.isoCode, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    final namesJson = json['name'] as List<dynamic>? ?? const [];
    return Language(
      isoCode: json['isoCode'] as String? ?? '',
      name: namesJson
          .map((e) => LocalizedText.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'isoCode': isoCode,
        'name': name.map((e) => e.toJson()).toList(),
      };
}