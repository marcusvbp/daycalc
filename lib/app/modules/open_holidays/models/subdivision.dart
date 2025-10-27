class Subdivision {
  final String code;
  final String shortName;

  Subdivision({required this.code, required this.shortName});

  factory Subdivision.fromJson(Map<String, dynamic> json) {
    return Subdivision(
      code: json['code'] as String? ?? '',
      shortName: json['shortName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'shortName': shortName,
      };
}