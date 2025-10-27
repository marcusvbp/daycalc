import 'localized_text.dart';
import 'subdivision.dart';

class PublicHoliday {
  final String id;
  final String startDate;
  final String endDate;
  final String type;
  final List<LocalizedText> name;
  final String? regionalScope;
  final String? temporalScope;
  final bool nationwide;
  final List<Subdivision> subdivisions;
  final List<dynamic>? comment;

  PublicHoliday({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.name,
    required this.nationwide,
    required this.subdivisions,
    this.regionalScope,
    this.temporalScope,
    this.comment,
  });

  factory PublicHoliday.fromJson(Map<String, dynamic> json) {
    final namesJson = json['name'] as List<dynamic>? ?? const [];
    final subdivisionsJson = json['subdivisions'] as List<dynamic>? ?? const [];
    final commentJson = json['comment'] as List<dynamic>?;
    return PublicHoliday(
      id: json['id'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      type: json['type'] as String? ?? '',
      name: namesJson
          .map((e) => LocalizedText.fromJson(e as Map<String, dynamic>))
          .toList(),
      regionalScope: json['regionalScope'] as String?,
      temporalScope: json['temporalScope'] as String?,
      nationwide: (json['nationwide'] as bool?) ?? false,
      subdivisions: subdivisionsJson
          .map((e) => Subdivision.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: commentJson,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'startDate': startDate,
        'endDate': endDate,
        'type': type,
        'name': name.map((e) => e.toJson()).toList(),
        'regionalScope': regionalScope,
        'temporalScope': temporalScope,
        'nationwide': nationwide,
        'subdivisions': subdivisions.map((e) => e.toJson()).toList(),
        if (comment != null) 'comment': comment,
      };
}