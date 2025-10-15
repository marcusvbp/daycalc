class LocalizedText {
  final String language;
  final String text;

  LocalizedText({required this.language, required this.text});

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      language: json['language'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'language': language,
        'text': text,
      };
}